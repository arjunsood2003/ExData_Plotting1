#Read the file giving full details
pwr <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?", colClasses = c(rep("character",2),rep("numeric",7)))

#Convert Date col into 'Date' format
pwr$Date <- strptime(pwr$Date, format = "%d/%m/%Y")

#Subset for only 2 days of February
pwr_dates <- subset(pwr, pwr$Date %in% c("2007-02-01","2007-02-02"))

#Attach combined 'DateTime' column
powers <- cbind(pwr_dates,as.POSIXct(paste(pwr_dates$Date, pwr_dates$Time), format="%Y-%m-%d %H:%M:%S"))
colnames(powers)[10] <- "DateTime"

#Get blank plot on screen
plot(powers$DateTime, powers$Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "n")

#Make lines on graph
with(powers, lines(DateTime, Sub_metering_1, col = "black"))
with(powers, lines(DateTime, Sub_metering_2, col = "red"))
with(powers, lines(DateTime, Sub_metering_3, col = "blue"))

#Add legend
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("black","red","blue"), lty = c(1,1))

#Copy plot to png file
dev.copy(png,"plot3.png")
dev.off()