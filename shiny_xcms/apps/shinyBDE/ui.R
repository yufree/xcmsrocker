
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#

library(shiny)

shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Database of PBDEs' RRTs on DB-5ms"),
  
  # Sidebar with a slider input for number of PBDEs
  sidebarPanel(
    helpText("Select the index of  PBDEs congener and the prediction model"),
    sliderInput("index", 
                label = "Index of PBDEs:", 
                min = 1, 
                max = 209, 
                value = 47),
    selectInput("var", 
                label = "Choose a model to predict RRT",
                choices = c("Stepwise","SVM",
                            "Lasso","Rigid regression",
                            "Principal components regression","Partial least squares regression"),
                selected = "Partial least squares regression"),
    br(),
    br(),
    br(),
    br(),
    br(),
    br(),
    br(),
    br(),
    br(),
    br(),
    img(src = "bigorb.png", height = 50, width = 50),
    "shiny is a product of ", 
    span("RStudio", style = "color:blue"),
    br(),
    img(src = "institution-logo-rcees.jpg", height = 50, width = 50),
    "shinyBDE is a product of ", 
    span("Miao YU", style = "color:blue")
  ),
  
  mainPanel(
    p("The caculation of relative retention time(RRT) has changed from the following equation in Wei's paper:"),
    img(src = "equation1.png", height = 50, width = 200),
    p("into this equation to make the data comparable:"),
    img(src = "equation2.png", height = 50, width = 200),
    br(),
    p(textOutput("text")),
    img(src = "RSE.png", height = 400, width = 400)
  )
))
