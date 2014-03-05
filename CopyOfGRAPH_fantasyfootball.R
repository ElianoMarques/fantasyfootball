###Win pct histogram

winpct = read.csv('winpct.csv',header=TRUE)
hist(winpct$Pct,breaks=5)

X <- winpct$Pct
hist(X, prob=TRUE,main='Mean player win %',xlab='Win Percentage',col=rgb(220,57,18,max=255))            # prob=TRUE for probabilities not counts
lines(density(X,adjust=1.8),lwd=3,col="black")  
text(0.6,7,"1. Mark S. (.625)")
text(0.6,6.5,"2. Ken (.600)")
text(0.6,6,"3. Tom S. (.550)")
text(0.6,5.5,"4. Tom G. (.540)")
text(0.6,5,"5. Steve (.530)")

##Playoff pct histogram graph
playoffpct = read.csv('playoffpct.csv',header=TRUE)
hist(playoffpct$playoffpct,breaks=5)

X <- playoffpct$playoffpct
hist(X, breaks=10,prob=TRUE,main='How often do players reach the playoffs?',xlab='% of Leagues in Playoffs',col=rgb(16,150,24,max=255),xlim=c(0,1))            # prob=TRUE for probabilities not counts
lines(density(X,adjust=0.7),lwd=3,col="black")
text(0.75,2.7,"1. Mark S. (.833)")
text(0.75,2.4,"2. Stef (.750)")
text(0.75,2.1,"3. Colin (.667)")
text(0.75,1.8,"4. Ken (.563)")
text(0.75,1.5,"5. 4-way tie (.500)")

##Championship percent
champpct = read.csv('champpct.csv',header=TRUE)

X <- champpct$champpct
hist(X, breaks=5,prob=TRUE,main='How often do players win the title?',xlab='% of League Championships',col=rgb(255,153,0,max=255))   
lines(density(X,adjust=0.9),lwd=3,col="black")
text(0.25,8,"1. Colin (.333)")
text(0.25,7,"2. Terry (.250)")
text(0.25,6,"2. Stef (.250)")
text(0.25,5,"4. Tom G. (.200)")
text(0.25,4,"5. 2-way tie (.167)")


##Points
##Z score histogram of points scored by player
points = read.csv('points.csv',header=TRUE)

X <- points$zscore
hist(X, breaks=5,prob=TRUE,main='Total Points Scored',xlab='Z-score of Total Points',col=rgb(51,102,204,max=255))   
lines(density(X,adjust=2),lwd=3,col="black")
text(1,.8,"1. Mark S. (1.148)")
text(1,.7,"2. Colin (0.520)")
text(1,.6,"3. Tom S. (0.388)")
text(1,.5,"4. Tom G. (.302)")
text(1,.4,"5. Ken (.280)")




