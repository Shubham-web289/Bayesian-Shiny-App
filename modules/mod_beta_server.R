mod_beta_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    
    reactive({
      x <- seq(0.001, 0.999, length.out = input$n_points)
      
      data.frame(
        x = x,
        y = dbeta(x, input$alpha, input$beta),
        type = "Beta"
      )
    })
  })
}
