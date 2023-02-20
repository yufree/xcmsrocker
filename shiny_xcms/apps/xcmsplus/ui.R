library(shiny)

shinyUI(                        
        navbarPage(
        "XcmsPlus",
        # first tab for intro
        tabPanel(
                "Get started",
                fluidPage(
                        # add ga code
                        tags$head(includeScript("ga.js")),
                        # Application title
                        titlePanel(
                                "Data Visualization of GC/LC-MS profile based on xcms and enviGCMS packages"
                        ),
                        p(
                                "This online application could perform the following data analysis/visualization:"
                        ),
                        h6("Data visualization of peaks list: Tab MZRT"),
                        
                        h6("Batch Simulation and Correction: Tab BSC"),
                        
                        h6("Direct Analysis in Real Time (DART) data visualization:Tab DART"),
                        
                        em('Click the tab and have a try'),
                        br(),
                        "Contact me by click",
                        a("here", href = "mailto:yufreecas@gmail.com"),
                        'or just add an issue on',
                        a("Github", href = "https://github.com/yufree/xcmsplus"),
                        "if you have questions for this app."
                )
        ),
        
        tabPanel("MZRT", fluidPage(
                sidebarLayout(
                        # Sidebar with a slider input for rsd and ins
                        sidebarPanel(
                                h4('Uploading File'),
                                fileInput('file',
                                          label = 'csv file with m/z, retention time, peaklist and group info',
                                          accept = c('.csv')),
                                h4('Data filter'),
                                sliderInput(
                                        "rsd",
                                        "RSD(%) within group",
                                        min = 1,
                                        max = 200,
                                        value = 30,
                                        step = 1
                                ),
                                sliderInput(
                                        "ins",
                                        "Intensity in Log scale",
                                        min = 1,
                                        max = 15,
                                        value = 5,
                                        step = 0.1
                                )
                        ),
                        mainPanel(tabsetPanel(
                                type = "tabs",
                                tabPanel("MZRT Guide",
                                         h3("Interactive scale visulization for peaks list"),
                                         h4("Prepare the data"),
                                         p(
                                                 "The following code would help:"
                                                 ,
                                                 br(),
                                                 code(
                                                         "BiocInstaller::biocLite('xcms')",
                                                         br(),
                                                         "install.package('enviGCMS')",
                                                         br(),
                                                         "# use devtools::install_github('yufree/enviGCMS') for new functions",
                                                         br(),
                                                         "library(xcms)",
                                                         br(),
                                                         "library(enviGCMS)",
                                                         br(),
                                                         "path <- './data'",
                                                         br(),
                                                         "xset <- getdata(path)",
                                                         br(),
                                                         "getmzrt(xset,name = 'test')",
                                                         br()
                                                 ),
                                                 br(),
                                                 p("Then just upload your 'test.csv' to this app ( or use ",code("getmzrt2")," for xcms 3 objects)."),
                                                 h4("Use demo data"),
                                                 p(
                                                         "You could download demo data",
                                                         a("here", href = "https://github.com/yufree/xcmsplus/blob/master/data/test.csv?raw=true")
                                                 )
                                         ),
                                         p(
                                                 "After uploading the data, you could change the RSD%, intensity(in Log scale) by the side slides to filter your data."
                                         ),
                                         p(
                                                 "Then click 'Profile visulization' or 'PCA' tabs to visulize the data."
                                         )
                                ),
                                tabPanel("Data Table",
                                         h4("Data table for peaks list"),
                                         dataTableOutput("datatable"),
                                         p(downloadButton('data', 'Download Filtered Data'))),
                                tabPanel(
                                        "Visulization",
                                        p(
                                                "You could brush an area in the left plot to see the enlarged results in right plot and the points listed in the table below the plots."
                                        ),
                                        column(
                                                6,
                                                plotOutput(
                                                        "plotmr",
                                                        click = "plot_click",
                                                        hover = "plot_hover",
                                                        brush = brushOpts(id = "plotmrs_brush",
                                                                          resetOnNew = TRUE)
                                                ),
                                                verbatimTextOutput("info")
                                        ),
                                        column(
                                                6,
                                                plotOutput('plotmrs', click = "plot_click2", hover = "plot_hover2"),
                                                verbatimTextOutput("info2")
                                        ),
                                        h4("Brushed points"),
                                        dataTableOutput("brush_info"),
                                        p(downloadButton('dataselect', 'Download Selected Data'))
                                        
                                ),
                                tabPanel("PCA",
                                         plotOutput("plotpca"))
                        ))))),
        tabPanel('BSC'
                 ,sidebarLayout(sidebarPanel(h5('Data Simulation'),
                                             sliderInput(
                                                     "ncomp",
                                                     "Percentage of the compounds",
                                                     min = 0,
                                                     max = 1,
                                                     value = 0.8
                                             ),
                                             sliderInput(
                                                     "ncpeaks",
                                                     "Percentage of the peaks influnced by condition",
                                                     min = 0,
                                                     max = 1,
                                                     value = 0.1
                                             ),
                                             sliderInput(
                                                     "nbpeaks",
                                                     "Percentage of the peaks influnced by batch",
                                                     min = 0,
                                                     max = 1,
                                                     value = 0.3
                                             )),
                                mainPanel(
                                        tabsetPanel(
                                        type = "tabs",
                                        tabPanel(h3("Batch Simulation "),
                                                 h4('Simulated Data'),
                                                 plotOutput("simdatah"),
                                                 dataTableOutput("simdata"),
                                                 p(downloadButton('simdatad', 'Download Data')),
                                                 h4("Simulated Data without conditions"),
                                                 plotOutput("simbatchallh"),
                                                 dataTableOutput("simbatchall"),
                                                 p(downloadButton('simbatchalld', 'Download Data')),
                                                 h4("Batch Peaks"),
                                                 plotOutput("simbatchh"),
                                                 dataTableOutput("simbatch"),
                                                 p(downloadButton('simbatchd', 'Download Data')),
                                                 h4("Condition Peaks"),
                                                 plotOutput("simconh"),
                                                 dataTableOutput("simcon"),
                                                 p(downloadButton('simcond', 'Download Data'))),        
                                tabPanel(h3("Batch Correction"),
                                         h4('ROC curve'),
                                         plotOutput('sim0'),
                                         h4("Raw data"),
                                         plotOutput("sim1"),
                                         h4("Raw data corrected(sva)"),
                                         plotOutput("sim2"),
                                         h4("Raw data corrected(isva)"),
                                         plotOutput("sim3"))
                                )
                                
                                ))),
        
                tabPanel("DART", fluidPage(
                        sidebarLayout(
                                sidebarPanel(
                                        h4("Single file"),
                                        fileInput(
                                                'filedart',
                                                label = 'mzXML file',
                                                
                                                accept = c('.mzXML')
                                        ),
                                        h4('Data filter for single file'),
                                        sliderInput(
                                                "insdart",
                                                "Intensity in Log scale",
                                                min = 1,
                                                max = 10,
                                                value = 3,
                                                step = 0.2
                                        ),
                                        h4("Multiple files"),
                                        fileInput(
                                                'filedart2',
                                                label = 'mzXML files',
                                                multiple = T,
                                                accept = c('.mzXML')
                                        ),
                                        selectInput('step','Profile step for mass spectrum',c(1,0.1,0.01,0.001),selected = '0.1')
                                        
                                ),
                                mainPanel(
                                        h3("DART visulization"),
                                        h4("Prepare the data"),
                                        p(
                                                "If you want to visulise the Direct Analysis in Real Time (DART) data, just upload the data (mzXML file) in the sidebar."
                                        ),
                                        h4("Use demo data"),
                                        p(
                                                "You could download demo",
                                                a('data', href = "https://github.com/yufree/xcmsplus/blob/master/data/test.mzXML?raw=true"),
                                                "here and have a try."
                                        ),
                                        h4("Usage"),
                                        p(
                                                "After uploading the data, you could change intensity(in Log scale) by the side slides to filter your data. The RSD% filter is not working in this mode."
                                        ),
                                        dataTableOutput("darttable"),
                                        p(downloadButton('datadart', 'Download Selected Data')),
                                        plotOutput("dart"),
                                        plotOutput("darttic"),
                                        plotOutput("dartms")
                                        
                                )
                        ))),
                tabPanel(
                        "References",
                        p(
                                "If you use this application for publication, please cite this application as webpages and related papers:"
                        ),
                        h6(
                                "Miao Yu, Xingwang Hou, Qian Liu, Yawei
                                                Wang, Jiyan Liu, Guibin Jiang: 2017
                                                Evaluation and reduction of the
                                                analytical uncertainties in GC-MS
                                                analysis using a boundary regression
                                                model Talanta, 164, 141–147."
                        ),
                        h6(
                                "Smith, C.A. and Want, E.J. and
                                                O'Maille, G. and Abagyan,R. and
                                                Siuzdak, G.: XCMS: Processing mass
                                                spectrometry data for metabolite
                                                profiling using nonlinear peak
                                                alignment, matching and identification,
                                                Analytical Chemistry, 78:779-787 (2006)
                                                
                                                "
                        ),
                        h6(
                                "Ralf Tautenhahn, Christoph Boettcher,
                                                Steffen Neumann: Highly sensitive
                                                feature detection for high resolution
                                                LC/MS BMC Bioinformatics, 9:504 (2008)
                                                
                                                "
                        ),
                        h6(
                                "H. Paul Benton, Elizabeth J. Want and
                                                Timothy M. D. Ebbels Correction of mass
                                                calibration gaps in liquid
                                                chromatography-mass spectrometry
                                                metabolomics data Bioinformatics,
                                                26:2488 (2010)
                                                "
                        )
                )
        )
)
