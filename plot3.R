# data is downloaded, upzipped, and the .txt file is in the working directory

power <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings="?")

# extract specific dates as required, then bind these
power1 <- subset(power, Date=="1/2/2007")
power2 <- subset(power, Date=="2/2/2007")
powerdata <- rbind(power1,power2)

#change date format
powerdata$Date <- as.Date(powerdata$Date, format="%d/%m/%Y")

#cbind DateTime
powerdata <- cbind(powerdata, "DateTime"=as.POSIXct(paste(powerdata$Date, powerdata$Time)))                                                

#build plot
plot(powerdata$Sub_metering_1~powerdata$DateTime, type="l", ylab="Energy sub metering", xlab="")
lines(powerdata$Sub_metering_2~powerdata$DateTime, col="red")
lines(powerdata$Sub_metering_3~powerdata$DateTime, col="blue")
legend(x="topright", col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1)


#copy plot to png file
dev.copy(png, file="plot3.png", width=480, height=480)

dev.off()