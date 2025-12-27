library(shiny)
library(plotly)

source("modules/mod_beta_ui.R")
source("modules/mod_beta_server.R")
source("modules/mod_posterior_ui.R")
source("modules/mod_posterior_server.R")

ui <- fluidPage(
  
  titlePanel("Bayesian Beta–Binomial Explorer"),
  
  sidebarLayout(
    sidebarPanel(
      radioButtons(
        "mode",
        "Select Mode",
        choices = c("Beta", "Posterior"),
        selected = "Beta"
      ),
      
      conditionalPanel(
        condition = "input.mode == 'Beta'",
        mod_beta_ui("beta")
      ),
      
      conditionalPanel(
        condition = "input.mode == 'Posterior'",
        mod_posterior_ui("posterior")
      )
    ),
    
    mainPanel(
      plotlyOutput("plot", height = "450px")
    )
  )
)

server <- function(input, output) {
  
  beta_data      <- mod_beta_server("beta")
  posterior_data <- mod_posterior_server("posterior")
  
  output$plot <- renderPlotly({
    
    df <- if (input$mode == "Beta") {
      beta_data()
    } else {
      posterior_data()
    }
    
    plot_ly(
      data = df,
      x = ~x,
      y = ~y,
      color = ~type,
      type = "scatter",
      mode = "lines"
    ) %>%
      layout(
        xaxis = list(title = "Probability p"),
        yaxis = list(title = "Density / Scaled Likelihood")
      )
  })
}

shinyApp(ui, server)
