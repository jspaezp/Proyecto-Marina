## lee y organiza la informacion a modo R-legible

start.time <- Sys.time()

require(data.table)
require(dplyr)
require(tidyr)



directory <- "/home/sebastian/Documents/2015/Unal/Marina/Proyecto_Personal/"
setwd(directory)
measurements <- system("pwd |find | grep \".txt\" ", intern = TRUE)
VariableNames <- gsub(".*/|.txt|_" ,"", measurements) %>% 
                  paste("V" , . , sep = "") 
alldata <- data.table()

#podria definirlo ..... considerelo como funcion para que vaya borrando las variables viejas y dejar solo la completa...
for ( i in c(1:length(measurements)) ) { 
      assign( VariableNames[i] , 
             read.table(measurements[i])
      )
      alldata <- rbind(alldata, get(VariableNames[i])) 
}

importantdata <- alldata %>% data.table %>%
                  separate(Label, c("Video","Directorio","tiff","Slice2"))
importantdata <- importantdata[,.(Y,Video,Directorio, Slice)]
importantdata <- mutate(importantdata, Directorio = as.numeric(Directorio))
importantdata <- importantdata %>% 
                  mutate( Consecutivo = 100*(Directorio) + Slice - 100)

importantdata %>% setorder(. , Consecutivo) ## Mucho mas improtante de lo que parece


end.time <- Sys.time()
time.taken <- end.time - start.time
time.taken

