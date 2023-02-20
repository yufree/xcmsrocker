
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(
        titlePanel("Molecule Isotop Ratio(MIR)"),
        
        sidebarPanel(
                textInput('formula',
                          label = "Import Formula such as C12H6OBr4",
                          value = "C12H6OBr4"),
                sliderInput('width',
                            label = 'Peaks Width(+/-)',
                            min = 0, max = 1, value = 0.3),
                fileInput('filel',
                          label = 'Choose CSV File for light molecular isotopologue peak',
                          accept=c('text/csv', 'text/comma-separated-values,text/plain', '.csv')),
                tags$hr(),
                numericInput("skipl", 
                             label = "SKIP", 
                             value = 3),
                numericInput("nrowsl",
                             label = "Rows Number",
                             value = 1500),
                tags$hr(),
                fileInput('fileh', 
                          label = 'Choose CSV File for heavy molecular isotopologue peak',
                          accept=c('text/csv', 'text/comma-separated-values,text/plain', '.csv')),
                tags$hr(),
                numericInput("skiph",
                             label = "SKIP", 
                             value = 1600),
                numericInput("nrowsh",
                             label = "Rows Number", 
                             value = 1500),
                tags$hr(),
                numericInput("minrt", 
                             label = "RT start", 
                             value = 9.9),
                numericInput("maxrt",
                             label = "RT stop", 
                             value = 10.2),
                numericInput("n",
                             label = "points in the moving average smooth box", 
                             value = 5),
                numericInput("m",
                             label = "numbers of points for regression", 
                             value = 5),
                numericInput("startslope",
                             label = "threshold value for start peak (%max slope)", 
                             value = 2),
                numericInput("stopslope",
                             label = "threshold value for stop peak (%max slope)",
                             value = 2),
                numericInput("baseline",
                             label = "points number for the baseline before the peak",
                             value = 20),
                checkboxInput("noslope", 
                              label = "true peak baseline",
                              value = TRUE),
                checkboxInput("smoothit",
                              label = "smooth the data", 
                              value = TRUE),
                checkboxInput("half", 
                              label = "half peak", 
                              value = F),
                br(),
                img(src = "logo.jpg", height = 50, width = 50),
                "This app is created by ", 
                a("Miao Yu", href = "mailto:yufreecas@gmail.com")
                       ),
        
        mainPanel(
                img(src = "lablogofull.jpg", height = 200, width = 800),
                tabsetPanel(type = "tabs",
                            tabPanel('Description',
                            p("This app is developed for molecular isotope studies."),
                            h4("Usage"),
                            br(),
                            p("Input the molecular fomula and the peak width of isotopologues on your mass spectrum in the side bar. Then in the 'Peaks' tab, you might find the selected peaks for that mulecular and a caculated ratio of selected peaks on your mass spectrum. The defalt molecular is BDE-47"),
                            br(),
                            p("You may upload your data of certain isotopologues in csv format to get the molecular isotope ratio for your experiment in tab 'Molecule Isotop Ratio'. The first column would be time and second column responses. The 'SKIP' means you can skip certain header lines and row numbers means the lines for that isotopolgues. When both of the light and heavy isotopolgues were in the same file, such parameters will help you to seperate them apart."),
                            br(),
                            p("RT start and RT end mean the scale of your retention time which included the peaks for light and heavy isotopologues."),
                            br(),
                            p("Points in the moving average smooth box, numbers of points for regression, threshold value for start/stop peaks and points number for the baseline before the peak are all the parameters for peak integration. The defalt value may suit for most of the cases. Take care when you need to change the value and please refer to the references. Also the checkbox of true peak baseline, smooth the data and half peak are set at the recommanded valus."),
                            br(),
                            h4('References'),
                            p("If you use this application for publication, please cite this application as webpages and the following papers and softwares:"),
                            h6("R Core Team. R: A Language and Environment for Statistical Computing. (R Foundation for Statistical Computing, 2015). at <http://www.R-project.org/>
"),
                            h6("Winston Chang, Joe Cheng, JJ Allaire,  Yihui Xie and Jonathan McPherson (2015). shiny: Web Application Framework for R. R package version 0.12.0. http://CRAN.R-project.org/package=shiny"),
                            h6("Guha, R. (2007). 'Chemical Informatics  Functionality in R'. Journal of Statistical Software 6(18)"),
                            h6("Yu, M., Liu, J., Wang, T., Sun, J., Liu, R., & Jiang, G. . Metabolites of 2,4,4’-tribrominated diphenyl ether (BDE-28) in pumpkin after in vivo and in vitro exposure. Environmental Science & Technology, 47(23), 13494–501(2013)."),
                            h6("Aeppli, C., Holmstrand, H., Andersson, P. & Gustafsson, O. Direct Compound-Specific Stable Chlorine Isotope Analysis of Organic Compounds with Quadrupole GC/MS Using Standard Isotope Bracketing. Anal. Chem. 82, 420–426 (2010)."),
                            "Contact me by click",
                            a("here", href = "mailto:yufreecas@gmail.com"),
                            'or just add an issue on',
                            a("Github",href = "https://github.com/yufree/MIR")
                            ),
                            tabPanel("Peaks",
                                     div(align="center",tableOutput('select')),
                                     plotOutput('plot0')
                                     ),
                                     
                            tabPanel("Molecule Isotop Ratio",
                                     plotOutput('plot'),
                                     div(align="center",tableOutput('table'))
                            )
        ))
))