data <- read.table("household_power_consumption.txt",header=TRUE,sep= ";",stringsAsFactors = FALSE)

FullTimeDate <- strptime(paste(data$Date, data$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
rawdata <- cbind(data,FullTimeDate)

rawdata$Date <- as.Date(rawdata$Date, format="%d/%m/%Y")
rawdata$Time <- format(rawdata$Time,format="%H:%M:%S")
rawdata$Global_active_power <- as.numeric(rawdata$Global_active_power)
rawdata$Global_reactive_power <- as.numeric(rawdata$Global_reactive_power)
rawdata$Voltage <- as.numeric(rawdata$Voltage)
rawdata$Global_intensity <- as.numeric(rawdata$Global_intensity)
rawdata$Sub_metering_1 <- as.numeric(rawdata$Sub_metering_1)
rawdata$Sub_metering_2 <- as.numeric(rawdata$Sub_metering_2)
rawdata$Sub_metering_3 <- as.numeric(rawdata$Sub_metering_3)

cleandata <- subset(rawdata,Date=="2007-02-01" | Date=="2007-02-02")

#plotting
png("plot4.png",width = 480,height = 480)

par(mfrow=c(2,2))
with(cleandata, plot(FullTimeDate, Global_active_power, type="l",xlab="", ylab="Global Active Power (kilowatts)"))
with(cleandata,plot(FullTimeDate,Voltage,type="l",xlab="datetime"))
with(cleandata,plot(FullTimeDate,Sub_metering_1,type="l",ylab="Energy sub metering",xlab=""))
lines(cleandata$FullTimeDate,cleandata$Sub_metering_2,type="l",col="red")
lines(cleandata$FullTimeDate,cleandata$Sub_metering_3,type="l",col="blue")
legend(c("topright"),c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=1,lwd=2)
with(cleandata,plot(FullTimeDate,Global_reactive_power,type="l",xlab="datetime"))

dev.off
