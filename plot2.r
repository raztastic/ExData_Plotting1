#This section is common to ALL...

#Filter the hpc table for the two dates
library(dplyr)

hpc<-read.table("household_power_consumption.txt", header = TRUE, sep = ";",
                na.strings = "?", stringsAsFactors = FALSE)

t1<-"1/2/2007"
t2<-"2/2/2007"

hpc.trunc2 <- hpc[hpc$Date == t1 | hpc$Date == t2,]

hpc.trunc2$DateTime <-with(hpc.trunc2, paste(Date,Time))
hpc.trunc2$DateTime<- as.POSIXct(hpc.trunc2$DateTime, format = "%d/%m/%Y %H:%M:%S")

###########################################################

# Plot 2

par(mfrow = c(1,1), mar = c(6,6,4,2))

with(hpc.trunc2, plot(DateTime, Global_active_power, type = "l",
                     xlab = "", ylab = "Global Active Power (kilowatts)"))

# create png file
dev.copy(png, 'plot2.png', width = 480, height = 480)
dev.off()
