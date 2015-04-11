#data plotting
start.time <- Sys.time()

require(ggplot2)
require(signal)

require(data.table)
require(dplyr)
require(tidyr)

importantdata[,Y] %>% fft() %>% abs() %>% specgram(32, Fs = 6)
qplot(data = importantdata,y = Y, Consecutivo)
yfiltrado <- importantdata[,Y] %>% fftfilt(rep(1,10)/10, .) 

mutate(importantdata, yfiltrado = (importantdata[,Y] %>%
                                    fftfilt(rep(1,10)/10, .)
                                   )
)

importantdata %>% setorder(. , Consecutivo) ## Mucho mas improtante de lo que parece
importantdata[,Y] %>% fftfilt(rep(1,3)/3, .) %>% plot()
 