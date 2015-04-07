#Stacks images into tiff files, one stack per sub-folder generated beforehand, and changes the name of the files to the video serial and the folder index, z.B "7654_001.tiff"

start.time <- Sys.time()

system(paste("for i in ", 
             directory, 
             "/*/dir* " ,
             "; do convert $i/*.jpeg -adjoin $i/aStack.tiff; done" , 
             sep = "")
)

oldnames <- system(paste("for i in ", 
                      directory, 
                      "/*/dir*/*.tiff " ,
                      "; do echo $i ; done" , 
                      sep = ""), intern = TRUE
)
newnames <- oldnames

for (i in c(paste(directorio, "MVI_", sep = ""),
                  "dir" ,  
                  "aStack" ,
                  "/")
     ) { newnames <- gsub( i , "" , newnames) }

newnames <-paste(gsub("aStack.tiff" , "" , oldnames), newnames, sep = "")

for (i in c(1:length(oldnames))) {
      system(paste("mv", oldnames[i], newnames[i])) 
}


end.time <- Sys.time()
time.taken <- end.time - start.time
time.taken