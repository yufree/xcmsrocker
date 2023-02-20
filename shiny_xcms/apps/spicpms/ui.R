
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(
        tags$head(includeScript("ga.js")),
  # Application title
  titlePanel("SP-ICP-MS analysis"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
            selectInput("element", 
                        label = "Choose element",
                        choices = list("Au", "Ag","SiO2","TiO2","ZnO"),
                        selected = "Au"),
            sliderInput("flow", label = "flow rate(ml/min)", min = 0.01, max = 0.5, value = 0.022, step = 0.001),
            sliderInput("dwell", label = "dwell time(ms)", min = 0, max = 20, value = 3, step = 0.1),
            numericInput("con", label = "standard concentration(ng/L)", value = 50),
            numericInput("di", label = "standard diameter(nm)", value = 60),
            fileInput('files', 'Choose standard CSV File',accept=c('text/csv', 'text/comma-separated-values,text/plain', '.csv')),
            fileInput('file', 'Choose sample CSV File',accept=c('text/csv', 'text/comma-separated-values,text/plain', '.csv')),
            numericInput("skips", label = "SKIP", value = 4),
            numericInput("nrowss", label = "Rows Number", value = 20000),
            numericInput("threshold", label = "noise(cps)", value = 4),            
            sliderInput("breaks", label = "breaks", min = 30, max = 200, value = 80, step = 10),
            sliderInput("bw_adjust", label = "Bandwidth adjustment:", min = 0.2, max = 2, value = 1, step = 0.2),
            br(),
            "This app is developed by ", 
            a("Miao Yu", href="http://yufree.github.io/blog")
    ),

    # Show a plot of the generated distribution
    mainPanel(
            img(src = "lablogofull.jpg", height = 300, width = 800),
            p('This application could be used to perform SP-ICP-MS analysis, just follow the following steps and detailed introduction could be accessed ',a('here', herf = 'http://yufree.github.io/blog/2015/01/03/intro-SP-ICP-MS.html'),'.'),
            h5('Select your element'),
            h5('Input the injection flow rate and dwell time of your ICP-MS'),
            h5('Input the standard concentration(ng/L) and diameter(nm)'),
            h5('Input your standard and sample data files in csv format and select the skip line and data lines and you will see the plots and a summary table'),
            h5('You could revise the plot by change the background threshold, breaks and bandwidth'),
            plotOutput("plot"),
            tableOutput('print')
    )
  )
))
