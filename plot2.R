# Install packages, which are used to get a filtered dataset
install.packages('sqldf')
library(sqldf)

# Read data from given url
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "dt.zip", method="curl")

# Unzip
unzip("dt.zip", files=c("household_power_consumption.txt"))

# Get the dataset only for required dates
dset<-read.csv.sql("household_power_consumption.txt", "select * from file where Date='1/2/2007' or Date='2/2/2007'", sep=";")


# Remove temporary files
unlink("dt.zip")
unlink("household_power_consumption.txt")

# Create a list of OSIXlt date objects
weekDaysOSIX<-strptime(
  paste(dset$Date, dset$Time, sep=" "), 
  format='%d/%m/%Y %H:%M:%S'
)

# To get English weekday names we have to reset system locale to C
Sys.setlocale(locale = "C")

# Create required plot
# NB! There is some magic within plot function when working with labeling axis:
# it gives names of week days as labels itself!
plot(weekDaysOSIX, 
     dset$Global_active_power, 
     type="l", 
     xlab="", 
     ylab="Global Active Power (kilowatts)")


#Copy the plot from screen graphic device to PNG
dev.copy(png, 'plot2.png')