## Read dataset stored in working directory
fulldata <- read.csv("household_power_consumption.txt", header=TRUE, sep=";", na.strings="?", stringsAsFactors=FALSE)

## Convert 'Date' column into date format
fulldata$Date <- as.Date(fulldata$Date, format="%d/%m/%Y")

## Subset the required data as per given date range
plotdata <- subset(fulldata, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

## Add new column 'DateTime' to plotdata
library(dplyr)
plotdata <- mutate(plotdata, DateTime = as.POSIXct(paste(as.Date(plotdata$Date), plotdata$Time)))


## Plot 3

plot(plotdata$Sub_metering_1 ~ plotdata$DateTime, type="l", ylab="Energy sub metering", xlab="", col="black")
lines(plotdata$Sub_metering_2 ~ plotdata$DateTime, col="red")
lines(plotdata$Sub_metering_3 ~ plotdata$DateTime, col="blue")
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Copy into png file
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()
