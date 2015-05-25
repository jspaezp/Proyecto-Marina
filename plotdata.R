#data plotting
start.time <- Sys.time()

require(ggplot2)
require(signal)
require(seewave) # esta en prueba, puede que sea util

require(data.table)
require(dplyr)
require(tidyr)

directory <- "/home/sebastian/Documents/2015/Unal/Marina/Proyecto-Marina/data"

importantdata <- read.table(paste(directory, "/importantdata.txt", sep = ""),
                            #sep = "\t",
                            header = TRUE
                            ) %>% data.table

spliteddata <- importantdata[, list(list(.SD)), by = Video]$V1
names(spliteddata) <- unique(importantdata$Video)

filternumber <- 15 
meltedata <- spliteddata

for (i in c(1:length(spliteddata))) {
  for (a in c(1:filternumber)) {
    spliteddata[[i]] <- (spliteddata[[i]])[,X] %>%
      fftfilt(rep(1,a)/a, .) %>% 
      cbind(spliteddata[[i]], .)
  }
  setnames(spliteddata[[i]], 6:(length(spliteddata[[i]])), 
           paste("F", c(1:filternumber), sep = ""))
   meltedata[[i]] <- melt(spliteddata[[i]], 
        id.vars = c(1:5),
        measure.vars = paste("F", c(1:filternumber), sep = ""), 
        variable.name = "AnchoDeFiltro") %>%
    tbl_df
}

wholetiddydata <- data.table()

for (i in c(names(meltedata))) {
  wholetiddydata <- 
  mutate(meltedata[[i]], Video = i) %>%
    bind_rows(wholetiddydata)
}

write.table(wholetiddydata ,
            file = "./wholetiddydata.txt" , 
            row.names = FALSE, 
            sep = "\t"
)


g <- ggplot(wholetiddydata , 
            aes(y = value, x = Consecutivo, colour = AnchoDeFiltro)) + 
  geom_line() + 
  facet_grid( Video ~ . )
g
ggsave("todofiltro.png", g, width=40, height=30)

########## pendiente normalizar datos por media

importantdata  %>% group_by(Video) 


select(importantdata, X, Video, Consecutivo)  %>% 
  sapply(. , as.numeric) %>%  
  data.table %>% 
  group_by(., Video)  %>% 
  select(X) %>% 
  fft()  %>% 
  abs()

importantdata[,X] %>% fft() %>% abs() %>% specgram(64, Fs = 6)
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

 