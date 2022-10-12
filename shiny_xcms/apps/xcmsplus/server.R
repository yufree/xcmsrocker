# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
# You might need the develop version of enviGCMS to run this app. Try `devtools::install_github('yufree/enviGCMS')`
library(shiny)
library(xcms)
library(DT)

source('sva.R')
source('dart.R')
source('mzrtsim.R')
source('mzrt.R')

xy_str <- function(e) {
        if(is.null(e)) return("NULL\n")
        paste0("RT=", round(e$x, 1), "s m/z=", round(e$y, 4), "\n")
}

shinyServer(function(input, output) {
        # data input
        datainput <- reactive({
                if (!is.null(input$file)){
                        dataraw <- read.csv(input$file$datapath,skip = 1)
                        mz <- dataraw[,2]
                        rt <- dataraw[,3]
                        data <- dataraw[,-c(1:3)]
                        group <- data.frame(t(read.csv(input$file$datapath,nrows = 1)[-(1:3)]))
                        colnames(group) <- c(1:ncol(group))
                        colnames(data) <- rownames(group)
                        rownames(data) <- dataraw[,1]
                        return(list(data=data,mz=mz,rt=rt,group=group))
                }else{
                        return(NULL)
                }
        })
        # peaklist filter
        datafilter <- reactive({
                li <- datainput()
                list = getdoe(li,inscf = input$ins, rsdcf = input$rsd, imputation = 'l', tr = F)
                
                dt <- cbind.data.frame(list$mzfiltered, list$rtfiltered, list$groupmeanfiltered,list$groupsdfiltered,list$grouprsdfiltered,list$datafiltered)
                colnames(dt) <- c('mz','rt',paste0(colnames(list$groupmean),'mean'),paste0(colnames(list$groupmean),'sd'),paste0(colnames(list$groupmean),'rsd%'),colnames(list$datafiltered))
                return(dt)
        })
        # show the table
        output$datatable <- DT::renderDataTable({
                datafilter()
        })
        # show the download
        output$data = downloadHandler('mzrt-filtered.csv', content = function(file) {
                datafilter()
                write.csv(dt, file)
        })
        # plotmr
        ranges <- reactiveValues(x = NULL, y = NULL)
        output$plotmr <- renderPlot({
                li <- datainput()
                plotmr(li,
                                rsdcf = input$rsd,
                                inscf = input$ins)
         })
        output$plotmrs <- renderPlot({
                li <- datainput() 
                plotmr(li,
                               rsdcf = input$rsd,
                               inscf = input$ins,
                               ms = ranges$y,
                               rt = ranges$x)
        })

        observe({
                brush <- input$plotmrs_brush
                if (!is.null(brush)) {
                        ranges$x <- c(brush$xmin, brush$xmax)
                        ranges$y <- c(brush$ymin, brush$ymax)

                } else {
                        ranges$x <- NULL
                        ranges$y <- NULL
                }
        })
        output$info <- renderText({
                paste0(
                        "click: ", xy_str(input$plot_click),
                        "hover: ", xy_str(input$plot_hover)
                )
        })
        output$info2 <- renderText({
                paste0(
                        "click: ", xy_str(input$plot_click2),
                        "hover: ", xy_str(input$plot_hover2)
                )
        })

        output$brush_info <- renderDataTable({
                data <- datafilter()
                brushedPoints(data, input$plotmrs_brush, "rt","mz")
        })
        # show the download
        output$dataselect = downloadHandler('mzrt-selected.csv', content = function(file) {
                datafilter()
                write.csv(brush_info, file)
        })

        
        # plotpca
        output$plotpca <- renderPlot({
                list <- datainput()
                plotpca(list$data,lv = as.character(list$group[,1]))
        })

        
        # DART analysis
        output$dart <- renderPlot({
                if (is.null(input$filedart$datapath))
                        return()
                else
                        data <- xcms::xcmsRaw(input$filedart$datapath)
                plotdart(data, cf = input$insdart)
        })
        
        output$darttic <- renderPlot({
                if (is.null(input$filedart$datapath))
                        return()
                else
                        data <- xcms::xcmsRaw(input$filedart$datapath)
                xcms::plotTIC(data)
        })
        
        output$dartms <- renderPlot({
                if (is.null(input$filedart$datapath))
                        return()
                else
                        data <- xcms::xcmsRaw(input$filedart$datapath)
                plotdartms(data)
        })
        
        dartfilter <- reactive({
                if (!is.null(input$filedart2)){
                        re <- xcms::xcmsRaw(input$filedart2$datapath[1],profstep = as.numeric(input$step))
                        MZ <- xcms::profMz(re)
                        value <- NULL
                        for(i in input$filedart2$datapath){
                                data <- xcms::xcmsRaw(i,profstep = as.numeric(input$step))
                                pf <- xcms::profMat(data)
                                rownames(pf) <- mz <- xcms::profMz(data)
                                colnames(pf) <- rt <- data@scantime
                                mzins <- apply(pf,1,sum)/length(unique(rt))
                                MZ0 <- MZ
                                MZ <- intersect(MZ,mz)
                                value <- cbind(value[MZ0 %in% MZ,], mzins[mz %in% MZ])
                        }
                        value <- value[apply(value, 1, function(x) !all(x==0)),]
                        colnames(value) <- input$filedart2$name
                        return(value)
                }else{
                        return(NULL)
                }
        })
        # show the table
        output$darttable <- DT::renderDataTable({
                dartfilter()
        })
        # show the download
        output$datadart = downloadHandler('dart-filtered.csv', content = function(file) {
                write.csv(dartfilter(), file)
        })
        
        # simulation data
        sim <- reactive({
                return(mzrtsim(npeaks = 2000, ncomp = input$ncomp, ncpeaks = input$ncpeaks, nbpeaks = input$nbpeaks))
        })
        output$sim0 <- renderPlot({
                sim <- sim()
                simroc(sim)
        })
        
        output$sim1 <- renderPlot({
                sim <- sim()
                ridgesplot(sim$data, as.factor(sim$con))
        })
        output$sim2 <- renderPlot({
                sim <- sim()
                sim2 <- svacor2(log(sim$data), as.factor(sim$con))
                par(mfrow = c(1,2))
                hist(sim2$`p-valuesCorrected`,main = 'p value corrected',xlab = "")
                hist(sim2$`p-values`,main = 'p value',xlab = '')
        })
        output$sim3 <- renderPlot({
                sim <- sim()
                sim2 <- isvacor(log(sim$data), as.factor(sim$con))
                par(mfrow = c(1,2))
                hist(sim2$`p-valuesCorrected`,main = 'p value corrected',xlab = "")
                hist(sim2$`p-values`,main = 'p value',xlab = "")
        })
        # show the table
        output$simdata <- DT::renderDataTable({
                sim <- sim()
                rbind.data.frame(sim$con,sim$data)
        })
        # show the download
        output$simdatad = downloadHandler('simdata.csv', content = function(file) {
                sim <- sim()
                data <- rbind.data.frame(sim$con,sim$data)
                write.csv(data, file)
        })
        # show the heatmap
        output$simdatah <- renderPlot({
                sim <- sim()
                simplot(log(sim$data),lv = factor(sim$con))
        })
        # show the table
        output$simbatchall <- DT::renderDataTable({
                sim <- sim()
                rbind.data.frame(sim$con,sim$matrix)
        })
        # show the download
        output$simbatchalld = downloadHandler('batchmatrix.csv', content = function(file) {
                sim <- sim()
                data <- rbind.data.frame(sim$con,sim$matrix)
                write.csv(data, file)
        })
        # show the heatmap
        output$simbatchallh <- renderPlot({
                sim <- sim()
                simplot(log(sim$matrix),lv = factor(sim$batch))
        })
        # show the table
        output$simbatch <- DT::renderDataTable({
                sim <- sim()
                rbind.data.frame(sim$con,sim$batch,sim$bmatrix)
        })
        # show the download
        output$simbatchd = downloadHandler('batch.csv', content = function(file) {
                sim <- sim()
                data <- rbind.data.frame(sim$batch,sim$bmatrix)
                write.csv(data, file)
        })
        # show the heatmap
        output$simbatchh <- renderPlot({
                sim <- sim()
                simplot(log(sim$bmatrix),lv = factor(sim$batch))
        })
        # show the table
        output$simcon <- DT::renderDataTable({
                sim <- sim()
                rbind.data.frame(sim$con,sim$cmatrix)
        })
        # show the download
        output$simcond = downloadHandler('con.csv', content = function(file) {
                sim <- sim()
                data <- rbind.data.frame(sim$con,sim$cmatrix)
                write.csv(data, file)
        })
        # show the heatmap
        output$simconh <- renderPlot({
                sim <- sim()
                simplot(log(sim$cmatrix),lv = factor(sim$con))
        })
        
        
        
        
})
