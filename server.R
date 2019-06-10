#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)

mymarker <- function(p, circle, type) {
    if (circle) 
    {
        add_markers(p, x = ~x, y = ~y, z = ~z, color = ~c, 
                    size = ~r,
                    marker = list(symbol = type, sizemode = 'diameter'))
    }
    else
    {
        add_markers(p, x = ~x, y = ~y, z = ~z, color = ~c, 
                    size = ~r, marker =list(symbol = type))
    }    
}

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    output$scatter3Dplot <- renderPlotly({
        n <- input$npoints;
        
        x <- as.numeric(runif(n , 0, 100))
        y <- as.numeric(runif(n , 0, 100))
        
        z <- as.numeric(runif(n , 0, 100))
        
        r <- as.numeric(runif(n, 2, 50))
        c <- as.numeric(runif(n, 0, 255))
        
        data <-data.frame(x, y, z, r, c)
        
        p <- plot_ly(data, 
                     type="scatter3d") %>%
            mymarker(input$circle, input$symboltype)
        p
        
    })
})
