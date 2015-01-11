### project1 - Part of Exploratory data analysis

plot4 <- function(){
        
        
        library(data.table)
        
        
        datafile <- "household_power_consumption.txt" 
        
        
        
        ## finally chose the skip+nrows for its inventiveness. 
        
        
        
        ## The observations are one per minute. Count the number of minutes
        ## on the dates 1/2 and 2/2
        
        timedifference <- difftime(as.POSIXct("2007-02-03"), 
                                   as.POSIXct("2007-02-01"),
                                   units="mins")
        
        minutescount <- as.numeric(timedifference)
        
        ## skip to read the first row in raw data starting with 1/2/2007
        ## Read till the nrows = minutescount
        ## na.strings "" for safety
        
        DT <- fread(datafile, 
                    skip="1/2/2007", 
                    nrows = minutescount, 
                    na.strings = c("?", "") )
        
        ## header is lost.  So set them
        ## nrows = 0 gets the headers
        
        setnames(DT, colnames(fread(datafile, nrows=0)))
        

        png(filename = "plot4.png")
        
        par(mfrow = c(2,2), mar = c(4,5,3,2) )
        
        ## plot 1
        
        plot(strptime(paste(DT$Date, DT$Time), format = "%d/%m/%Y %H:%M:%S"), 
             DT$Global_active_power,
             xlab = "",
             ylab = "Global Active Power",
             type="l")
        
             
        
        ## plot 2
        
        
        plot(strptime(paste(DT$Date, DT$Time), format = "%d/%m/%Y %H:%M:%S"), 
             DT$Voltage,
             xlab = "datetime",
             ylab = "Voltage",
             type="l")
        
        
        ## plot 3
        
        
        plot(strptime(paste(DT$Date, DT$Time), format = "%d/%m/%Y %H:%M:%S"), 
             DT$Sub_metering_1,
             xlab = "",
             ylab = "Energy sub metering",
             type="n")
        
        legend(x = "topright",
                bty = "n",
                lty = 1,
               col = c("black", "red", "blue"),
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        
        ## x.intersp = 0.05,
        
        lines( strptime(paste(DT$Date, DT$Time), format = "%d/%m/%Y %H:%M:%S"),
               DT$Sub_metering_1)
        
        
        lines( strptime(paste(DT$Date, DT$Time), format = "%d/%m/%Y %H:%M:%S"),
               DT$Sub_metering_2, 
               col= "red")
        
        lines( strptime(paste(DT$Date, DT$Time), format = "%d/%m/%Y %H:%M:%S"),
               DT$Sub_metering_3,
               col = "blue")
        
        
        ## plot 4
        
        plot(strptime(paste(DT$Date, DT$Time), format = "%d/%m/%Y %H:%M:%S"), 
             DT$Global_reactive_power,
             xlab = "datetime",
             ylab = "Global_reactive_power",
             type = "l")
     
        dev.off()

}