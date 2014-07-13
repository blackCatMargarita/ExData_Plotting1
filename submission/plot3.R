# read in data from text file (assume in same working directory)
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

# convert date string to date class format
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

# subset data to only include days of interest
data <-data[(data$Date == "2007-02-01" | data$Date == "2007-02-02"),]

# Create a time series variable as POSIXlt, combining day and time
data$DateTime <- strptime(paste(data$Date, data$Time), format = "%Y-%m-%d %H:%M:%S")

# convert sub_metering 1 & 2 to numeric formats from factors
data$Sub_metering_1 <- as.numeric(as.character(data$Sub_metering_1))
data$Sub_metering_2 <- as.numeric(as.character(data$Sub_metering_2))

# Plot the data to a png file
png(filename = "plot3.png", width = 480, height = 480)
with(data, plot(DateTime,Sub_metering_1, typ = 'l', ann=F, col = "black"))
    lines(data$DateTime,data$Sub_metering_2, typ = 'l', ann=F, col = "red")
    lines(data$DateTime,data$Sub_metering_3, typ = 'l', ann=F, col = "blue")
legend("topright", col = c("black","red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = c(1,1,1))
title(ylab = "Energy sub metering")
dev.off()
