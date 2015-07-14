
plot1 <- function(){
        data <- read.csv("household_power_consumption.txt")
        
        # this dataset only has one column, we shoud seperate it into multiple columns
        require(reshape2)
        newData <- colsplit(data$Date.Time.Global_active_power.Global_reactive_power.Voltage.Global_intensity.Sub_metering_1.Sub_metering_2.Sub_metering_3,
                            ";", c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"))
        
        # subsetting useful data frame, & change data type
        needData <- newData[(newData$Date=="1/2/2007" | newData$Date == "2/2/2007"), ]
        needData$Date <- strptime(needData$Date, "%d/%m/%Y")
        needData$Global_active_power <- as.numeric(needData$Global_active_power)
        
        library(datasets)
        hist(needData$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (killowatts)")
        
        dev.copy(png, file="plot1.png", width = 480, height = 480, units = "px")
        dev.off()
}