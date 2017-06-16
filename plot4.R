#Read the file giving full details
pwr <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?", colClasses = c(rep("character",2),rep("numeric",7)))

#Convert Date col into 'Date' format
pwr$Date <- strptime(pwr$Date, format = "%d/%m/%Y")

#Subset for only 2 days of February
pwr_dates <- subset(pwr, pwr$Date %in% c("2007-02-01","2007-02-02"))

#Create a 'DateTime' column combining 'Date' and 'Time' columns
powers <- cbind(pwr_dates,as.POSIXct(paste(pwr_dates$Date, pwr_dates$Time), format="%Y-%m-%d %H:%M:%S"))
colnames(powers)[10] <- "DateTime"

#Setting a 2x2 grid for four graphs, with smaller font size
par(mfcol = c(2,2), cex = 0.7)

#Plot1 (1,2)
plot(powers$DateTime, powers$Global_active_power, xlab = "", ylab = "Global Active Power", type = "n")
with(powers, lines(DateTime, Global_active_power))

#Plot2 (1,1)
plot(powers$DateTime, powers$Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "n")
with(powers, lines(DateTime, Sub_metering_1, col = "black"))
with(powers, lines(DateTime, Sub_metering_2, col = "red"))
with(powers, lines(DateTime, Sub_metering_3, col = "blue"))
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("black","red","blue"), lty = c(1,1), bty = "n", cex = 0.8)

#Plot3 (2,2)
plot(powers$DateTime, powers$Voltage, xlab = "datetime", ylab = "Voltage", type = "n")
with(powers, lines(DateTime, Voltage))

#Plot4 (2,1)
plot(powers$DateTime, powers$Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power", type = "n")
with(powers, lines(DateTime, Global_reactive_power))

#Copy complete plot to png file
dev.copy(png,"plot4.png")
dev.off()