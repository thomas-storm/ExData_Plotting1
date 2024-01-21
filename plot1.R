# Plot 1 for Assignment 1 week 1

library(dplyr)
library(lubridate)
library(data.table)

# set main directory and "data" sub directory
# requires working directory is set correctly
main_dir <- getwd()

# check if "data" sub-directory exists, if not download and unzip file
if (!file.exists("household_power_consumption.txt")){
        url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        temp <- tempfile()
        download.file(url, temp)
        unzip(zipfile = temp, exdir = file.path(main_dir))
        unlink(c(temp))
        rm(temp)
} else {print("data file available")}

df <- fread("household_power_consumption.txt")
df <- df %>% mutate(date.time = dmy(Date))
df <- filter(df, df$date.time %within% interval(ymd("2007-02-01"), ymd("2007-02-02")))

#as.POSIXct(paste(x$date, x$time), format="%Y-%m-%d %H:%M:%S")

png(file = "plot1.png")

hist(as.numeric(df$Global_active_power), 
                xlab = "Global Active Power (kilowatts)", 
                ylab = "Frequency",
                main = "GLobal Active Power",
                col = "red"
                )
dev.off()