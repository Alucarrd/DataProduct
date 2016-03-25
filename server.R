
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

#load libraries

library(shiny)
library(datasets)
library(dplyr)


shinyServer(function(input, output) {
  
  #render data table and send to output tab
  output$DataTable <- renderDataTable({
    
    #load the horse power range selected by user
    hp_list <- seq(from = input$hp[1], to = input$hp[2], by=1)
    
    #build my data set for the output along with the calculated column GaslineSpendingPerYr
    data <- transmute(mtcars, Car=rownames(mtcars), MPG=mpg
                      , GaslineSpendingPerYr= input$totalMileage/mpg*input$avgGasPrice
                      , Cylinders = cyl
                      ,Horsepower = hp, Transmission = am) 
    
    #filter the data set down based on the user input
    data <- filter(data, GaslineSpendingPerYr < input$totalBudget, Cylinders %in% input$cyl, Horsepower %in% hp_list, Transmission %in% input$am)
    #transform the transmission column data to text
    data <- mutate(data, Transmission = ifelse(Transmission ==0, "Automatic", "Manual"))
    #sort the dataset by GaslineSpendingPerYr
    data <- arrange(data, GaslineSpendingPerYr)
    
    data
    
    
    
  }, 
  #set my paging option
  option = list(lengthMenu = c(5, 10, 15), pageLength=15)
  )

})
