
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyServer(function(input, output) {
                
  output$plot <- renderPlot({
          inFiles <- input$files
          if (is.null(inFiles)) return(NULL)
          contentss <- read.csv(inFiles$datapath,
                                skip=input$skips,
                                nrows=input$nrowss,
                                sep = ",",comment.char="",
                                colClasses = c('numeric','numeric'),
                                col.names = c('time','cps'), na.strings = NA)
          # input mass(fg)
          mass <- input$dwell*(input$nrowss - 1)*input$flow*input$con/60
          # get nano particle mass ele in g/ml
          ele <- switch(input$element, 
                        "Au" = 19.3,
                        "Ag" = 10.49,
                        "SiO2" = 2.634,
                        "TiO2" = 4.23,
                        "ZnO" = 5.606)
          nanomass <- (4/3)*pi*(input$di/2)^3*ele/10000000
          # get nano particle signals and relationship between signal and mass
          realsignal <- contentss$cps[contentss$cps>=input$threshold]-input$threshold
          signalmean <- mean(contentss$cps[contentss$cps>=input$threshold])-input$threshold
          massratio <- signalmean/nanomass
          realmass <- realsignal/massratio
          realdi <- (realmass*60000000/(pi*ele))^(1/3)
          # get signal response
          backgroundcounts <- sum(contentss$cps<input$threshold)
          signalcounts <- input$nrowss-backgroundcounts
          # get nebulazition efficiency
          neb <- signalcounts/(mass/nanomass)
          
          inFile <- input$file
          if (is.null(inFile)) return(NULL)
          contents <- read.csv(inFile$datapath,
                               skip=input$skips,
                               nrows=input$nrowss,
                               sep = ",",comment.char="",
                               colClasses = c('numeric','numeric'),
                               col.names = c('time','cps'), na.strings = NA)
          realsignals <- contents$cps[contents$cps>=input$threshold]-input$threshold
          realmasss <- realsignals/massratio
          realdis <- (realmasss*60000000/(pi*ele))^(1/3)
          mediansample <- median(realdis)
          samplecon <- realmasss/(input$dwell*(input$nrowss - 1)*input$flow)
          # get signal response
          backgroundcount <- sum(contents$cps<input$threshold)
          signalcount <- input$nrowss-backgroundcounts
          # counts per ml
          numcon <- signalcount/neb/60000
          # for one cell mode
          realnum <- realmasss/nanomass
          medianrealnum <- median(realnum)
          par(mfrow = c(1,3))
          hist(realdi,probability = TRUE,breaks = input$breaks, xlab = "diameter(nm)", main = "standard")
           dens <- density(realdi, adjust = input$bw_adjust)
           lines(dens, col = "blue", ylab = '')
          hist(realdis,probability = TRUE,breaks = input$breaks, xlab = "diameter(nm)", main = "sample")
          den <- density(realdis, adjust = input$bw_adjust)
          lines(den, col = "red")
          hist(realnum,breaks = input$breaks, xlab = "counts", main = "one cell mode")
  })
  
  output$print <- renderTable({
          inFiles <- input$files
          if (is.null(inFiles)) return(NULL)
          contentss <- read.csv(inFiles$datapath,
                                skip=input$skips,
                                nrows=input$nrowss,
                                sep = ",",comment.char="",
                                colClasses = c('numeric','numeric'),
                                col.names = c('time','cps'), na.strings = NA)
          # input mass(fg)
          mass <- input$dwell*(input$nrowss - 1)*input$flow*input$con/60
          # get nano particle mass ele in g/ml
          ele <- switch(input$element, 
                        "Au" = 19.3,
                        "Ag" = 10.49,
                        "SiO2" = 2.634,
                        "TiO2" = 4.23,
                        "ZnO" = 5.606)
          nanomass <- (4/3)*pi*(input$di/2)^3*ele/10000000
          # get nano particle signals and relationship between signal and mass
          realsignal <- contentss$cps[contentss$cps>=input$threshold]-input$threshold
          signalmean <- mean(contentss$cps[contentss$cps>=input$threshold])-input$threshold
          massratio <- signalmean/nanomass
          realmass <- realsignal/massratio
          realdi <- (realmass*60000000/(pi*ele))^(1/3)
          # get signal response
          backgroundcounts <- sum(contentss$cps<input$threshold)
          signalcounts <- input$nrowss-backgroundcounts
          # get nebulazition efficiency
          neb <- signalcounts/(mass/nanomass)
          numconstd <- signalcounts/neb/60000
          medianstd <- median(realdi)
          
          inFile <- input$file
          if (is.null(inFile)) return(NULL)
          contents <- read.csv(inFile$datapath,
                               skip=input$skips,
                               nrows=input$nrowss,
                               sep = ",",comment.char="",
                               colClasses = c('numeric','numeric'),
                               col.names = c('time','cps'), na.strings = NA)
          realsignals <- contents$cps[contents$cps>=input$threshold]-input$threshold
          realmasss <- realsignals/massratio
          realdis <- (realmasss*60000000/(pi*ele))^(1/3)
          mediansample <- median(realdis)
          
          # get signal response
          backgroundcount <- sum(contents$cps<input$threshold)
          signalcount <- input$nrowss-backgroundcounts
          samplecon <- sum(realmasss/(input$dwell*signalcount*input$flow/60))
          # counts per ml
          numcon <- signalcount/neb/60000
          
          # for one cell mode
          realnum <- realmasss/nanomass
          medianrealnum <- format(round(median(realnum), 2))
          
          signalcounts <- format(round(signalcounts/60000, 6), nsmall = 6)
          signalcount <- format(round(signalcount/60000, 6), nsmall = 6)
          numconstd <- format(round(numconstd, 2), nsmall = 2)
          neb <- format(round(neb, 2), nsmall = 2)
          medianstd <- format(round(medianstd, 2), nsmall = 2)
          samplecon <- format(round(samplecon, 2), nsmall = 2)
          numcon <- format(round(numcon, 2), nsmall = 2)
          mediansample <- format(round(mediansample, 2), nsmall = 2)
          title <- c('concentration(ng/L)','raw number concentration(counts per mL)','number concentration(counts per mL)','median diameter(nm)','nebulazition efficiency','cell mode median number')
          standard <- c(input$con,signalcounts,numconstd,medianstd,neb,0)
          sample <- c(samplecon,signalcount,numcon,mediansample,neb,medianrealnum)
          data <- data.frame(standard,sample)
          rownames(data) <- title
          return(data)
  })
})
