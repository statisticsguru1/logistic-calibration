pkgss = c("shiny","tidyverse","colorspace","shinythemes","readxl", "DT","MASS","boot","caret","modelr")
lapply(pkgss,require,character.only=TRUE)
setwd("~/app")
options(shiny.maxRequestSize=1000000*1024^2)
load('modeldata.Rdata',.GlobalEnv)
ui<-shinyUI(
  navbarPage("Optimismt model",theme = shinythemes::shinytheme("cerulean"),
             tabPanel("AnyOutcome",
                      fillPage(
                        sidebarPanel(width = 4,
                                     fluidRow(offset=1,style="border: 4px inset;",
                                              column(4,offset=1,
                                                     h4(tags$strong(("Upload file"))),
                                                     fileInput("file1", "Browse",
                                                               accept = c(
                                                                 "text/csv",
                                                                 "text/comma-separated-values,text/plain",
                                                                 ".csv")
                                                     ),
                                                     checkboxInput("header", "Header", TRUE)),
                                              column(4,offset=1,
                                                     h4(tags$strong(("file type"))),
                                                     selectInput("csv", "file type",
                                                                 c("csv","excel")))
                                     ),
                                     fluidRow(offset=1,style="border: 4px inset;",
                                              h4(tags$strong(("Type data"))),
                                              fluidRow(
                                                column(4,offset=1,
                                                       # Anemia 
                                                       numericInput(inputId = "Anemia",label = "Anemia",value=0)),
                                                column(4,offset=1,
                                                       # Age
                                                       numericInput(inputId = "Age",label = "Age",value=0)),
                                                column(4,offset=1,
                                                       # Gender
                                                       selectInput(inputId = "Gender",label = "Gender",c("M","F"))),
                                                
                                                column(4,offset=1,
                                                       # Path
                                                       selectInput(inputId = "Path",
                                                                   label = "Path",
                                                                   c("Deformity","Degen","Infection","Trauma","Tumour"))),
                                                column(4,offset=1,
                                                       # RevisionSurgery
                                                       numericInput(inputId = "RevisionSurgery",label = "RevisionSurgery",value=0)),
                                                column(4,offset=1,
                                                       # Respiratory
                                                       numericInput(inputId = "Respiratory",label = "Respiratory",value=0)),
                                                column(4,offset=1,
                                                       # Diabetic
                                                       numericInput(inputId = "Diabetic",label = "Diabetic",value=0)),
                                                column(4,offset=1,
                                                       # Invasiveness
                                                       numericInput(inputId = "Invasiveness",label = "Invasiveness",value=0)),
                                                column(4,offset=1,
                                                       # Autoimmune
                                                       numericInput(inputId = "Autoimmune",label = "Autoimmune",value=0)),
                                                column(4,offset=1,
                                                       # Invasiveness
                                                       numericInput(inputId = "Cardiac",label = "Cardiac",value=0)),
                                                column(4,offset=1,
                                                       actionButton(inputId ="extract",label = "Go")),
                                                column(4,offset=1,
                                                       downloadButton("downloadData", "Download"))
                                              )
                                              
                                     )
                                     
                        ),
                        
                        mainPanel(width = 8,
                                  h4(tags$strong((" AnyOutcome predictions"))),
                                  DT::dataTableOutput("contents"))
                      )),
             # Graph  tab will be inserted here--------------------------------------------------------------------------------------------------------------
             tabPanel("CCI3Plu",
                      fillPage(
                        mainPanel(width = 12,
                                  h4(tags$strong(("CCI3Plu predictions"))),
                                  DT::dataTableOutput("contents1"))
                      )
             )
  )
)