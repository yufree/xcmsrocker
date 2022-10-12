Getisotopologues <- function(formula = 'C12OH6Br4', charge = '1',width = 0.3){
        # input the forlmula and charge for your molecular, this demo was for BDE-47
        formula <- get.formula(formula, charge)
        # get the isotopes pattern of your molecular with high abandances. Here
        # we suggest more than 10% abundance of your base peak would meet the SNR
        isotopes <- data.frame(get.isotopes.pattern(formula,minAbund=0.1))
        # order the intensity by the abandance
        findpairs <- isotopes[order(isotopes[,2],decreasing = T),]
        # find the most similar pairs with high abandance
        df <- outer(findpairs[,2],findpairs[,2],'/')
        rownames(df) <- colnames(df) <- findpairs$mass
        diag(df) <- df[upper.tri(df)] <- 0
        t <- which(df==max(df),arr.ind=T)
        isotopologues1 <- as.numeric(rownames(df)[t[1]])
        isotopologues2 <- as.numeric(colnames(df)[t[2]])
        isotopologuesL <- min(isotopologues1,isotopologues2)
        isotopologuesH <- max(isotopologues1,isotopologues2)
        # get the caculated ratio at certain resolution
        isotopes2 <- get.isotopes.pattern(formula,minAbund=0.00000001)
        ratio <- sum(isotopes2[isotopes2[,1]>isotopologuesL-width & isotopes2[,1]<isotopologuesL+width,2])/sum(isotopes2[isotopes2[,1]>isotopologuesH-width & isotopes2[,1]<isotopologuesH+width,2])
        peak <- c(round(isotopologuesL,digits = 1),round(isotopologuesH,digits = 1),round(ratio,digits = 4))
        peak <- as.character(peak)
        names(peak) <- c('light isotopologue','high isotopologue','caculated ratio')
        return(data.frame(peak))
}