
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

#load my libraries
library(shiny)
library(markdown)

#define navbar page
shinyUI(navbarPage("Pick the car for your budget",
                   #building my first tab for the page
                   tabPanel("DataTable",
                            #building sidebar layout with user input action form
                            sidebarLayout(
                              sidebarPanel(
                                helpText("What is your budget?"),
                                numericInput('totalBudget', 'How much do you plan to spend on gas a year? ($100 ~ $5000)', 5000, min=100, max=5000),
                                numericInput('totalMileage', 'How much miles do you plan to drive a year? (5000 ~ 30,000)', 20000, min=5000, max=30000),
                                numericInput('avgGasPrice', 'Avg Gas Price Per Year ($0.50/year ~ $6.00/year)',  3.25, min=.50, max=6),
                                checkboxGroupInput('cyl', 'Cylinders:', c("Four"=4, "Six" = 6, "Eight"=8), selected=c(4, 6, 8)),
                                sliderInput('hp', 'Horse Power', min=50, max=340, value=c(50, 340), step=10),
                                checkboxGroupInput('am', 'Transmission:', c("Automatic"=0, "Manual"=1), selected=c(0, 1) )
                              ),
                              
                              # main body to display the data table
                              mainPanel(
                                dataTableOutput("DataTable")
                              )         
                            
                            )
                  ),
                  #Second tab for About markdown
                  tabPanel("About",
                           #Load the about.md to the body of the About tab page
                           mainPanel(
                              includeMarkdown("about.md")
                           ))
))
