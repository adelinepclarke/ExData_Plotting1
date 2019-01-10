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
#plot(powerdata$Sub_metering_1~powerdata$DateTime, type="l", ylab="Energy sub metering", xlab="")
#lines(powerdata$Sub_metering_2~powerdata$DateTime, col="red")
#lines(powerdata$Sub_metering_3~powerdata$DateTime, col="blue")
#legend(x="topright", col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1)

#make grid for plots (to fill by column)
par(mfcol=c(2,2))

#add topleft plot
plot(powerdata$Global_active_power~powerdata$DateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")

#add bottomleft plot
plot(powerdata$Sub_metering_1~powerdata$DateTime, type="l", ylab="Energy sub metering", xlab="")
lines(powerdata$Sub_metering_2~powerdata$DateTime, col="red")
lines(powerdata$Sub_metering_3~powerdata$DateTime, col="blue")
legend(x="topright", col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1)

#add topright plot
plot(powerdata$Voltage~powerdata$DateTime, type="l", ylab="Voltage", xlab="datetime")

#add bottomright plot
plot(powerdata$Global_reactive_power~powerdata$DateTime, type="l", ylab="Global_reactive_power", xlab="datetime")

#copy plot to png file
dev.copy(png, file="plot4.png", width=480, height=480)

dev.off()