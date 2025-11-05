library(shiny)
library(DT)
library(plotly)
library(ggplot2)
dataset <- read.csv("Dataset for project.txt", stringsAsFactors = FALSE)

ui <- fluidPage(
  titlePanel("Football Player Data - CRUD & Visualization"),
  
  sidebarLayout(
    sidebarPanel(
      textInput("id", "ID"),
      textInput("name", "Name"),
      textInput("longname", "Long Name"),
      textInput("nationality", "Nationality"),
      numericInput("age", "Age", value = 20),
      numericInput("ova", "Overall (OVA)", value = 60),
      numericInput("pot", "Potential (POT)", value = 70),
      textInput("club", "Club"),
      textInput("contract", "Contract"),
      textInput("positions", "Positions"),
      textInput("height", "Height"),
      textInput("weight", "Weight"),
      textInput("foot", "Preferred Foot"),
      numericInput("bov", "Best Overall Value (BOV)", value = 65),
      textInput("joined", "Joined Date"),
      
      actionButton("add", "Add Record"),
      actionButton("update", "Update Record"),
      actionButton("delete", "Delete Record"),
      textInput("filter", "Search Name"),
      
      hr(),
      h4("Filters for Visualization"),
      selectInput("nat_filter", "Filter by Nationality",
                  choices = c("All", unique(dataset$Nationality)),
                  selected = "All"),
      sliderInput("age_range", "Age Range",
                  min = min(dataset$Age, na.rm = TRUE),
                  max = max(dataset$Age, na.rm = TRUE),
                  value = c(min(dataset$Age, na.rm = TRUE),
                            max(dataset$Age, na.rm = TRUE)))
    ),
    
    mainPanel(
      DTOutput("table"),
      h3("Scatter Plot: Overall vs Potential"),
      plotlyOutput("plot1"),
      h3("Histogram: Age Distribution"),
      plotOutput("plot2")
    )
  )
)
server <- function(input, output, session) {
  data <- reactiveVal(dataset)
  
  observeEvent(input$add, {
    df <- data()
    new_row <- data.frame(
      ID = input$id,
      Name = input$name,
      LongName = input$longname,
      Nationality = input$nationality,
      Age = input$age,
      OVA = input$ova,
      POT = input$pot,
      Club = input$club,
      Contract = input$contract,
      Positions = input$positions,
      Height = input$height,
      Weight = input$weight,
      Preferred_Foot = input$foot,
      BOV = input$bov,
      Best_Position = NA,
      Joined = input$joined,
      AgeGroup = NA,
      RatingCategory = NA,
      stringsAsFactors = FALSE
    )
    data(rbind(df, new_row))
  })
  
  observeEvent(input$update, {
    df <- data()
    idx <- which(df$ID == input$id)
    if (length(idx) > 0) {
      df[idx, ] <- list(
        ID = input$id,
        Name = input$name,
        LongName = input$longname,
        Nationality = input$nationality,
        Age = input$age,
        OVA = input$ova,
        POT = input$pot,
        Club = input$club,
        Contract = input$contract,
        Positions = input$positions,
        Height = input$height,
        Weight = input$weight,
        Preferred_Foot = input$foot,
        BOV = input$bov,
        Best_Position = df[idx, "Best_Position"],
        Joined = input$joined,
        AgeGroup = df[idx, "AgeGroup"],
        RatingCategory = df[idx, "RatingCategory"]
      )
      data(df)
    }
  })
  
  observeEvent(input$delete, {
    df <- data()
    data(df[df$ID != input$id, ])
  })
  
  filtered_data <- reactive({
    df <- data()
    
    if (input$filter != "") {
      df <- df[grepl(input$filter, df$Name, ignore.case = TRUE), ]
    }
    
    if (input$nat_filter != "All") {
      df <- df[df$Nationality == input$nat_filter, ]
    }
    
    df <- df[df$Age >= input$age_range[1] & df$Age <= input$age_range[2], ]
    
    df
  })
  
  output$table <- renderDT({
    datatable(filtered_data(), options = list(
      pageLength = 10,
      order = list(list(5, 'desc'))
    ), filter = "top")
  })
  
  output$plot1 <- renderPlotly({
    df <- filtered_data()
    plot_ly(df, x = ~OVA, y = ~POT, type = 'scatter', mode = 'markers', text = ~Name) %>%
      layout(title = "Overall vs Potential")
  })
  
  output$plot2 <- renderPlot({
    df <- filtered_data()
    ggplot(df, aes(x = Age)) +
      geom_histogram(binwidth = 1, fill = "darkorange", color = "black") +
      theme_minimal() +
      labs(title = "Age Distribution", x = "Age", y = "Number of Players")
  })
}


shinyApp(ui, server)
