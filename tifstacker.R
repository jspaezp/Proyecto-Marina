#Stacks images into tiff files, one stack per sub-folder generated beforehand, and changes the name of the files to the video serial and the folder index, z.B "7654_001.tiff"

start.time <- Sys.time()

directory <- "/home/sebastian/Documents/2015/Unal/Marina/Proyecto_Personal/"

system(paste("for i in ", 
             directory, 
             "*/dir* " ,
             "; do convert $i/*.jpeg -adjoin $i/aStack.tiff; done" , 
             sep = "")
)

oldnames <- system("pwd | find | grep \".tiff\" ", intern = TRUE)

newnames <- gsub(".*MVI_|aStack|/|dir" ,"", oldnames)

newnames <-paste(gsub("aStack.tiff" , "" , oldnames), newnames, sep = "")

for ( i in c( 1:length(oldnames) )  ) {
      system(paste("mv", oldnames[i], newnames[i])) 
}


end.time <- Sys.time()
time.taken <- end.time - start.time
time.taken