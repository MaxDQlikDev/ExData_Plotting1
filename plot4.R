# Plot 4
# loading and unzipping data
pathTozipFile <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
pathTotxtFile <- file.path(getwd(),'Temp')
download.file(pathTozipFile, pathTotxtFile, mode="wb")
unzip(pathTotxtFile, "household_power_consumption.txt")

dfFourthPlot <- read.csv("household_power_consumption.txt", sep = ";", stringsAsFactors = FALSE)

## creating DateTime var
dfFourthPlot$DateTime <- with(dfFourthPlot, paste(Date, Time))

# converting Date var
dfFourthPlot$Date <- as.Date(dfFourthPlot$Date, format = "%d/%m/%Y")

# filtering only for 1-st and 2-nd february
dfFourthPlotFiltered <- subset(dfFourthPlot, Date == "2007-02-01" |
                                 Date == "2007-02-02")

# converting y vars into numeric
dfFourthPlotFiltered$Global_active_power<- as.numeric(dfFourthPlotFiltered$Global_active_power)
dfFourthPlotFiltered$Voltage<- as.numeric(dfFourthPlotFiltered$Voltage)
dfFourthPlotFiltered$Sub_metering_1 <- as.numeric(dfFourthPlotFiltered$Sub_metering_1)
dfFourthPlotFiltered$Sub_metering_2 <- as.numeric(dfFourthPlotFiltered$Sub_metering_2)
dfFourthPlotFiltered$Sub_metering_3 <- as.numeric(dfFourthPlotFiltered$Sub_metering_3)
dfFourthPlotFiltered$Global_reactive_power<- as.numeric(dfFourthPlotFiltered$Global_reactive_power)

# converting DateTime
dfFourthPlotFiltered$DateTime <- strptime(dfFourthPlotFiltered$DateTime, format = "%d/%m/%Y %H:%M:%S")

# creating file to write plot in
png("plot4.png", width = 480, height = 480)

par(mfrow=c(2,2), mar=c(4,4,2,1))

with(dfFourthPlotFiltered, plot(DateTime, Global_active_power, 
                                type = "l", ylab = "Global Active Power (kilowatts)", xlab = " "))

with(dfFourthPlotFiltered, plot(DateTime, Voltage, 
                                type = "l", ylab = "Voltage", xlab = "datetime"))

with(dfFourthPlotFiltered, plot(DateTime, Sub_metering_1, 
                                type = "l", ylab = "Energy sub metering", xlab = " "))

with(dfFourthPlotFiltered, lines(DateTime, Sub_metering_2, 
                                type = "l", col = "red"))

with(dfFourthPlotFiltered, lines(DateTime, Sub_metering_3, 
                                type = "l", col = "blue"))
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
                            col = c("black", "red", "blue"), lty = 1)

with(dfFourthPlotFiltered, plot(DateTime, Global_reactive_power, 
                                type = "l", ylab = "Global_reactive_power", xlab = "datetime"))
dev.off()
