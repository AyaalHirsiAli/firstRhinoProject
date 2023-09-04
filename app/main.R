# app/main.R

box::use(
  shiny[bootstrapPage, div, h1, icon, moduleServer, NS, tags],
)
box::use(
  app/view/chart,
  app/view/table,
)

#' @export
ui <- function(id) {
  ns <- NS(id)

  bootstrapPage(
    h1("RhinoApplication"),
    div(
      class = "components-container",
      table$ui(ns("table")),
      chart$ui(ns("chart"))
    ),
    tags$button(
      id = "help-button",
      icon("question"),
      onclick = "App.showHelp()"
    )
  )
}

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {
    # Datasets are the only case when you need to use :: in `box`.
    # This issue should be solved in the next `box` release.
    data <- rhino::rhinos

    table$server("table", data = data)
    chart$server("chart", data = data)
  })
}
