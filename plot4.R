
plot4 <- function(){
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
        par(mfcol = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
        
        # top left
        with(needData, plot(needData$newTime, needData$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power"))
        
        
        # bottom left
        with(needData, plot(needData$newTime, needData$Sub_metering_1, type = "l", xlab = "", ylab = "Energy Sub Metering"))
        with(needData, lines(needData$newTime, needData$Sub_metering_2, col = "red"))
        with(needData, lines(needData$newTime, needData$Sub_metering_3, col = "blue"))
        
        legend("topright", c("black line, red line, blue line"), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd=1, lty=1, cex = 0.5)
        
        
        # top right
        with(needData, plot(needData$newTime, needData$Voltage, type = "l", xlab = "datetime", ylab = "Voltage"))
        
        
        # bottom right
        with(needData, plot(needData$newTime, needData$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power"))
        
        # export image file
        dev.copy(png, file="plot4.png", width = 480, height = 480, units = "px")
        dev.off()
}

