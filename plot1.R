## Jeff Brindle, 20 Feb 2018, Exploratory Data Analysis - Week 1
## plot1

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
  
  ## draw the chart
  print ("creating the chart")
  png(filename ="plot1.png")
  hist(shortElecData$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)") 
  dev.off()
  }