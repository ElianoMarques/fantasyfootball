library(shiny)


data = read.csv('playoffs.csv',header=TRUE)

sim = function(data=NULL,noneg=TRUE,multiplier=0,bonus1=0,bonus2=0,bonus3=0){

output = data.frame(matrix(data=FALSE,nrow=16,ncol=4))
names(output) = c("Winner","TopSeed","TopPts","PtRank")

#iterate through all 16 league/years
for (i in 1:16){
  #Select a given league/year
  select = data[data$ID==i,]
  scores = select[,9:10]
  avgpts = select$playeravg-select$points.game
  if(noneg==TRUE){
    avgpts[which(avgpts<0)] = 0
    }
  seed = select$Seed
  #Make adjustments
  scores[1,] = scores[1,] + (multiplier*avgpts[1]) + (bonus1*select$points.game[1])
  scores[2,] = scores[2,] + (multiplier*avgpts[2]) + (bonus2*select$points.game[1])
  scores[3,] = scores[3,] + (multiplier*avgpts[3]) + (bonus3*select$points.game[1])
  scores[4,] = scores[4,] + (multiplier*avgpts[4])
  
  #round 1
  win1.1 = 1
  if(scores[1,1]<scores[4,1]){
    win1.1 = 4}
  win1.2 = 2
  if(scores[2,1]<scores[3,1]){
    win1.2 = 3}
  
  #round 2
  win2 = min(win1.1,win1.2)
  if(scores[min(win1.1,win1.2),2]<scores[max(win1.1,win1.2),2]){
    win2 = max(win1.1,win1.2)
  }
  
  #test for conditions
  output[i,1] = win2
  output[i,4] = select[win2,"Points"]
  
  if(win2 == 1){
    output[i,2] = TRUE
  }
  if(select[win2,"Points"]==1){
    output[i,3] = TRUE
  }
}
return(output)
}
  
shinyServer(function(input, output) {
  
  runsim = reactive(
    sim(data=data,
        noneg = input$noneg,
        multiplier = input$multiplier,
        bonus1 = input$bonus1,
        bonus2 = input$bonus2,
        bonus3 = input$bonus3)      
    )
  
  output$demoplot = renderPlot({
    test = runsim()
    barplot(summary(as.factor(test$Winner)),main="League Championships by Playoff Seed",
            xlab="Playoff Seed", ylab="Number of League Championships",            
            col=c(rgb(220,57,18,max=255),rgb(16,150,24,max=255),
            rgb(255,153,0,max=255),rgb(51,102,204,max=255)))
  })
  output$demoplot2 = renderPlot({
    test = runsim()
    barplot(summary(as.factor(test$PtRank)),main="League Championships by Regular Season Total Points Ranking",
            xlab="Rank in Total Points Scored (Regular Season)", ylab="Number of League Championships",
            col = rgb(220,57,18,max=255))
  })

})