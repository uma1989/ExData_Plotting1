## Read dataset stored in working directory
fulldata <- read.csv("household_power_consumption.txt", header=TRUE, sep=";", na.strings="?", stringsAsFactors=FALSE)

## Convert 'Date' column into date format
fulldata$Date <- as.Date(fulldata$Date, format="%d/%m/%Y")

## Subset the required data as per given date range
plotdata <- subset(fulldata, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

## Add new column 'DateTime' to plotdata
library(dplyr)
plotdata <- mutate(plotdata, DateTime = as.POSIXct(paste(as.Date(plotdata$Date), plotdata$Time)))


## Plot 4
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
plot(plotdata$Global_active_power ~ plotdata$DateTime, type="l", ylab="Global Active Power", xlab="")
plot(plotdata$Voltage ~ plotdata$DateTime, type="l", ylab="Voltage", xlab="datetime")
plot(plotdata$Sub_metering_1 ~ plotdata$DateTime, type="l", ylab="Energy sub metering", xlab="")
lines(plotdata$Sub_metering_2 ~ plotdata$DateTime,col="red")
lines(plotdata$Sub_metering_3 ~ plotdata$DateTime,col="blue")
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=1, bty="n", cex=0.5, legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
plot(plotdata$Global_reactive_power ~ plotdata$DateTime, type="l", ylab="Global_reactive_power", xlab="datetime")

## Copy into png file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
