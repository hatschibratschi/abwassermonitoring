
#library(shiny)

# Define server logic required to draw a histogram
function(input, output, session) {

    output$distPlot <- renderPlotly({

      ggplotly(
        ggplot(dataPlot, aes(Datum, value, colour = variable)) +
          geom_line() +
          scale_color_manual(values=c("orange", "royalblue1")) +
          theme(axis.title.x = element_blank(),
                axis.title.y = element_blank(), 
                axis.text.y=element_blank(),
                axis.ticks.y=element_blank(),
                legend.title = element_blank()
          )
      )
    })
}
