#Read the file giving full details
pwr <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?", colClasses = c(rep("character",2),rep("numeric",7)))

#Convert Date col into 'Date' format
pwr$Date <- strptime(pwr$Date, format = "%d/%m/%Y")

#Subset for only 2 days of February
pwr_dates <- subset(pwr, pwr$Date %in% c("2007-02-01","2007-02-02"))

#Plot graph on screen
with(pwr_dates, hist(Global_active_power, xlab = "Global Active Power (kilowatts)", main = "Global Active Power", col = "red"))

#Copy plot to png file
dev.copy(png,"plot1.png")
dev.off()