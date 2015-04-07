#Stacks images into tiff files, one stack per sub-folder generated beforehand

start.time <- Sys.time()

system(paste("for i in ", 
             directory, 
             "/*/dir* " ,
             "; do convert $i/*.jpeg -adjoin $i/aStack.tiff; done" , 
             sep = "")
)


tiffs <- system(paste("for i in ", 
                      directory, 
                      "/*/dir*/*.tiff " ,
                      "; do echo $i ; done" , 
                      sep = ""), intern = TRUE
)

newnames <- gsub( paste(directorio, "MVI_", sep = "") , "" , tiffs)
newnames <-gsub( "dir" , "" , newnames)
newnames <-gsub( "aStack" , "" , newnames)
newnames <-gsub( "/" , "" , newnames)
newnames <-paste(gsub("aStack.tiff" , "" , tiffs), newnames, sep = "")

for (i in c(1:length(tiffs))) {
      system(paste("mv", tiffs[i], newnames[i])) 
}


end.time <- Sys.time()
time.taken <- end.time - start.time
time.taken