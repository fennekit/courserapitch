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

mymarker <- function(p, size, sizemode, sizeref, type) {
    
    
    if (size) 
    {
        add_markers(p, x = ~x, y = ~y, z = ~z, color = ~c, 
                    size = ~r,
                    marker = list(symbol = type, sizeref = sizeref, sizemode = sizemode))
    }
    else
    {
        add_markers(p, x = ~x, y = ~y, z = ~z, color = ~c, 
                    size = ~r, marker = list(symbol = type))
    }    
}

createDataframe <- function(n)
{
    set.seed(5)
    x <- as.numeric(runif(n , 0, 100))
    y <- as.numeric(runif(n , 0, 100))
    
    z <- as.numeric(runif(n , 0, 100))
    
    r <- as.numeric(runif(n, 1, 10))
    
    c <- as.numeric(runif(n, 0, 255))
    
    data <-data.frame(x, y, z, r, c)
}
    
# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    currentDataSet = reactive({createDataframe(as.numeric(input$npoints))})
    maxR = reactive({currentDataSet()$r})
    
    output$scatter3Dplot <- renderPlotly({
        size = 10;
        sizeref = ifelse(input$markersizemethod=='area', 
                         2.*max(size)/(max(maxR())**2),
                         2.*max(size)/(max(maxR()))) 
        
        p <- plot_ly(currentDataSet(), 
                     type="scatter3d") %>%
            mymarker(input$markersize, input$markersizemethod, sizeref, input$symboltype)
        p
    })
    
    output$table <- renderTable({currentDataSet()})
})
