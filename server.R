server <- function(input, output, session){
  dataInput <- reactive({
    inFile <- input$file1
    inFile1<-c(input$Anemia,input$Age,input$Gender,input$Path,
               input$RevisionSurgery,input$Respiratory,input$Diabetic,
               input$Invasiveness,input$Autoimmune,input$Cardiac)
    
    if (!is.null(inFile)){
      if(input$csv=="csv"){
        data<-read.csv(inFile$datapath, header = input$header)
      }else{
        data<-read_excel(inFile$datapath,col_names= input$header)
      }
    } else{
      data<-as_tibble(t(inFile1))%>%
        stats::setNames(names(dat))%>%
        type_convert()%>%
        mutate_if(is.character,as.factor)%>%
        bind_rows(dat)%>%
        slice(1)
    }
    data%>%
      mutate_if(is.character,as.factor)
  })
  
  predicted<-eventReactive(input$extract,{
    data<-dataInput()
    predicted<-predictions(data)
    predicted1<<-map2(predicted, c("AnyOutcome","CCI3Plus"),
                      ~.x %>% mutate(Outcome = .y))%>%
      bind_rows()
    
    predicted
  })
  
  
  
  output$contents <- DT::renderDataTable({
    predicted<-predicted()
    predicted1<-map2(predicted, c("AnyOutcome","CCI3Plus"),
                     ~.x %>% mutate(Outcome = .y))%>%
      bind_rows()
    datatable(predicted$AnyOutcome
              ,
              options = list(pageLength = 15,
                             initComplete = JS(
                               "function(settings, json) {",
                               "$('td').css({'border': '1px solid black'});",
                               "$('th').css({'border': '1px solid black'});",
                               "$('table.dataTable.display tbody tr:odd').css('background-color', '#3c96de');",
                               "$('table.dataTable.display tbody tr:even').css('background-color', 'white');",
                               "}")))      
  })
  
  output$contents1 <- DT::renderDataTable({
    predicted<-predicted()
    datatable(predicted$CCI3Plus,
              options = list(pageLength = 15,
                             initComplete = JS(
                               "function(settings, json) {",
                               "$('td').css({'border': '1px solid black'});",
                               "$('th').css({'border': '1px solid black'});",
                               "$('table.dataTable.display tbody tr:odd').css('background-color', '#3c96de');",
                               "$('table.dataTable.display tbody tr:even').css('background-color', 'white');",
                               "}")))
  })
  
  output$downloadData <- downloadHandler(
    filename = function() {
      paste("predictions-", Sys.Date(), ".csv", sep="")
    },
    content = function(file) {
      write.csv(predicted1, file)
    })
  
  session$onSessionEnded(function() {
    print("app closing")
    stopApp()
  })
}
