#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)


# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Random points, size, color"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            sliderInput("npoints",
                        "Number of point:",
                        min = 1,
                        max = 100,
                        value = 50),
            hr(),
            helpText("Number of points to show in the 3d plot"),
            
            selectInput("symboltype", "Marker symbol:",
                        c(  "circle" = "circle", 
                            "circle-open" ="circle-open",
                            "square"="square",
                            "square-open" = "square-open",
                            "diamond" = "diamond",
                            "diamond-open" = "diamond",
                            "cross"="cross" )
                        ),
            
            helpText("Type of symbol to use for each point"),
            hr(),
            checkboxInput("markersize", label = "Symbol size", value = TRUE), 
            
            helpText("Make size of the marker dependent on the points r value"),
            hr(),
            
            conditionalPanel(
                condition = "input.markersize == true", # javascript condition
                selectInput("markersizemethod", "Symbol size method:",
                            c(  "area" = "area", 
                                "diameter" ="diameter")),
                helpText("Method to use for determining the size of the marker")
            )
        ),

        # Show a plot of the generated distribution
        mainPanel(
            tabsetPanel(
                tabPanel("Plot", 
                         plotlyOutput("scatter3Dplot",
                                      height = "800px",
                                      width = "800px")),
                tabPanel("Help", verbatimTextOutput("help")),
                tabPanel("Table", tableOutput("table"))
            )
           
        )
    )
))
