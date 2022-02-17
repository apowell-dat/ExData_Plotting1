library(data.table)
setwd("C:/Users/Andy/OneDrive/Desktop/R online class files/exploratory_proj1/data")

# Read in data
powerDT <- fread(input = "household_power_consumption.txt"
                 , na.strings = "?")

# Prevent plot from using scientific notation for Global_active_power
powerDT[, Global_active_power := lapply(.SD, as.numeric)
        , .SDcols = c("Global_active_power")]

# Change dates to date class
powerDT[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

# Subset for only dates between 02/01/07 and 02/02/07
powerDT <- powerDT[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

# Launch graphics device
png("plot1.png", width = 480, height = 480)

# Create plot 1
hist(powerDT[, Global_active_power], main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)", ylab = "Frequency",
     ylim = c(0, 1200), col = "Red")

dev.off()