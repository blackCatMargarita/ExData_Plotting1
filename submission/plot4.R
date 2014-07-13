# read in data from text file (assume in same working directory)
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

# convert date string to date class format
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

# subset data to only include days of interest
data <-data[(data$Date == "2007-02-01" | data$Date == "2007-02-02"),]

# Create a time series variable as POSIXlt, combining day and time
data$datetime <- strptime(paste(data$Date, data$Time), format = "%Y-%m-%d %H:%M:%S")

# convert numeric formats from factors
data$Global_active_power <- as.numeric(as.character(data$Global_active_power))
data$Sub_metering_1 <- as.numeric(as.character(data$Sub_metering_1))
data$Sub_metering_2 <- as.numeric(as.character(data$Sub_metering_2))
data$Voltage <- as.numeric(as.character(data$Voltage))
data$Global_reactive_power <- as.numeric(as.character(data$Global_reactive_power))

# Create four plots as one png file
png(filename = "plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))

# Plot 1
with(data, plot(datetime,Global_active_power, typ = 'l', ann=F))
title(ylab = "Global Active Power")

# Plot 2
with(data, plot(datetime,Voltage, typ = 'l'))

# Plot 3
with(data, plot(datetime,Sub_metering_1, typ = 'l', ann=F, col = "black"))
lines(data$datetime,data$Sub_metering_2, typ = 'l', ann=F, col = "red")
lines(data$datetime,data$Sub_metering_3, typ = 'l', ann=F, col = "blue")
legend("topright", col = c("black","red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = c(1,1,1), bty = "n")
title(ylab = "Energy sub metering")

# Plot 4
with(data, plot(datetime,Global_reactive_power, typ = 'l'))

# Close out the png file
dev.off()
