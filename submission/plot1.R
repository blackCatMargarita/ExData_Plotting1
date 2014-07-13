# read in data from text file (assume in same working directory)
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

# subset data to only include days of interest
# Note: to be more robust, first transform data text string to 
#   numerical value so no data is accidentally skipped with variations 
#   on date format (inclusion of zeros)
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data <-data[(data$Date == "2007-02-01" | data$Date == "2007-02-02"),]

# Convert character factor data to numeric data
data$Global_active_power <- as.numeric(as.character(data$Global_active_power))

# Plot the data to a png file
png(filename = "plot1.png", width = 480, height = 480)
hist(data$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()

