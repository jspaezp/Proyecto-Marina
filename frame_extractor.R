#Takes all files with extension .MOV from a directory and extracts 6 frames 
#per second, organizing them every 100 images in a folder (within a folder whose 
#names is the same as the .MOV file)
#

start.time <- Sys.time()

directory <- "/home/sebastian/Documents/2015/Unal/Marina/Proyecto_Personal"
setwd(directory)
system("ls -a | grep \".MOV\" > inputfiles.txt")

inputfiles <- as.vector(
      (read.table("inputfiles.txt"))$V1
)
inputfiles


for (i in inputfiles) {
      setwd(directory)
      i.without.MOV <- gsub(".MOV","",  i)
      command <- paste("ffmpeg -i" , " " , i , " " , "-r 6 -f image2" , " " ,
                       directory , "/" , i.without.MOV , "/" , i.without.MOV , "-%3d.jpeg",
                       sep = "") 
      system(command)
      system(paste("mkdir", i.without.MOV))
      setwd(paste(directory, "/" ,i.without.MOV, sep = ""))
      system("for file in ./*.jpeg; do convert $file -resize 1080 $file; done")
      system("i=0; for f in *; do d=dir_$(printf %03d $((i/100+1))); mkdir -p $d; 
             mv \"$f\" $d; let i++; done")
      
}

system(paste("for i in ", 
             directory, 
             "/*/dir* " ,
             "; do convert $i/*.jpeg -adjoin $i/aStack.tiff; done" , 
             sep = "")
)

setwd(directory)
end.time <- Sys.time()
time.taken <- end.time - start.time
time.taken


# system("tree -L 1 | cat")
# 
# system("tree ./MVI_7654 -L 1 | head -20 |cat")
# 
# system("tree ./MVI_7654 -L 2 | head -20 |cat")


## ImageJ
# falta medir
