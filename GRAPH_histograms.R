
####Generate Histograms Based on Fantasy Football Data

###########################################################################

###Read in dataset

graphdata = read.csv('graphdata.csv',header=TRUE)
#Four columns: 
#(1) Player = Player name (n=20)
#(2) TotPtsZ = Mean Z score for player's total season points
#(3) WinPct = Mean regular season win percentage for all seasons
#(4) ChampPct = Mean league champion percentage for all seasons


###Overall player win percentage histogram

hist(graphdata$WinPct, prob=TRUE,main='Mean player win %',xlab='Win Percentage',col=rgb(220,57,18,max=255))    
# prob=TRUE since variable is percentage

#Draw smoothed density line
lines(density(graphdata$WinPct,adjust=1.8),lwd=3,col="black") 

#Add identification info
text(0.6,7,"1. Mark S. (.625)")
text(0.6,6.5,"2. Ken (.600)")
text(0.6,6,"3. Tom S. (.550)")
text(0.6,5.5,"4. Tom G. (.540)")
text(0.6,5,"5. Steve (.530)")


###Championship percent histogram

hist(graphdata$ChampPct, breaks=5,prob=TRUE,main='How often do players win the title?',xlab='% of League Championships',col=rgb(255,153,0,max=255)) 

#Draw smoothed density line
lines(density(graphdata$ChampPct,adjust=0.9),lwd=3,col="black")

#Add identification info
text(0.25,8,"1. Colin (.333)")
text(0.25,7,"2. Terry (.250)")
text(0.25,6,"2. Stef (.250)")
text(0.25,5,"4. Tom G. (.200)")
text(0.25,4,"5. 2-way tie (.167)")


###Z score histogram of points scored by player

hist(graphdata$TotPtsZ, breaks=5,prob=TRUE,main='Total Points Scored',xlab='Z-score of Total Points',col=rgb(51,102,204,max=255))   

#Draw smoothed density line
lines(density(graphdata$TotPtsZ,adjust=2),lwd=3,col="black")

#Add identification information
text(1,.8,"1. Mark S. (1.148)")
text(1,.7,"2. Colin (0.520)")
text(1,.6,"3. Tom S. (0.388)")
text(1,.5,"4. Tom G. (.302)")
text(1,.4,"5. Ken (.280)")
