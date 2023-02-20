#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(magick)
# the original code is written by Prof. John Staudenmayer(http://people.math.umass.edu/~jstauden/) and post on Prof. Leonard A. Stefanski's website(http://www4.stat.ncsu.edu/~stefansk/). I made some modifications for my blog posts and please refer to the comments in the following code.

# the following code is the same with Prof. John Staudenmayer's R script
border <- function(alpha,x,y,M,bord.size,blur.sd)
{
        # This function adds a border to the scatterplot
        # to make Yhat and R0 orthogonol with "spacing" 
        # determined by alpha.
        
        # x=Yhat and y=R0 are original data.
        
        # M is nubmer of points to add to each border.
        
        # bord.size is % away from original max and min that 
        # the border is.
        
        # blur.sd  is sd of "blur" for border
        # x (Yhat) and Y (R0) are both centered and scaled. This seems to improve
        # numerical stability.
        
        range.x <- diff(range(x))
        range.y <- diff(range(y))
        
        min.x <- min(x)-bord.size*range.x
        max.x <- max(x)+bord.size*range.x
        min.y <- min(y)-bord.size*range.y
        max.y <- max(y)+bord.size*range.y
        
        range.y <- max.y-min.y
        range.x <- max.x-min.x
        
        u.a <- seq(from=0,to=1,length=M)^alpha
        
        left.border.x <- rnorm(M,mean=min.x,sd=blur.sd)
        left.border.y <- min.y+(range.y)*u.a
        
        right.border.x <- rnorm(M,mean=max.x,sd=blur.sd)
        right.border.y <- min.y+(range.y)*(1-u.a)
        
        bottom.border.y <- rnorm(M,mean=min.y,sd=blur.sd)
        bottom.border.x <- min.x+(range.x)*u.a
        
        top.border.y <- rnorm(M,mean=max.y,sd=blur.sd)
        top.border.x <- min.x+(range.x)*(1-u.a)
        
        border.x <- c(bottom.border.x,top.border.x,left.border.x,right.border.x)
        border.y <- c(bottom.border.y,top.border.y,left.border.y,right.border.y)
        
        x <- c(x,border.x)
        y <- c(y,border.y)
        
        
        list(x=as.vector(scale(x)),y=as.vector(scale(y)))
}


slope <- function(alpha,x,y,M,bord.size,blur.sd)
{
        # internal fuction for finding optimal alpha
        temp <- border(alpha,x,y,M,bord.size,blur.sd)
        x <- temp$x
        y <- temp$y
        as.vector(lm(y~x)$coef[2])
}

find.bord <- function(x,y,M=100,bord.size=.05,min.a=0.0001,max.a=100, blur.sd=0)
{
        # function to add a border to Yhat and R0
        
        alpha <- uniroot(slope,c(min.a,max.a), 
                         tol = 10e-13,x=x,y=y,M=M,bord.size=bord.size,blur.sd=blur.sd)
        if (abs(alpha$f.root)>(.01)) print("problem: larger M? bigger range for alpha?")
        border(alpha$root,x,y,M,bord.size,blur.sd)
}



