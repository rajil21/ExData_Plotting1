library("data.table")

#Reads the data 
power_consumption <- data.table::fread(input = "household_power_consumption.txt"
                                       , na.strings="?"
)

# Prevents Scientific Notation in Y axis 
power_consumption[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# converting string into datetime format
power_consumption[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Filter Dates for 2007-02-01 and 2007-02-02
power_consumption <- power_consumption[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("plot4.png", width=480, height=480) # opening png connection

par(mfrow=c(2,2)) # creating space of 2*2 matrix for storing subplots

# sub plot 1
plot(power_consumption[, dateTime], power_consumption[, Global_active_power], type="l", xlab="", ylab="Global Active Power")
# sub Plot 2
plot(power_consumption[, dateTime],power_consumption[, Voltage], type="l", xlab="datetime", ylab="Voltage")

# sub Plot 3
plot(power_consumption[, dateTime], power_consumption[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(power_consumption[, dateTime], power_consumption[, Sub_metering_2], col="red")
lines(power_consumption[, dateTime], power_consumption[, Sub_metering_3],col="blue")
legend("topright", col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       , lty=c(1,1)
       , bty="n"
       , cex=.9) 

# sub plot 4
plot(power_consumption[, dateTime], power_consumption[,Global_reactive_power], type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off() # closing off the connection