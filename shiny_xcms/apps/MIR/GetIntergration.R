GetIntegration <- function(data, min_rt = 8.6 , max_rt = 9, n=5, m=5, start_slope = 2, stop_slope = 2, baseline = 20, noslope = T, smoothit = T, half = F,...){
        # file should be a dataframe with the first column RT and second column intensity of the SIM ions.
        # min_rt and max_rt is a rough RT range contained only one peak to get the area
        # n stands for points in the moving average smooth box
        # m stands for numbers of points for regression to get the slope
        # start_slope and stop_slope stand for the threshold value for start & stop peak (%max slope)
        # baseline stand for the points for the signal baseline
        # noslope stands for if using a horizon line to get area or not
        # smoothit stands for if using an average smooth box or not
        # half stands for if using the left half peak to caculate the area
        # subset the data
        subdata <- data[data[,1] > min_rt&data[,1] < max_rt,]
        # get the signal and the RT
        RTrange <- subdata[,1]
        signal <- subdata[,2]
        # data smooth
        if(smoothit==T) {
                ma <- function(x,n){filter(x,rep(1/n,n),circular = T)}
                signal <- ma(signal,n)
        }
        # get the slope data
        RTrangemsec <- RTrange*60*1e3
        slopedata <- signal
        back <- round(m/2)
        forth <- m-back
        if(m>2){
                for(i in (back+1):(length(signal)-forth)){
                        slopedata[i] <- coef(lm(signal[(i-back+1):(i+forth)] ~ RTrangemsec[(i-back+1):(i+forth)]))[2]
                }
                slopedata[1:back] <- slopedata[back+1] # first few points
                slopedata[(length(signal)-forth-1):length(signal)] <- slopedata[(length(signal)-forth)]# last few points
        }else{
                # for n = 2 points; without linear regression (much faster)
                # time per scan in millisec
                delta_t <- (t[length(RTrangemsec)]-RTrangemsec[1]/(length(RTrangemsec)-1)) 
                for(i in 2:length(signal)) {
                        slopedata[i] <- (signal[i]-signal[i-1])/delta_t
                }
                slopedata[1] <- 0
        }
        # search for peak start 
        i <- baseline
        while((slopedata[i]<=(start_slope/100*max(slopedata)))&(i<length(signal))) i <- i+1
        rtstart <- RTrange[i] # peak start found
        scanstart <- i # (slope > threshold)
        sigstart <- mean(signal[(i-baseline+1):i]) # baseline intensity found
        # search for peak top
        i <- which.max(slopedata) # jump to slope max. 
        while((slopedata[i]>=0)&(i<(length(signal)-baseline))) i <- i+1 
        rtpeak <- RTrange[i] # peak top found 
        scanpeak <- i # (slope = 0) 
        sigpeak <- signal[i]
        # search for peak end
        i <- which.min(slopedata) # jump to slope min. 
        while((slopedata[i]<= -(stop_slope/100*max(slopedata))) & (i<(length(signal)-baseline))) i <- i+1 
        rtend <- RTrange[i] # peak end found 
        scanend <- i # (-slope < threshold) 
        sigend <- mean(signal[i:(i+ baseline-1)])
        # if background without slope
        if(!noslope) sigend <- sigstart 
        # subtract background from signal
        background <- signal
        for(i in scanstart:scanend) { # get background 
                background[i] <- sigstart+(sigend-sigstart)/(scanend-scanstart)*(i-scanstart) 
        }
        subsignal <- signal-background
        # get the length of the signal
        lengthsig <- length(scanstart:scanend)
        # calculate area; using a Riemann integral (dimension: intensity x min)
        area <- 0 
        scantime <- (RTrange[scanend]-RTrange[scanstart])/(scanend-scanstart)*60 # time per scan in second 
        # when half peak
        if(half==T) {
                for(i in scanstart:scanpeak) area <- area + subsignal[i]*scantime
        }else{
                for(i in scanstart:scanend) area <- area + subsignal[i]*scantime
        }
        bgstart <- RTrange[scanstart-baseline+1]
        bgend <- RTrange[scanend+baseline-1]
        # calculate height
        sigpeakbase <- sigstart+(sigend-sigstart)/(scanend-scanstart)*(scanpeak-scanstart)
        height <- sigpeak - sigpeakbase
        # collect the data for plot peak and slope
        peakdata <- c(baseline,rtstart,rtend,rtpeak,scanstart,scanend,scanpeak,sigstart,sigend,sigpeak,sigpeakbase,lengthsig)
        names(peakdata) <- c('baseline','peak start RT','peak end RT','peak RT','baseline start RT ID','baseline end RT ID','baseline peak RT ID','start RT intensity','end RT intensity','peak RT intensity','peak baseline','points')
        # return the result as a list
        list <- list(area=area,
                     height=height,
                     baseline = baseline,
                     rtstart = rtstart,
                     rtend = rtend,
                     rtpeak = rtpeak,
                     scanstart = scanstart,
                     scanend = scanend,
                     scanpeak = scanpeak,
                     sigstart = sigstart,
                     sigend = sigend,
                     sigpeak = sigpeak,
                     sigpeakbase = sigpeakbase,
                     lengthsig = lengthsig,
                     RTrange=RTrange,signal=signal,slopedata=slopedata)
        return(list)
}