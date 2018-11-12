# Plot 2
# loading and unzipping data
pathTozipFile <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
pathTotxtFile <- file.path(getwd(),'Temp')
download.file(pathTozipFile, pathTotxtFile, mode="wb")
unzip(pathTotxtFile, "household_power_consumption.txt")

dfSecondPlot <- read.csv("household_power_consumption.txt", sep = ";", stringsAsFactors = FALSE)

## creating DateTime var
dfSecondPlot$DateTime <- with(dfSecondPlot, paste(Date, Time))

# converting Date var
dfSecondPlot$Date <- as.Date(dfSecondPlot$Date, format = "%d/%m/%Y")

# filtering only for 1-st and 2-nd february
dfSecondPlotFiltered <- subset(dfSecondPlot, Date == "2007-02-01" |
                                 Date == "2007-02-02")

# converting y var into numeric
dfSecondPlotFiltered$Global_active_power <- as.numeric(dfSecondPlotFiltered$Global_active_power)

# converting DateTime
dfSecondPlotFiltered$DateTime <- strptime(dfSecondPlotFiltered$DateTime, format = "%d/%m/%Y %H:%M:%S")

# creating file to write plot in
png("plot2.png", width = 480, height = 480)

with(dfSecondPlotFiltered, plot(DateTime, Global_active_power, 
                                type = "l", ylab = "Global Active Power (kilowatts)", xlab = " "))

dev.off()
