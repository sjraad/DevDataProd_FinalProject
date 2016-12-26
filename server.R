library(shiny); library(FinCal); library(plotly)
shinyServer(function(input, output) {
    
    TC <- reactive({
        tc <- round((input$variableCost * input$UnitSale) + (input$FixedCost + (input$investment / input$life)), 0)
    }) 
    TR <- reactive({
        tr <- round(input$UnitSale * input$UnitPrice, 0)
    }) 
    profit <- reactive({
        pr <- round(input$UnitSale*input$UnitPrice - (input$variableCost*input$UnitSale +(input$FixedCost+(input$investment/input$life))), 0)
    })
    OCF <- reactive({
        ocf <- round((input$UnitSale*(input$UnitPrice-input$variableCost)-input$FixedCost-(input$investment/input$life))*(1-(input$tax/100))+(input$investment/input$life), 0)
        ocf <- paste(ocf, c("per year"), sep = " ")
    })
    NPV <- reactive({
        ocf <- (input$UnitSale*(input$UnitPrice-input$variableCost)-input$FixedCost-(input$investment/input$life))*(1-(input$tax/100))+(input$investment/input$life)
        factor <- ((1-(1/(1+(input$return/100))^input$life))/(input$return/100))
        npv <- round(ocf*factor-input$investment, 0)
    }) 
    IRR <- reactive({
        ocf <- (input$UnitSale*(input$UnitPrice-input$variableCost)-input$FixedCost-(input$investment/input$life))*(1-(input$tax/100))+(input$investment/input$life)
        irr <- round(irr(c(-input$investment, rep(ocf, input$life)))*100, 0)
        irr <- paste(irr, c("%"), sep = " ")
    }) 
    BE <- reactive({
        be <- round((input$FixedCost+(input$investment/input$life))/(input$UnitPrice-input$variableCost), 2)
        be <- paste(be, c("units"), sep = " ")
    }) 
    CBE <- reactive({
        cbe <- round(input$FixedCost/(input$UnitPrice-input$variableCost), 2)
        cbe <- paste(cbe, c("units"), sep = " ")
    }) 
    FBE <- reactive({
        factor <- ((1-(1/(1+(input$return/100))^input$life))/(input$return/100))
        fbe <- round((input$FixedCost+(input$investment/factor))/(input$UnitPrice-input$variableCost), 2)
        fbe <- paste(fbe, c("units"), sep = " ")
    })
    output$TC <- renderText({TC()})
    output$TR <- renderText({TR()})
    output$profit <- renderText({profit()})
    output$OCF <- renderText({OCF()})
    output$NPV <- renderText({NPV()})
    output$IRR <- renderText({IRR()})
    output$BE <- renderText({BE()})
    output$CBE <- renderText({CBE()})
    output$FBE <- renderText({FBE()})

    output$Plot <- renderPlotly({
        unitsX <- round(seq(0, input$UnitSale*3, by=(input$UnitSale*input$life)/30), 0)
        TRevenue = NULL
        for (i in 1:length(unitsX)) {
            TRevenue[i] = unitsX[i]*input$UnitPrice
            TRevenue
        }
        TCost = NULL
        for (i in 1:length(unitsX)) {
            TCost[i] = (unitsX[i]*input$variableCost)+(input$FixedCost+(input$investment/input$life))
            TCost
        }
        FCost <- input$FixedCost+(input$investment/input$life)
        Legend <- list(font = list(size=9), x=.1, y=1)
        plot_ly(x=unitsX, y=((TRevenue+TCost)/1000)) %>%
            layout(yaxis = list(title = 'Revnue in (000s)'), xaxis = list(title = 'Units Sold'), legend = Legend) %>%
            add_trace(y=TRevenue, line = list(color = 'black'), name = 'Revenue', mode = 'lines') %>%
            add_trace(y=FCost, line = list(color = 'red'), name = 'Fixed costs', mode = 'lines') %>%
            add_trace(y=TCost, line = list(color = 'blue'), name = 'Total costs', mode = 'lines')
        })
})