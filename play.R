library(dplyr)
dat=read.csv("C:/Users/Amirreza/Desktop/a.csv",header = F)
colnames(dat) = c("time","A","B","C","D")
head(dat)
dat=as_tibble(dat)
##SETUP1
eval(parse("C:/Users/Amirreza/Desktop/setup.txt"))

##END SETUP





dat=mutate(dat, RfAB = kfAB * A, RbAB = kbAB * B, 
            RfAC = kfAC * A, RbAC = kbAC * C,
            RfBD = kfBD * B, RbBD = kbBD * D,
            RfCD = kfCD * C, RbCD = kbCD * D,
            RfBC = kfBC * B, RbBC = kbBC * C)

#tail(dat[,6:15]) completely agrees with python script

flow=mutate(dat,FAB=(RfAB-RbAB),
                FAC=(RfAC-RbAC),
                FBD=(RfBD-RbBD),
                FCD=(RfCD-RbCD),
                FBC=(RfBC-RbBC))
flow=select(flow,time,FAB,FAC,FBD,FCD,FBC)
plot(flow$time,flow$FAB)
plot(flow$time,flow$FAC)
plot(flow$time,flow$FBD)
plot(flow$time,flow$FCD)
plot(flow$time,flow$FBC)

#IDEAL WB, BC~0 order of e-14,
#others are significant

#hame 1 bashe alie.
#too dar too besaz


#a=select(dat,time, A,B,C,D)
#t = seq(0,20,by=0.01)
#ya = (5/2)*exp(-2*t) + (25/4) + (5/4)*exp(-4*t)
#yb = 25/4 + (-5/4)*exp((-4)*t)
#yc = yb
#yd = (-5/2)*exp((-2)*t) + 25/4 + (5/4)*exp((-4)*t)
#plot(t,ya)

#library(ggplot2)
#ggplot()+geom_point(aes(t,ya))


flow=filter(flow,time>10 & time<15)
