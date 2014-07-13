#initialize Packages
library(data.table)

#download and unzip data
zippedDataFileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zippedFileNameOnDisk <- "data.zip"
dataFileName <- "household_power_consumption.txt"
download.file(zippedDataFileUrl, destfile=zippedFileNameOnDisk)
unzip(zippedFileNameOnDisk)

#read data in correctly. Since there are ? that represennt NA values we need to
#read the data in as characters and then convert it to numeric
allData <- fread(dataFileName, na.strings=c("?"), colClasses=c(rep("character", 9)))

#Filter data
dataToProcess <- allData[allData$Date == "1/2/2007" | allData$Date == "2/2/2007",]

#Convert values to numeric so that they can be plotted 
dataToProcess$Global_active_power <- as.numeric(dataToProcess$Global_active_power)
dataToProcess$Global_reactive_power <- as.numeric(dataToProcess$Global_reactive_power)
dataToProcess$Voltage <- as.numeric(dataToProcess$Voltage)
dataToProcess$Global_intensity <- as.numeric(dataToProcess$Global_intensity)
dataToProcess$Sub_metering_1 <- as.numeric(dataToProcess$Sub_metering_1)
dataToProcess$Sub_metering_2 <- as.numeric(dataToProcess$Sub_metering_2)
dataToProcess$Sub_metering_3 <- as.numeric(dataToProcess$Sub_metering_3)

#setup plotting device
png(filename="plot1.png", width=480, height=480)

#plot 1
hist(dataToProcess$Global_active_power, main = paste("Global Active Power"), col = "red", xlab="Global Active Power (killowatts)")

#flush to disk
dev.off()