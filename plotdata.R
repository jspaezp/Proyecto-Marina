#data plotting
start.time <- Sys.time()

require(ggplot2)
require(signal)

require(data.table)
require(dplyr)
require(tidyr)

importantdata[,Y] %>% fft() %>% abs() %>% specgram(32, Fs = 6)
qplot(data = importantdata,y = Y, Consecutivo)

filternumber <- 30 
for (i in c(1:filternumber)) {
importantdata <- importantdata[,Y] %>% fftfilt(rep(1,i)/i, .) %>% cbind(importantdata, .)
}

setnames(importantdata, 6:(length(importantdata)), as.character(c(1:filternumber)))


melteddata <- melt(importantdata, 
                   id.vars = c(1:5),
                   measure.vars = as.character(c(1:filternumber)), 
                   variable.name = "AnchoDeFiltro") %>% 
            data.table 


ggplot(melteddata , aes(y = value, x = Consecutivo, colour = AnchoDeFiltro)) + 
      geom_line() + xlim(17, 400) + ylim(250, 330)

 