library(timevis)
library(dplyr)
library(stringr)

source("setup.R", local=TRUE)
source("readData.R", local = TRUE)
source("utils.R", local = TRUE)

function(input, output, session) {
  
  output$timelineGroups <- renderTimevis({
    
    config <- list(
      order = htmlwidgets::JS('function(a,b) {return a.id - b.id;}'),
      editable = FALSE,
      align = "center",
      orientation = "top",
      margin = list(item = 5, axis = 5)
    )
    timevis(data = dataGroups, groups = groups, options = config)
  })
  
  observeEvent(input$fitTimelineGroups, {
    fitWindow("timelineGroups")
  })
  
  observeEvent(input$showSubobjectives, {
    addSubobjectives("timelineGroups", subobjectives)
  })
  
  output$acronyms <- DT::renderDataTable({
    firstDate <- input$timelineGroups_window[1]
    lastDate <- input$timelineGroups_window[2] 
    data <- input$timelineGroups_data %>%
      select(content,type,start,end) %>%
      filter(((type == 'point' | type == 'box') & (start > firstDate & start < lastDate)) | 
               ((type == 'range' | type == 'background') & (start < lastDate & end > firstDate)))
    acronyms %>% 
      filter(grepl(
        paste0("\\<",
               paste(unlist(str_split(data$content,pattern=" ")),collapse="\\>|\\<"),
               "\\>"), 
        acronym)) %>%
      select(acronym, full)
  },
  options = list(
    paging = FALSE,
    order = list(list(1, 'asc')),
    rownames = FALSE,
    columnDefs = list( list(visible=FALSE,targets=0) ),
    colnames = c("Acronym","")
  )
  ) 
  
  output$timelineCustom <- renderTimevis({
    config <- list(
      editable = TRUE,
      align = "center",
      orientation = "top",
      snap = NULL,
      margin = list(item = 30, axis = 50)
    )
    timevis(dataBasic, zoomFactor = 1, options = config)
  })
  
  output$timelineInteractive <- renderTimevis({
    config <- list(
      editable = TRUE,
      multiselect = TRUE
    )
    timevis(dataBasic, options = config)
  })
  
  output$selected <- renderText(
    paste(input$timelineInteractive_selected, collapse = " ")
  )
  output$window <- renderText(
    paste(prettyDate(input$timelineInteractive_window[1]),
          "to",
          prettyDate(input$timelineInteractive_window[2]))
  )
  output$table <- renderTable({
    data <- input$timelineInteractive_data
    data$start <- prettyDate(data$start)
    if(!is.null(data$end)) {
      data$end <- prettyDate(data$end)
    }
    data
  })
  output$selectIdsOutput <- renderUI({
    selectInput("selectIds", tags$h4("Select items:"), input$timelineInteractive_ids,
                multiple = TRUE)
  })
  output$removeIdsOutput <- renderUI({
    selectInput("removeIds", tags$h4("Remove item"), input$timelineInteractive_ids)
  })
  
  observeEvent(input$fit, {
    fitWindow("timelineInteractive")
  })
  
  observeEvent(input$setWindowAnim, {
    setWindow("timelineInteractive", "2016-01-07", "2016-01-25")
  })
  observeEvent(input$setWindowNoAnim, {
    setWindow("timelineInteractive", "2016-01-07", "2016-01-25",
              options = list(animation = FALSE))
  })
  observeEvent(input$center, {
    centerTime("timelineInteractive", "2016-01-23")
  })
  observeEvent(input$focus2, {
    centerItem("timelineInteractive", 4)
  })
  observeEvent(input$focusSelection, {
    centerItem("timelineInteractive", input$timelineInteractive_selected)
  })
  observeEvent(input$selectItems, {
    setSelection("timelineInteractive", input$selectIds,
                 options = list(focus = input$selectFocus))
  })
  observeEvent(input$addBtn, {
    addItem("timelineInteractive",
            data = list(id = randomID(),
                        content = input$addText,
                        start = input$addDate))
  })
  observeEvent(input$removeItem, {
    removeItem("timelineInteractive", input$removeIds)
  })
  observeEvent(input$addTime, {
    addCustomTime("timelineInteractive", "2016-01-17", randomID())
  })
}
