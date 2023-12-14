fluidPage(
    titlePanel("Abwassermonitor"),
    verticalLayout(
        mainPanel(
          plotlyOutput("distPlot")
        )
    )
)