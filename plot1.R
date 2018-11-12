# Plot 1
library("data.table")

# loading and unzipping data
pathTozipFile <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
pathTotxtFile <- file.path(getwd(),'Temp')
download.file(pathTozipFile, pathTotxtFile, mode="wb")
unzip(pathTotxtFile, "household_power_consumption.txt")

# load data only needed for plot1
dfFirstPlot <- fread("household_power_consumption.txt", select = c(1, 3))

# setting correct classes of vars and filtering by data
dfFirstPlot$Date <- as.Date(strptime(dfFirstPlot$Date, format = "%d/%m/%Y"))
dfFirstPlotFiltered <- subset(dfFirstPlot, Date == "2007-02-01" |
                             Date == "2007-02-02")
dfFirstPlotFiltered$Global_active_power <- as.numeric(dfFirstPlotFiltered$Global_active_power)

# creating file to write plot in
png("plot1.png", width = 480, height = 480)

hist(dfFirstPlotFiltered$Global_active_power, col = "red", breaks = 15,
     main = "Global Active Power", xlab = "Global Active Power (kilowwatts)")

dev.off()
