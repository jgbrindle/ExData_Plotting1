## Jeff Brindle, 21 Feb 2018, Exploratory Data Analysis - Week 1
## plot4

dataFileName <- file.path("..","household_power_consumption.txt")
if (!file.exists(dataFileName)) {
  print ("You need to download the data file first.")
} else {
  
  ## datafile exists - read it in 
  print ("Reading in the dataset...")
  colTypes <- c("character","character", "numeric", "numeric","numeric","numeric","numeric","numeric","numeric")
  elecData <- read.table (dataFileName, header = TRUE, sep=";", colClasses = colTypes, na.strings = "?")
  ## only include complete cases
  elecData <- elecData[complete.cases(elecData),]
  
  ## subset to only data with dates 2007-02-01 or 2007-02-02
  print("filtering to rows in the correct date range")
  shortElecData <- subset(elecData, (Date == "1/2/2007" | Date == "2/2/2007"))
  
  ## convert date and times
  print ("Converting date and time values...")
  shortElecData$Time <- strptime(paste(shortElecData$Date, shortElecData$Time), format = '%d/%M/%Y %H:%M:%S')
  shortElecData$Date <- as.Date(shortElecData$Date, format = '%d/%M/%Y')
  shortElecData <- shortElecData[order(shortElecData$Time),]
  
   
  ## draw the charts to the png file
  print ("creating the chart")
  png(filename ="plot4.png")
  par(mfrow=c(2,2))
  
  ## chart topleft
  plot(shortElecData$Time,shortElecData$Global_active_power, type = "n", main = "", xlab = "", ylab = "Global Active Power")
  lines(shortElecData$Time,shortElecData$Global_active_power, type ="l")
  
  ## chart topright
  plot(shortElecData$Time,shortElecData$Voltage, type = "n", main = "", xlab = "datetime", ylab = "Voltage")
  lines(shortElecData$Time,shortElecData$Voltage, type ="l")
  
  ## chart bottomleft
  plot(shortElecData$Time,shortElecData$Sub_metering_1, type = "n", main = "", xlab = "", ylab = "Energy sub metering")  
  lines(shortElecData$Time,shortElecData$Sub_metering_1, type ="l")
  lines(shortElecData$Time,shortElecData$Sub_metering_2, type ="l", col = "red")
  lines(shortElecData$Time,shortElecData$Sub_metering_3, type ="l", col = "blue")
  legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("black","red","blue"), lty=1, box.lty=0)
  
  ## chart bottomright
  plot(shortElecData$Time,shortElecData$Global_reactive_power, type = "n", main = "", xlab = "datetime", ylab = "Global_reactive_power")
  lines(shortElecData$Time,shortElecData$Global_reactive_power, type ="l")
  
  dev.off()
  }