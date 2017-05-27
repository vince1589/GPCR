exp<-read.table("activity.dat")
data<-read.table("raw.dat")

pdf("all_res.pdf")
myAll<-NULL
for(myId in unique(as.vector(data[,3]))) {
	
	wrk<-data[data[,3] == myId,]
	myCor<-cor(wrk[match(exp[,1],wrk[,1]),4],exp[,2],method="k")
	myAll<-rbind(myAll,c(as.vector(wrk[1,2]),myCor))
	if (abs(myCor) < 0.7) {next}
	print(paste(as.vector(wrk[1,2]),myCor))
	plot(wrk[match(exp[,1],wrk[,1]),4],exp[,2],xlab="Delta S",ylab="Exp",main=paste(wrk[1,2], sprintf("%.2f",myCor)),type="n")
	text(wrk[match(exp[,1],wrk[,1]),4],exp[,2],exp[,1])
	
	#break	
}
dev.off()

