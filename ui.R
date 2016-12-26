library(shiny); library(FinCal); library(plotly)
shinyUI(fluidPage(
    
    tags$style(HTML("
        @import url('https://fonts.googleapis.com/css?family=PT+Sans');
    ")),
    
    titlePanel(
        h1("Break-even Analysis",
           style = "font-family: 'PT Sans', sans-serif; color: #336699; font-size: 35px;")),
    
    fluidRow(
        column(4, style = "font-family: 'PT Sans', sans-serif; color: #336699; font-size: 15px;",
            wellPanel(
                numericInput("investment", "Initial investment", 
                         value = 0, min = 0),
                numericInput("tax", "Tax rate (%)", 
                         value = 35, min = 5, max = 35)
            )
        ),
        
        column(4, style = "font-family: 'PT Sans', sans-serif; color: #336699; font-size: 15px;",
            wellPanel(
                numericInput("variableCost", "Variable cost per unit", 
                         value = 0, min = 0),
                numericInput("FixedCost", "Fixed cost", 
                         value = 0, min = 0)
            )
        ),
        
        column(4, style = "font-family: 'PT Sans', sans-serif; color: #336699; font-size: 15px;",
               wellPanel(
                   numericInput("UnitSale", "Expected units sold per year", 
                                value = 0, min = 0),
                   numericInput("UnitPrice", "Expected price per unit", 
                                value = 0, min = 0)
               )
        ),
        
        column(4, style = "font-family: 'PT Sans', sans-serif; color: #336699; font-size: 15px;",
               wellPanel(
                   sliderInput("life", "Investment life (yrs)",
                               1, 15, value = 5)               )
        ),
        
        column(4, style = "font-family: 'PT Sans', sans-serif; color: #336699; font-size: 15px;",
               wellPanel(
                   sliderInput("return", "Required return on investment (%)",
                               0, 30, value = 5)
               )
        )
    ),

    hr(),
    
    column(3, style = "font-family: 'PT Sans', sans-serif; color: #336699; font-size: 14px;",
        wellPanel(
            h5("Total cost", style = "font-weight: bold;"), textOutput("TC"),
            h5("Total revenue", style = "font-weight: bold;"), textOutput("TR"),
            h5("Expected profit", style = "font-weight: bold;"), textOutput("profit"),
            h5("Operating Cash-flows", style = "font-weight: bold;"), textOutput("OCF"),
            h5("Net Present Value", style = "font-weight: bold;"), textOutput("NPV"),
            h5("Internal rate of return", style = "font-weight: bold;"), textOutput("IRR"),
            h5("Break-even", style = "font-weight: bold;"), textOutput("BE"),
            h5("Cash Break-even", style = "font-weight: bold;"), textOutput("CBE"),
            h5("Financial Break-even", style = "font-weight: bold;"), textOutput("FBE")
        )
    ),
    
    column(9, 
        wellPanel(style="background-color: white;",
            plotlyOutput("Plot")
        )
    )
))