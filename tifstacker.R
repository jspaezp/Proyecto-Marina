#Stacks images into tiff files, one stack per sub-folder generated beforehand

start.time <- Sys.time()

system(paste("for i in ", 
             directory, 
             "/*/dir* " ,
             "; do convert $i/*.jpeg -adjoin $i/aStack.tiff; done" , 
             sep = "")
)

end.time <- Sys.time()
time.taken <- end.time - start.time
time.taken