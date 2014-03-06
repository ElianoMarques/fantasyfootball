##Server code for fantasy football playoff seeds shiny app.
##See app in action here (if it's working...): rserver.kenkellner.com/playoffseeds

#Load necessary libraries
library(shiny)

#Read in full dataset
#Each line represents one playoff team in a single year/season
data = read.csv('playoffseeds.csv',header=TRUE)

#Function to simulate playoff results given particular seeding bonuses
#Bonuses based on regular season performance

sim = function(data=NULL,noneg=TRUE,multiplier=0,bonus1=0,bonus2=0,bonus3=0){
  
#Noneg: if TRUE, penalizes player for having below average mean points per game  
  
#Multiplier: Takes a player's per-game points above the league average, multiplies it by the given value, 
#and adds to the player's score in each playoff game.
  
#Bonus1-3: Points bonus given to the first thru 3rd seeds in each playoff game.
#Points bonus is calculated as a proportion (given) of league average points-per-game

#Create empty output file
output = data.frame(matrix(data=FALSE,nrow=16,ncol=4))
names(output) = c("Winner","TopSeed","TopPts","PtRank")

#iterate through all 16 league/years
for (i in 1:16){
  #Select a given league/year and data of interest from datafile
  select = data[data$ID==i,]
  scores = select[,9:10]
  avgpts = select$playeravg-select$points.game
  seed = select$Seed
  
  #If noneg is TRUE, set avgpoints for those scoring less than the league average to 0.
  if(noneg==TRUE){
    avgpts[which(avgpts<0)] = 0
  }
  
  #Make adjustments to scores based on chosen options
  scores[1,] = scores[1,] + (multiplier*avgpts[1]) + (bonus1*select$points.game[1])
  scores[2,] = scores[2,] + (multiplier*avgpts[2]) + (bonus2*select$points.game[1])
  scores[3,] = scores[3,] + (multiplier*avgpts[3]) + (bonus3*select$points.game[1])
  scores[4,] = scores[4,] + (multiplier*avgpts[4])
  
  #Simulate round 1 results based on historical scores by each player (plus bonuses if any)
  #Done by comparing scores andd selecting player with higher score to move on
  win1.1 = 1
  if(scores[1,1]<scores[4,1]){
    win1.1 = 4}
  win1.2 = 2
  if(scores[2,1]<scores[3,1]){
    win1.2 = 3}
  
  #Simulate round 2 based on round 1 results to get champion
  win2 = min(win1.1,win1.2)
  if(scores[min(win1.1,win1.2),2]<scores[max(win1.1,win1.2),2]){
    win2 = max(win1.1,win1.2)
  }
  
  #Fill in columns of output file with results
  output[i,1] = win2
  output[i,4] = select[win2,"Points"]
  
  #Determine if top seed won championship and put in output file
  if(win2 == 1){
    output[i,2] = TRUE
  }
  
  #Determine if top points-scorer in regular season won championship
  if(select[win2,"Points"]==1){
    output[i,3] = TRUE
  }
}
#return final output file
return(output)
}

#Actual server code here

shinyServer(function(input, output) {
  
  #'Reactive' part of server: re-run simulation when inputs are changed
  runsim = reactive(
    sim(data=data,
        noneg = input$noneg,
        multiplier = input$multiplier,
        bonus1 = input$bonus1,
        bonus2 = input$bonus2,
        bonus3 = input$bonus3)      
    )
  
  #Generate reactive bar plot of how many league championships were won by each playoff seed based on
  #specified bonus conditions
  output$demoplot = renderPlot({
    test = runsim()
    barplot(summary(as.factor(test$Winner)),main="League Championships by Playoff Seed",
            xlab="Playoff Seed", ylab="Number of League Championships",            
            col=c(rgb(220,57,18,max=255),rgb(16,150,24,max=255),
            rgb(255,153,0,max=255),rgb(51,102,204,max=255)))
  })
  
  #Generate reactive bar plot of how many league championships were won by total regular season points rank under
  #specified bonus conditions
  output$demoplot2 = renderPlot({
    test = runsim()
    barplot(summary(as.factor(test$PtRank)),main="League Championships by Regular Season Total Points Ranking",
            xlab="Rank in Total Points Scored (Regular Season)", ylab="Number of League Championships",
            col = rgb(220,57,18,max=255))
  })

})

#end server code