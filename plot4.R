library(data.table)
setwd("C:/Users/Andy/OneDrive/Desktop/R online class files/exploratory_proj1/data")

# Read in data
powerDT <- fread(input = "household_power_consumption.txt"
                 , na.strings = "?")

# Prevent plot from using scientific notation for Global_active_power
powerDT[, Global_active_power := lapply(.SD, as.numeric)
        , .SDcols = c("Global_active_power")]

# Change dates to POSIXct for filtering/plotting by time of day
powerDT[, dateTime := as.POSIXct(paste(Date, Time)
                                 , format = "%d/%m/%Y %H:%M:%S")]

# Subset for only dates between 02/01/07 and 02/02/07
powerDT <- powerDT[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

# Launch graphics device
png("plot4.png", width = 480, height = 480)

# Fill plots in 2x2 (rows first)
par(mfrow = c(2,2))

# First plot
plot(x = powerDT[, dateTime], y = powerDT[, Global_active_power],
     type = "l", xlab = "", ylab = "Global Active Power")

# Second plot
plot(x = powerDT[, dateTime], y = powerDT[, Voltage],
     type = "l", xlab = "datetime", ylab = "Voltage")

# Third plot
plot(powerDT[, dateTime], powerDT[, Sub_metering_1], type = "l",
     xlab = "", ylab = "Energy sub metering")

lines(powerDT[, dateTime], powerDT[, Sub_metering_2], col = "red")
lines(powerDT[, dateTime], powerDT[, Sub_metering_3], col = "blue")
legend("topright", col = c("black", "red", "blue"),
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = c(1,1), lwd = c(1,1), bty = "n", cex = 0.8)

# Fourth plot
plot(x = powerDT[, dateTime], y = powerDT[, Global_reactive_power], type= "l",
     xlab = "datetime", ylab = "Global_reactive_power")

dev.off()