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

# Generate the histogram and save in png files
png("plot1.png", width=480, height=480)
global_active_power <- as.numeric(power_consumption_data$Global_active_power)
hist(global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")
dev.off()

# Reset the working directory
setwd(wd)