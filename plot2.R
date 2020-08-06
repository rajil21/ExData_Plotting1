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

png("plot2.png", width=480, height=480) # opening png connection

## Plot 2
plot(x = power_consumption[, dateTime]
     , y = power_consumption[, Global_active_power]
     , type="l", xlab="", ylab="Global Active Power (kilowatts)")

dev.off() #closing the connection