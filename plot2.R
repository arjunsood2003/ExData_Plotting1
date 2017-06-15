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
plot(powers$DateTime, powers$Global_active_power, xlab = "", ylab = "Global Active Power (kilowatts)", type = "n")

#Make line graph
with(powers, lines(DateTime, Global_active_power))

#Copy plot to png file
dev.copy(png,"plot2.png")
dev.off()