##Laro Navamuel 2018

##This scripts follows step to step fo make an exploratory analisis with plots
##This assignment uses data from the UC Irvine Machine Learning Repository, 
##a popular repository for machine learning datasets. In particular, 
##we will be using the "Individual household electric power consumption Data Set" which I have made available on the course 
##web site: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip

##Fist we load required libraries

library(data.table)
library(dplyr)
library(lubridate)

#Check if exists datafile or not to skip download every time.
#Set data directory as extraction folder.

destinationFile ="/exdata_data_household_power_consumption.zip"
extractDir ="./data"

if (!file.exists(destinationFile)) 
{
        fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileUrl,destfile=destinationFile,method = "auto")
        unzip(destinationFile,exdir = extractDir)
} else {
        unzip(destinationFile,exdir = extractDir)
}


##Load data from file - CAUTION with memory.
energy.dataset <- read.table("./data/household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE,
                             na = "?", colClasses = c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))

# Changing date and time 

energy.dataset$dateTime <- as.POSIXct(strptime(paste(energy.dataset$Date, energy.dataset$Time), "%d/%m/%Y %H:%M:%S"))
energy.dataset$Date <- as.Date(energy.dataset$Date, "%d/%m/%Y")

# Filtering data

energy.filtered.dataset <- energy.dataset %>%
        select(Date,dateTime,Time,Global_active_power,Global_reactive_power,Voltage,Global_intensity,Sub_metering_1,Sub_metering_2,Sub_metering_3) %>%
        filter(Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))


png(file = "plot3.png", width = 480, height = 480, units = "px")
with(energy.filtered.dataset, {
        plot(dateTime, Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "", col = "black")
        lines(dateTime, Sub_metering_2, col = "red")
        lines(dateTime, Sub_metering_3, col = "blue")
        legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1)
})

dev.off()

