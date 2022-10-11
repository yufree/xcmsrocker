plotmz <- function(data, inscf = 5, ...) {
        mz <- as.numeric(rownames(data))
        rt <- as.numeric(colnames(data))
        z <- log10(data + 1)
        cex = as.numeric(cut(z - inscf, breaks = c(0, 1, 2, 3, 4, Inf) /
                                     2)) / 2
        cexlab = c(
                paste0(inscf, '-', inscf + 0.5),
                paste0(inscf + 0.5, '-', inscf + 1),
                paste0(inscf + 1, '-', inscf + 1.5),
                paste0(inscf + 1.5, '-', inscf + 2),
                paste0('>', inscf + 2)
        )
        
        z[z < inscf] <- NA
        corr <- which(!is.na(z), arr.ind = TRUE)
        mz0 <- mz[corr[, 1]]
        rt0 <- rt[corr[, 2]]
        int <- z[which(!is.na(z))]
        
        par(mar=c(5, 4.2, 6.1, 2.1), xpd=TRUE)
        graphics::plot(
                mz0 ~ rt0,
                pch = 19,
                cex = cex,
                col = grDevices::rgb(0, 0, 1, 0.1),
                xlab = "retention time(s)",
                ylab = "m/z",
                ...
        )
        graphics::legend(
                'top',
                legend = cexlab,
                title = 'Intensity in Log scale',
                pt.cex = c(1,2,3,4,5)/2,
                pch = 19,
                bty = 'n',
                horiz = T,
                cex = 0.7,
                col = grDevices::rgb(0, 0, 1, 0.1),
                inset = c(0, -0.25)
                
        )
}


plotdart <- function(data,cf){
        pf <- xcms::profMat(data)
        rownames(pf) <- mz <- xcms::profMz(data)
        colnames(pf) <- rt <- data@scantime
        plotmz(pf,inscf = cf)
}

plotdartms <- function(data){
        pf <- xcms::profMat(data)
        rownames(pf) <- mz <- xcms::profMz(data)
        colnames(pf) <- rt <- data@scantime
        mzins <- apply(pf,1,sum)/length(unique(rt))
        plot(mzins~mz, xlab = 'm/z',ylab = 'intensity',type = 'h',main = 'Mass Spectrum')
}
