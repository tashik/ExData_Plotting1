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

# Let's plot to PNG directly
png('plot1.png')

# Create required plot
hist(dset$Global_active_power, 
     col="red", 
     xlab="Global Active Power (kilowatts)",
     ylab="Frequency",
     main="Global Active Power")

dev.off()