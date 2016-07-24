# Load dplyr library for processing
library(dplyr)

# Set the working directory to local system folder
wd <- getwd()
setwd("C:/Soumya/R/ExData_Plotting1")

# Download file if it does not exist already
destination <- "household_power_consumption.zip"
if(!file.exists(destination)){
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destination)
  unzip(destination, overwrite=TRUE)
}

# Load and preprocess data
power_consumption_data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors=FALSE, dec=".")
power_consumption_data$Date <- as.Date(power_consumption_data$Date, format="%d/%m/%Y")

# Filter only the relevant data
startDate <- as.Date("2007-02-01")
endDate <- as.Date("2007-02-02")
power_consumption_data <- filter(power_consumption_data, Date >= startDate, Date <= endDate)

# Generate plotting variables
period <- strptime(paste(power_consumption_data$Date, power_consumption_data$Time, " "), "%Y-%m-%d %H:%M:%S", tz = "GMT")
sub_metering_1 <- as.numeric(power_consumption_data$Sub_metering_1)
sub_metering_2 <- as.numeric(power_consumption_data$Sub_metering_2)
sub_metering_3 <- as.numeric(power_consumption_data$Sub_metering_3)

# Generate the histogram and save in png files
png("plot3.png", width=480, height=480)
plot(period, sub_metering_1, type="l", xlab="", ylab="Energy Sub metering")
lines(period, sub_metering_2, type="l", col = "red")
lines(period, sub_metering_3, type="l", col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))
dev.off()

# Reset the working directory
setwd(wd)