find.regression <- function(Yhat,R0,coef.det,p,j=1,eps=10e-13)
{
        # start with orthogonal Yhat and R0 and find an X (matrix) and Y (vector) pair.
        # coef.det is coefficient of determination
        # p is number of non-intercept covariates
        # j is the column of M to use for iterations
        # eps is a convergence criterium
        
        sdYhat <- sd(Yhat)
        sdR0 <- sd(R0)
        
        n <- length(R0)
        CD <- coef.det
        beta0 <- 1
        betas <- runif(p)
        j <- 1
        
        Yhat <- (sdR0/sdYhat)*sqrt(CD/(1-CD))*Yhat
        
        PR0 <- outer(R0,R0,"*")/sum(R0^2)
        Z <- rnorm(n,mean=0,sd=sdR0)
        M <- matrix(rnorm(p*n,mean=0,sd=sdYhat),n,p)
        test <- 1
        while (test>eps)
        {
                W <- cbind(rep(1,n),(diag(rep(1,n))-PR0)%*%M)
                A <- W%*%solve(t(W)%*%W)%*%t(W)
                
                term.1 <- A%*%Z
                term.2 <- PR0%*%M%*%betas
                term.3 <- apply(t(t(M)*betas)[,-j],1,sum)
                temp <- (1/betas[j])*(Yhat-beta0-term.1+term.2-term.3)
                
                new.M <- M
                new.M[,j] <- temp
                
                delta <- (diag(rep(1,n))-PR0)%*%((new.M-M))
                test <- max(abs(delta))
                
                M <- new.M
        }
        W <- cbind(rep(1,n),(diag(rep(1,n))-PR0)%*%M)
        A <- W%*%solve(t(W)%*%W)%*%t(W)
        
        epsilon <- as.vector(R0+A%*%Z)
        
        X <- (diag(rep(1,n))-PR0)%*%M
        Y <- beta0+X%*%betas+epsilon
        
        data.frame(cbind(Y=Y,X=X))
}

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
        
        # Application title
        titlePanel("Hidden Love"),
        
        # Sidebar with a slider input for number of bins 
        sidebarLayout(
                sidebarPanel(
                        # add ga code
                        tags$head(includeScript("ga.js")),
                        fileInput('image',
                                  label = 'image files',
                                  accept = c('.png','.jpg', '.bmp'))
                ),
                
                # Show a plot of the generated distribution
                mainPanel(
                        h4("This is a gift for my girlfriend: Dr. Ping Lu"),
                        h4("Usage"),
                        p('Upload you image in the left panel and wait for a while'),
                        p('Download data in the right panel and sent to the one you loved'),
                        p('She/He need to use regression analysis(Y~X) to find the plot in the residual plot'),
                        p('Credits should be given to Prof. Leonard A. Stefanski and Prof. John Staudenmayer and you could find more info', a('here',href = 'https://www4.stat.ncsu.edu/~stefanski/NSF_Supported/Hidden_Images/stat_res_plots.html'), 'and', a('here', href = 'https://yufree.cn/cn/2014/12/18/hide-in-date/')),
                        p('You could also check this github', a('repo', href = 'https://github.com/yufree/realism'), 'for source code.' ),
                        plotOutput("plot"),
                        h4("Data"),
                        # dataTableOutput("datatable"),
                        p(downloadButton('data', 'Download Data'))
                )
        )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
        datainput <- reactive({
                if (!is.null(input$image$datapath)){
                        image <- image_read(input$image$datapath)
                        z <- image_convert(image, format = 'pbm', type = 'Bilevel', colorspace = 'gray')
                        z <- image_rotate(z,180)
                        z <- image_resize(z, '200x200!')
                        z1 <- image_data(z,channels = 'gray')
                        t0 <- t <- c(as.numeric(z1))
                        t[t0<=1] <- 1
                        t[t0==1] <- 0

                        # the following code is the same with Prof. John Staudenmayer's R script
                        
                        # The code below makes it into "scatterplot" format.
                        x <- rep(1:dim(z1)[3],each=dim(z1)[2])
                        y <- rep(1:dim(z1)[2],times=dim(z1)[3])
                        x <- -x[t==1]
                        y <- y[t==1]
                        
                        # Augment the data to make x and y orthogonal.
                        
                        picture <- find.bord(x,y,blur.sd=0)
                        Yhat <- picture$x
                        R0 <- picture$y
                        
                        data <- find.regression(Yhat,R0,coef.det=.05,p=5,j=1,eps=10e-13)
                        # data$X has covariates (without intercept)
                        # data$Y has response.
                        colnames(data) <- c('Y', 'X1','X2','X3','X4','X5')
                        return(data)
                }else{
                        return(NULL)
                }
        })
        output$plot <- renderPlot({
                data <- datainput()
                if(is.null(data)){
                        plot(1,1,type = 'n',
                             main="Residual plot from data",
                             xlab = 'fitted',
                             ylab = 'res')
                }else{
                        reg <- lm(Y~ .,data=data)
                        plot(reg$fitted,reg$resid,pch=16,
                             main="Residual plot from data",
                             xlab = 'fitted',
                             ylab = 'res')
                }
                
        }) 
        # show the download
        output$data = downloadHandler('data.csv', content = function(file) {
                data <- datainput()
                write.csv(data, file)
        })
}

# Run the application 
shinyApp(ui = ui, server = server)

