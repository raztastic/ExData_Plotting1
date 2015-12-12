
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

#Plot 4

par(mfrow = c(2,2))

with(hpc.trunc2, plot(DateTime, Global_active_power, type = "l",
                     xlab = "", ylab = "Global Active Power (kilowatts)"))

with(hpc.trunc2, plot(DateTime, Voltage, type = "l",
                     xlab = "datetime", ylab = "Voltage"))

with(hpc.trunc2, plot(DateTime, Sub_metering_1, col="black", type = "l", xlab= "", ylab = "Energy sub metering"))
with(hpc.trunc2,points(DateTime, Sub_metering_2, col="red", type="l"))
with(hpc.trunc2,points(DateTime, Sub_metering_3, col="blue", type="l"))

legend("topright", lwd=1, col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n",
       cex = 0.6)

with(hpc.trunc2, plot(DateTime, Global_reactive_power, type = "l",
                     xlab = "datetime", ylab = "Global_reactive_power"))


#create png file

dev.copy(png, 'plot4.png', width = 480, height = 480)
dev.off()
