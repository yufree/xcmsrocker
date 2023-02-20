
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(rcdk)
source('GetIntergration.R')
source('Getisotopologues.R')
shinyServer(function(input, output) {
        output$select <- renderTable({
                Getisotopologues(input$formula,charge = '1',width = input$width)
        })
        output$plot0 <- renderPlot({
                formula <- get.formula(input$formula, charge = 1)
                isotopes <- get.isotopes.pattern(formula,minAbund=0.00000001)
                temp <- Getisotopologues(input$formula,charge = '1',width = input$width)
                temp <- as.vector(t(temp))
                temp <- as.numeric(temp)[1:2]
                xmin <- min(temp)-10
                xmax <- max(temp)+10
                plot(isotopes,
                     type="h",
                     xlim=c(xmin,xmax),
                     xlab="m/z", 
                     ylab="Intensity",
                     frame.plot = F)
                
        })
        output$plot <- renderPlot({ 
                        inFilel <- input$filel               
                        if (is.null(inFilel))
                                return(NULL)
                        contentsl <- read.table(inFilel$datapath,
                                                skip=input$skipl,
                                                nrows=input$nrowsh,
                                                sep = ",",
                                                comment.char="",
                                                colClasses = c('numeric','numeric'),col.names = c('RT','Intensity'), na.strings = NA)
                        inFileh <- input$fileh                
                        if (is.null(inFileh))
                                return(NULL)
                        contentsh <-read.table(inFileh$datapath,
                                               skip=input$skiph,
                                               nrows=input$nrowsh,
                                               sep = ",",
                                               comment.char="",
                                               colClasses = c('numeric','numeric'),
                                               col.names = c('RT','Intensity'), na.strings = NA)
                        xl <- GetIntegration(contentsl,
                                             min_rt = input$minrt,
                                             max_rt = input$maxrt,
                                             n = input$n,
                                             m = input$m,
                                             start_slope = input$startslope,
                                             stop_slope = input$stopslope, 
                                             baseline = input$baseline,
                                             noslope = input$noslope, 
                                             smoothit = input$smoothit,
                                             half = input$half)
                        xh <- GetIntegration(contentsh,
                                             min_rt = input$minrt,
                                             max_rt = input$maxrt,
                                             n = input$n,
                                             m = input$m,
                                             start_slope = input$startslope,
                                             stop_slope = input$stopslope, 
                                             baseline = input$baseline,
                                             noslope = input$noslope, 
                                             smoothit = input$smoothit,
                                             half = input$half)
                        # plot the result
                        par(mfrow = c(2,1),mar=c(4,4,2,2),oma=c(0,0,0,0))
                        # light molecular
                        plot(xl$RTrange,xl$signal,xlab="time (min)",ylab="counts per second",col = 'red', type = 'l',
                             ylim = c(-0.02*max(xl$signal),1.02*max(xl$signal)), main= paste('Peak'))
                        # annotation of light molecular
                        lines(c(xl$rtstart, xl$rtend),c(xl$sigstart, xl$sigend),"l", col = "red") 
                        lines(c(xl$RTrange[xl$scanstart-xl$baseline+1], xl$rtstart), c(xl$sigstart, xl$sigstart),"l", col = "red") 
                        lines(c(xl$rtend,xl$RTrange[xl$scanend+xl$baseline-1]), c(xl$sigend, xl$sigend),"l", col = "red")
                        lines(c(xl$rtstart,xl$rtstart),c(0.8*xl$sigstart, xl$sigstart*1.2), "l", col="red") 
                        lines(c(xl$rtend,xl$rtend), c(0.8*xl$sigend, xl$sigend*1.2), "l", col="red") 
                        # heavy molecular
                        lines(xh$RTrange,xh$signal,col = "darkgreen",type = 'l')
                        # annotation of heavy molecular
                        lines(c(xh$rtstart, xh$rtend),c(xh$sigstart, xh$sigend),"l", col = "darkgreen") 
                        lines(c(xh$RTrange[xh$scanstart-xh$baseline+1], xh$rtstart), c(xh$sigstart, xh$sigstart),"l", col = "darkgreen") 
                        lines(c(xh$rtend,xh$RTrange[xh$scanend+xh$baseline-1]), c(xh$sigend, xh$sigend),"l", col = "darkgreen") 
                        lines(c(xh$rtstart,xh$rtstart),c(0.8*xh$sigstart, xh$sigstart*1.2), "l", col="darkgreen") 
                        lines(c(xh$rtend,xh$rtend), c(0.8*xh$sigend, xh$sigend*1.2), "l", col="darkgreen") 
                        
                        # print heights & areas
                        text(xl$rtpeak-0.05,xl$sigpeak*.7,paste("area:", format(xl$area,digits=2)),col="red") 
                        text(xl$rtpeak-0.05,xl$sigpeak*.9,paste("height:",format(xl$sigpeak, digits=2)),col="red")
                        text(xh$rtpeak+0.05,xh$sigpeak*.7,paste("area:", format(xh$area,digits=2)),col="darkgreen") 
                        text(xh$rtpeak+0.05,xh$sigpeak*.9,paste("height:",format(xh$sigpeak, digits=2)),col="darkgreen")
                        # add legend
                        legend('bottomright',c('light isotopologue','heavy isotopologue'),col = c('red','darkgreen'),lty = c(1,1))
                        
                        #plot slope
                        plot(xl$RTrange,xl$slopedata,xlab="time (min)",ylab="slope","l",col = 'red',main=paste('Slope')) 
                        lines(xh$RTrange,xh$slopedata,col = 'darkgreen',type = 'l')
                        # slope annotation of light molecular
                        lines(c(xl$rtstart,xl$rtstart),c(-.1*max(xl$slopedata), .1*max(xl$slopedata)), "l", col="red") 
                        lines(c(xl$rtend,xl$rtend), c(-.1*max(xl$slopedata), .1*max(xl$slopedata)), "l", col="red") 
                        lines(c(xl$rtpeak,xl$rtpeak), c(-.5*max(xl$slopedata), .5*max(xl$slopedata)), "l", col="red")
                        # slope annotation of heavy molecular
                        lines(c(xh$rtstart,xh$rtstart),c(-.1*max(xh$slopedata), .1*max(xh$slopedata)), "l", col="darkgreen") 
                        lines(c(xh$rtend,xh$rtend), c(-.1*max(xh$slopedata), .1*max(xh$slopedata)), "l", col="darkgreen") 
                        lines(c(xh$rtpeak,xh$rtpeak), c(-.5*max(xh$slopedata), .5*max(xh$slopedata)), "l", col="darkgreen")
                        # add legend
                        legend('bottomright',c('light isotopologue','heavy isotopologue'),col = c('red','darkgreen'),lty = c(1,1))
        })
        output$table <- renderTable({
                inFilel <- input$filel               
                if (is.null(inFilel))
                        return(NULL)
                contentsl <- read.table(inFilel$datapath,
                                        skip=input$skipl,
                                        nrows=input$nrowsh,
                                        sep = ",",
                                        comment.char="",
                                        colClasses = c('numeric','numeric'),col.names = c('RT','Intensity'), na.strings = NA)
                inFileh <- input$fileh                
                if (is.null(inFileh))
                        return(NULL)
                contentsh <-read.table(inFileh$datapath,
                                       skip=input$skiph,
                                       nrows=input$nrowsh,
                                       sep = ",",
                                       comment.char="",
                                       colClasses = c('numeric','numeric'),
                                       col.names = c('RT','Intensity'), na.strings = NA)
                par(mfrow = c(1,1),mai = c(4,4,2,2),oma=c(0,0,0,0))
                xl <- GetIntegration(contentsl,
                                     min_rt = input$minrt,
                                     max_rt = input$maxrt,
                                     n = input$n,
                                     m = input$m,
                                     start_slope = input$startslope,
                                     stop_slope = input$stopslope, 
                                     baseline = input$baseline,
                                     noslope = input$noslope, 
                                     smoothit = input$smoothit,
                                     half = input$half)
                xh <- GetIntegration(contentsh,
                                     min_rt = input$minrt,
                                     max_rt = input$maxrt,
                                     n = input$n,
                                     m = input$m,
                                     start_slope = input$startslope,
                                     stop_slope = input$stopslope, 
                                     baseline = input$baseline,
                                     noslope = input$noslope, 
                                     smoothit = input$smoothit,
                                     half = input$half)
                data <- list(xl,xh)
                area <- sapply(data,function(x) x$area)
                height <- sapply(data,function(x) x$height)
                arearatio <- area[1]/area[2]
                heightratio <- height[1]/height[2]
                temp <- Getisotopologues(input$formula,charge = '1',width = input$width)
                temp <- as.vector(t(temp))
                ratiostd <- as.numeric(temp[3])
                areadelta <- (arearatio - ratiostd)/ratiostd*1000
                heightdelta <- (heightratio - ratiostd)/ratiostd*1000
                ratio <- c(as.character(round(arearatio,4)),as.character(round(heightratio,4)))
                deltaratio <- c(as.character(round(areadelta,4)),as.character(round(heightdelta,4)))
                ratio <- data.frame(cbind(ratio,deltaratio))
                colnames(ratio) <- c('original ratio','delta ratio')
                rownames(ratio) <- c('peak area','peak height')
                return(ratio)
        })
})
