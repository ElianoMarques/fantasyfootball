library(shiny)

# Define UI for miles per gallon application
shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel(""),
    
  mainPanel(
  plotOutput("demoplot"),plotOutput("demoplot2")
               #div(class="span5",plotOutput("hist")),div(class="span5",plotOutput("histdbh"))),
      #tabPanel("Code",verbatimTextOutput("code"))
    ),
  
  sidebarPanel(
    helpText("Takes a player's per-game points above the league average, 
             multiplies it by the value below, and adds to the player's score."),
    sliderInput("multiplier", "Multiplier for points above average:",
                min = 0, max=5,value=0, step=0.5),
    helpText("Should players with below league-average points per game LOSE points?"),
    radioButtons('noneg', 'Allow negative values:',
                 c('No'=TRUE,
                   'Yes'=FALSE)),
    helpText("Below, set the bonus points given to each playoff seed (1-3).
             Bonus points are calculated as a proportion (specify below) of
             the league average points-per-game and added to the player's score."),
    sliderInput("bonus1", "Bonus for 1st Seed:",
                min = 0, max=0.3,value=0, step=0.05),
    sliderInput("bonus2", "Bonus for 2nd Seed:",
                min = 0, max=0.3,value=0, step=0.05),
    sliderInput("bonus3", "Bonus for 3rd Seed:",
                min = 0, max=0.3,value=0, step=0.05)
  )
  ))