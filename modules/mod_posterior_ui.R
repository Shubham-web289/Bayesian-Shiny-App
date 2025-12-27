mod_posterior_ui <- function(id) {
  ns <- NS(id)
  
  tagList(
    h4("Prior (Beta)"),
    sliderInput(ns("alpha_prior"), "α₀ (prior)", 0.1, 10, 2, 0.1),
    sliderInput(ns("beta_prior"),  "β₀ (prior)", 0.1, 10, 2, 0.1),
    
    h4("Binomial Data"),
    numericInput(ns("n_trials"), "Number of trials (n)", 20, min = 1),
    numericInput(ns("x_success"), "Number of successes (x)", 10, min = 0),
    
    sliderInput(ns("n_points"),
                "Number of sample points",
                100, 2000, 500, 100)
  )
}
