# read in data from text file (assume in same working directory)
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

# subset data to only include days of interest
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data <-data[(data$Date == "2007-02-01" | data$Date == "2007-02-02"),]

# Convert character factor data to numeric data
data$Global_active_power <- as.numeric(as.character(data$Global_active_power))

# Create a time series variable, combining day and time
data$DateTime <- strptime(paste(data$Date, data$Time), format = "%Y-%m-%d %H:%M:%S")

# Plot the data to a png file
png(filename = "plot2.png", width = 480, height = 480)
with(data, plot(DateTime,Global_active_power, typ = 'l', ann=F))
title(ylab = "Global Active Power (kilowatts)")
dev.off()
