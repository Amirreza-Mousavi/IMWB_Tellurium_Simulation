###Initilization
library(dplyr)
library(ggplot2)

options(max.print=3000)
graphics.off()
par(mar=c(1,1,1,1))

###Load simualtion data
dat=read.csv("simulation_result.csv",header = F)
colnames(dat) = c("time","A","B","C","D")
head(dat) #Just to get the general idea
dat=as_tibble(dat)

###Load setup data
eval(parse("simulation_setup.txt"))

###Data wrangling
###Calculate Rate of the reactions
dat=mutate(dat, RfAB = kfAB * A, RbAB = kbAB * B, 
            RfAC = kfAC * A, RbAC = kbAC * C,
            RfBD = kfBD * B, RbBD = kbBD * D,
            RfCD = kfCD * C, RbCD = kbCD * D,
            RfBC = kfBC * B, RbBC = kbBC * C)

###Calculate Flow
flow=mutate(dat,FAB=(RfAB-RbAB),
                FAC=(RfAC-RbAC),
                FBD=(RfBD-RbBD),
                FCD=(RfCD-RbCD),
                FBC=(RfBC-RbBC))
flow=select(flow,time,FAB,FAC,FBD,FCD,FBC)

###Select the disruption time
flow=filter(flow,time>10)
flow=filter(flow,time<15)

###Output plots as pdf. Specially Look at the last plot.
pdf("results.pdf",width = 16,height = 9)
plot(flow$time,flow$FAB)
plot(flow$time,flow$FAC)
plot(flow$time,flow$FBD)
plot(flow$time,flow$FCD)
plot(flow$time,flow$FBC)
dev.off()
