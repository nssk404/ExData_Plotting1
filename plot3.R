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

# Extra column that will help with plotting the data
dataToProcess[,fullDateTime:=paste(dataToProcess$Date, dataToProcess$Time)]

#set up plotting device
png(filename="plot3.png", width=480, height=480)

#plot graph
convertedDate <- strptime(dataToProcess$fullDateTime, format="%d/%m/%Y %H:%M:%S")
plot(convertedDate, dataToProcess$Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")
points(convertedDate, dataToProcess$Sub_metering_1, type="l")
points(convertedDate, dataToProcess$Sub_metering_2, type="l", col="red")
points(convertedDate, dataToProcess$Sub_metering_3, type="l", col="blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black","red","blue"), lty=c(1,1,1))

#flush to disk
dev.off()