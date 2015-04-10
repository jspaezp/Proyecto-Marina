

directory <- "/home/sebastian/Documents/2015/Unal/Marina/Proyecto_Personal/"
setwd(directory)
inputfiles <- system("ls -a | grep \".MOV\" ", intern = TRUE)
inputfiles


#Extraccion de Imagenes

start.time <- Sys.time()

for (i in inputfiles) {
      setwd(directory)
      isinMOV <- gsub(".MOV","",  i)
      command <- paste("ffmpeg -i", " ", i, " ", "-r 6 -s 1080x608 -f image2",
                       " " , directory , "/" , isinMOV , "/" , isinMOV , 
                       "-%4d.jpeg", sep = "") 
      system(paste("mkdir", isinMOV))
      system(command)
      setwd(paste(directory, "/" ,isinMOV, sep = ""))
      system("i=0; for f in *.jpeg; do d=dir_$(printf %03d $((i/100+1))); 
             mkdir -p $d; mv \"$f\" $d; let i++; done")
}

setwd(directory)
end.time <- Sys.time()
time.taken <- end.time - start.time
time.taken