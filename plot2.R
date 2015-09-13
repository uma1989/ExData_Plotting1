## Read dataset stored in working directory
fulldata <- read.csv("household_power_consumption.txt", header=TRUE, sep=";", na.strings="?", stringsAsFactors=FALSE)

## Convert 'Date' column into date format
fulldata$Date <- as.Date(fulldata$Date, format="%d/%m/%Y")

## Subset the required data as per given date range
plotdata <- subset(fulldata, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

## Add new column 'DateTime' to plotdata
library(dplyr)
plotdata <- mutate(plotdata, DateTime = as.POSIXct(paste(as.Date(plotdata$Date), plotdata$Time)))

## Plot 2
plot(plotdata$Global_active_power ~ plotdata$DateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="", col="black")

## Copy into png file
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()
