library(timevis)

source("ui-helpers.R")


fluidPage(
  title =  paste(appName, appDescription, sep=" - "),
  tags$head(
    tags$link(href = "style.css", rel = "stylesheet"),

    # Favicon
    tags$link(rel = "shortcut icon", type="image/x-icon", href="favicon/favicon.ico")
  ),
  tags$a(
    href="https://twitter.com/usaf_a10",
    tags$img(style="position: absolute; top: 0; right: 0; border: 0;",
             src="A10_Patch.png",
             alt="Follow USAF/A10 on Twitter")
  ),
  div(id = "header",
    div(id = "title",
      appName
    ),
    div(id = "subtitle",
        appDescription),
    div(id = "subsubtitle",
        "A",
        tags$a(href = "https://twitter.com/usaf_a10", "USAF/A10"),
        "App",
        HTML("&bull;"),
        "Available",
        tags$a(href = "https://github.com/padamson/stratvis", "on GitHub")
    )
  ),
  tabsetPanel(
    id = "mainnav",
  
    tabPanel(
      div(icon("calendar"), "Basic demo"),
      timevisOutput("timelineGroups"),
      div(class = "sourcecode",
          "The exact code for all the timelines in this app is",
          tags$a(href = sourceCodeOnGithub,
                 "on GitHub")
      )
    ),

    tabPanel(
      div(icon("sliders"), "Fully interactive demo"),
      fluidRow(
        column(
          8,
          fluidRow(column(12,
            timevisOutput("timelineInteractive")
          )),
          fluidRow(
            column(
              12,
              div(id = "interactiveActions",
                  class = "optionsSection",
                  tags$h4("Actions:"),
                  actionButton("fit", "Fit all items"),
                  actionButton("setWindowAnim", "Set window 2016-01-07 to 2016-01-25"),
                  actionButton("setWindowNoAnim", "Set window without animation"),
                  actionButton("center", "Center around 2016-01-23"),
                  actionButton("focus2", "Focus item 4"),
                  actionButton("focusSelection", "Focus current selection"),
                  actionButton("addTime", "Add a draggable vertical bar 2016-01-17")
              )
            )
          ),
          fluidRow(
            column(
              4,
              div(class = "optionsSection",
                  uiOutput("selectIdsOutput", inline = TRUE),
                  actionButton("selectItems", "Select"),
                  checkboxInput("selectFocus", "Focus on selection", FALSE)
              )
            ),
            column(
              4,
              div(class = "optionsSection",
                  textInput("addText", tags$h4("Add item:"), "New item"),
                  dateInput("addDate", NULL, "2016-01-15"),
                  actionButton("addBtn", "Add")
              )
            ),
            column(
              4,
              div(class = "optionsSection",
                  uiOutput("removeIdsOutput", inline = TRUE),
                  actionButton("removeItem", "Remove")
              )
            )
          )
        ),
        column(4,
           div(
             id = "timelinedata",
             class = "optionsSection",
             tags$h4("Data:"),
             tableOutput("table"),
             hr(),
             div(tags$strong("Visible window:"),
                 textOutput("window", inline = TRUE)),
             div(tags$strong("Selected items:"),
                 textOutput("selected", inline = TRUE))
           )
        )
      ),
      div(class = "sourcecode",
          "The exact code for all the timelines in this app is",
          tags$a(href = sourceCodeOnGithub,
                 "on GitHub")
      )
    )
    
  )
)
