## AHORA SI ANALISIS DE DATOS ... bueno la verdad solo lectura de las tablas y union de las mismas

start.time <- Sys.time()

require(data.table)
require(dplyr)




directory <- "/home/sebastian/Documents/2015/Unal/Marina/Proyecto_Personal/"
setwd(directory)
measurements <- system("pwd |find | grep \".txt\" ", intern = TRUE)
alldata <- data.table()

#podria definirlo como funcion para que vaya borrando las variables viejas y dejar solo la completa...
for ( i in c(1:length(measurements)) ) { 
      assign( VariableNames[i] , 
             read.table(measurements[i])
      )
      alldata <- rbind(alldata, get(VariableNames[i])) 
}


end.time <- Sys.time()
time.taken <- end.time - start.time
time.taken


