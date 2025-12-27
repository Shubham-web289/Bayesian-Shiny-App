mod_posterior_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    
    reactive({
      
      validate(
        need(input$x_success <= input$n_trials,
             "Successes cannot exceed trials")
      )
      
      x <- seq(0.001, 0.999, length.out = input$n_points)
      
      prior <- data.frame(
        x = x,
        y = dbeta(x, input$alpha_prior, input$beta_prior),
        type = "Prior"
      )
      
      likelihood_raw <- dbinom(
        input$x_success,
        size = input$n_trials,
        prob = x
      )
      
      likelihood <- data.frame(
        x = x,
        y = likelihood_raw / max(likelihood_raw) * max(prior$y),
        type = "Likelihood"
      )
      
      posterior <- data.frame(
        x = x,
        y = dbeta(
          x,
          input$alpha_prior + input$x_success,
          input$beta_prior + input$n_trials - input$x_success
        ),
        type = "Posterior"
      )
      
      rbind(prior, likelihood, posterior)
    })
  })
}
