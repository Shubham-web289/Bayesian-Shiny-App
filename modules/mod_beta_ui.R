mod_beta_ui <- function(id) {
  ns <- NS(id)
  
  tagList(
    sliderInput(ns("alpha"), "Alpha (α)", 0.1, 10, 2, 0.1),
    sliderInput(ns("beta"),  "Beta (β)",  0.1, 10, 2, 0.1),
    sliderInput(ns("n_points"),
                "Number of sample points",
                100, 2000, 500, 100)
  )
}
