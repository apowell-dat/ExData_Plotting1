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
png("plot2.png", width = 480, height = 480)

# Create plot 2
plot(x = powerDT[, dateTime], y = powerDT[, Global_active_power],
     type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

dev.off()