
plot3 <- function(){
        data <- read.csv("household_power_consumption.txt")
        
        # this dataset only has one column, we shoud seperate it into multiple columns
        require(reshape2)
        newData <- colsplit(data$Date.Time.Global_active_power.Global_reactive_power.Voltage.Global_intensity.Sub_metering_1.Sub_metering_2.Sub_metering_3,
                            ";", c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"))
        
        # subsetting useful data frame, & change data type
        needData <- newData[(newData$Date=="1/2/2007" | newData$Date == "2/2/2007"), ]
        needData$Date <- strptime(needData$Date, "%d/%m/%Y")
        
        for(i in 3:9) {
                needData[,i] <- as.numeric(needData[,i])
        }
        
        # add a new column at end, and set the type with strptime(), so that the machine knows the time automatically
        needData$newTime <- with(needData, paste0(Date, Time))
        needData$newTime <- strptime(needData$newTime, "%Y-%m-%d%H:%M:%S")
        
        # draw the graph by setting the type to "l"
        library(datasets)
        with(needData, plot(needData$newTime, needData$Sub_metering_1, type = "l", xlab = "", ylab = "Energy Sub Metering"))
        with(needData, lines(needData$newTime, needData$Sub_metering_2, col = "red"))
        with(needData, lines(needData$newTime, needData$Sub_metering_3, col = "blue"))
        
        # the explain on the topright of the graph
        legend("topright", c("black line, red line, blue line"), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd=1, lty=1)
        
        # export image file
        dev.copy(png, file="plot3.png", width = 480, height = 480, units = "px")
        dev.off()
}

