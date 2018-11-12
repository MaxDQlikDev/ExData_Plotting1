# Plot 3
# loading and unzipping data
pathTozipFile <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
pathTotxtFile <- file.path(getwd(),'Temp')
download.file(pathTozipFile, pathTotxtFile, mode="wb")
unzip(pathTotxtFile, "household_power_consumption.txt")

dfThirdPlot <- read.csv("household_power_consumption.txt", sep = ";", stringsAsFactors = FALSE)

## creating DateTime var
dfThirdPlot$DateTime <- with(dfThirdPlot, paste(Date, Time))

# converting Date var
dfThirdPlot$Date <- as.Date(dfThirdPlot$Date, format = "%d/%m/%Y")

# filtering only for 1-st and 2-nd february
dfThirdPlotFiltered <- subset(dfThirdPlot, Date == "2007-02-01" |
                                 Date == "2007-02-02")

# converting y vars into numeric
dfThirdPlotFiltered$Sub_metering_1 <- as.numeric(dfThirdPlotFiltered$Sub_metering_1)
dfThirdPlotFiltered$Sub_metering_2 <- as.numeric(dfThirdPlotFiltered$Sub_metering_2)
dfThirdPlotFiltered$Sub_metering_3 <- as.numeric(dfThirdPlotFiltered$Sub_metering_3)

# converting DateTime
dfThirdPlotFiltered$DateTime <- strptime(dfThirdPlotFiltered$DateTime, format = "%d/%m/%Y %H:%M:%S")

# creating file to write plot in
png("plot3.png", width = 480, height = 480)

with(dfThirdPlotFiltered, plot(DateTime, Sub_metering_1, 
                                type = "l", ylab = "Energy sub metering", xlab = " "))

with(dfThirdPlotFiltered, lines(DateTime, Sub_metering_2, 
                                type = "l", col = "red"))

with(dfThirdPlotFiltered, lines(DateTime, Sub_metering_3, 
                                type = "l", col = "blue"))
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
                            col = c("black", "red", "blue"),
                            lty = 1)
dev.off()
