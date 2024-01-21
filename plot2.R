# Plot 2 for Assignment 1 week 1

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

png(file = "plot2.png")

plot(df$Global_active_power,
        type = "l",
        axes = FALSE,
        xlab = "",
        ylab = "Global active power (kilowatts)"
)
my.at <- c(0, 1440, 2880)
my.lab <- c("Thu", "Fri", "Sat")
axis(1, at = my.at, labels = my.lab)
axis(2)
box()
dev.off()