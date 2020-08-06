library(data.table)
# reading the the data 
# as na are marked as ? , mentioning it as na. 
global_power = data.table::fread(input = "household_power_consumption.txt"
                                 ,na.strings = "?")

# To prevent scientific Notations in Y axis 
global_power[, Global_active_power := lapply(.SD, as.numeric)
             ,.SDcols = c("Global_active_power")]

# Change Date Column to Date Type
global_power[, Date := lapply(.SD, as.Date, "%d/%m/%Y")
             , .SDcols = c("Date")]

# Filter Dates for 2007-02-01 and 2007-02-02

global_power<- global_power[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

png("plot1.png", width=480, height=480) # opening connection for png 

## Plot 1
hist(global_power[, Global_active_power], main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

dev.off() # close the connection
