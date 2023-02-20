getareastd <- function(data = NULL,ismz = 323, ppm = 5, con = 2000,rt = NULL, rts = NULL){
        if(is.null(data)){
                list <- list(sumpCl = NA, sumrarea = NA, comp = NA)
                return(list)
        }else{
                mz <- sccpdt$mz
                mzh <- mz + mz*0.000001*ppm
                mzl <- mz - mz*0.000001*ppm
                
                mzhis <- ismz + ismz*0.000001*ppm
                mzlis <- ismz + ismz*0.000001*ppm
                if(is.null(rts)){
                        eicis <- getEIC(data, mz = c(mzhis,mzlis))
                        dfis <- eicis@eic$xcmsRaw[[1]]
                        areais <- sum(diff(dfis[,1])*dfis[-1,2])
                }else{
                        eicis <- getEIC(data, mz = c(mzhis,mzlis))
                        dfis <- eicis@eic$xcmsRaw[[1]]
                        dfis <- dfis[dfis[,1]>rts[1]&dfis[,1]<rts[2],]
                        areais <- sum(diff(dfis[,1])*dfis[-1,2])
                }
                
                area <- vector()
                if(is.null(rt)){
                        for(i in 1:length(mz)){
                                eici <- getEIC(data, mz = c(mzh[i],mzl[i]))
                                df <- eici@eic$xcmsRaw[[1]]
                                area[i] <- sum(diff(df[,1])*df[-1,2])
                        }
                }else{
                        for(i in 1:length(mz)){
                                eici <- getEIC(data, mz = c(mzh[i],mzl[i]))
                                df <- eici@eic$xcmsRaw[[1]]
                                df <- df[df[,1]>rt[1]&df[,1]<rt[2],]
                                area[i] <- sum(diff(df[,1])*df[-1,2])
                        }
                }
                
                
                rarea <- area/(areais*sccpdt$Cln)
                rrares <- rarea/sum(rarea)
                pCl <- rrares*sccpdt$Clp
                
                sumpCl <- sum(pCl)
                sumrarea <- sum(rarea)/con
                
                ccomp <- aggregate(rrares,by = list(sccpdt$Cn),sum)
                colnames(ccomp) <- c("nC","Formula group abundance")
                clcomp <- aggregate(rrares,by = list(sccpdt$Cln),sum)
                colnames(clcomp) <- c("nCl","Formula group abundance")
                list <- list(sumpCl = sumpCl, sumrarea = sumrarea, ccomp = ccomp, clcomp = clcomp)
                return(list)
        }
}

getarea <- function(data,ismz = 323, ppm = 5,rt = NULL, rts = NULL){
        mz <- sccpdt$mz
        mzh <- mz + mz*0.000001*ppm
        mzl <- mz - mz*0.000001*ppm
        
        mzhis <- ismz + ismz*0.000001*ppm
        mzlis <- ismz + ismz*0.000001*ppm
        if(is.null(rts)){
                eicis <- getEIC(data, mz = c(mzhis,mzlis))
                dfis <- eicis@eic$xcmsRaw[[1]]
                areais <- sum(diff(dfis[,1])*dfis[-1,2])
        }else{
                eicis <- getEIC(data, mz = c(mzhis,mzlis))
                dfis <- eicis@eic$xcmsRaw[[1]]
                dfis <- dfis[dfis[,1]>rts[1]&dfis[,1]<rts[2],]
                areais <- sum(diff(dfis[,1])*dfis[-1,2])
        }
        
        area <- vector()
        if(is.null(rt)){
                for(i in 1:length(mz)){
                        eici <- getEIC(data, mz = c(mzh[i],mzl[i]))
                        df <- eici@eic$xcmsRaw[[1]]
                        area[i] <- sum(diff(df[,1])*df[-1,2])
                }
        }else{
                for(i in 1:length(mz)){
                        eici <- getEIC(data, mz = c(mzh[i],mzl[i]))
                        df <- eici@eic$xcmsRaw[[1]]
                        df <- df[df[,1]>rt[1]&df[,1]<rt[2],]
                        area[i] <- sum(diff(df[,1])*df[-1,2])
                }
        }
        
        
        rarea <- area/(areais*sccpdt$Cln)
        rrares <- rarea/sum(rarea)
        pCl <- rrares*sccpdt$Clp
        
        sumpCl <- sum(pCl)
        sumrarea <- sum(rarea)
        
        ccomp <- aggregate(rrares,by = list(sccpdt$Cn),sum)
        colnames(ccomp) <- c("nC","Formula group abundance")
        clcomp <- aggregate(rrares,by = list(sccpdt$Cln),sum)
        colnames(clcomp) <- c("nCl","Formula group abundance")
        list <- list(sumpCl = sumpCl, sumrarea = sumrarea, ccomp = ccomp, clcomp = clcomp)
        return(list)
}
