#data plotting
start.time <- Sys.time()

require(ggplot2)
require(signal)
install.packages("audio", "rgl", "rpanel")
require(seewave) # esta en prueba, puede que sea util

require(data.table)
require(dplyr)
require(tidyr)

importantdata[,Y] %>% fft() %>% abs() %>% specgram(32, Fs = 6)
qplot(data = importantdata,y = Y, Consecutivo)

filternumber <- 30 
for (i in c(1:filternumber)) {
importantdata <- importantdata[,Y] %>%
                  fftfilt(rep(1,i)/i, .) %>% 
                  cbind(importantdata, .)
}

setnames(importantdata, 6:(length(importantdata)), 
         paste("F", c(1:filternumber), sep = ""))


melteddata <- melt(importantdata, 
                   id.vars = c(1:5),
                   measure.vars = paste("F", c(1:filternumber), sep = ""), 
                   variable.name = "AnchoDeFiltro") %>% 
            data.table 


g <- ggplot(melteddata , 
            aes(y = value, x = Consecutivo, colour = AnchoDeFiltro)) + 
            geom_line() + 
            xlim(filternumber, 400) + 
            ylim(250, 330)
ggsave("filtersplot.png", g, width=20, height=14)


##revisar ggspectro y spectro3D
importantdata[,F10] %>% spectro3D(. , f= 6, wl = 128, ovlp= 75) #huh....that does look fun
importantdata[,F10] %>% spectro(. , f= 6, wl = 8, ovlp= 75, norm = TRUE) #huh....that does look fun


importantdata[,F30] %>% fft() %>% abs %>% specgram(64, Fs = 6)

 