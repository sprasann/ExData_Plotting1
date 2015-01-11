### project1 - Part of Exploratory data analysis

plot1 <- function(){
        
        
        library(data.table)
        
        
        datafile <- "household_power_consumption.txt" 
        
        
        ## fread is faster and more convenient than data.table
        ## Just a note that fread is still under development in R 
        ## and may change in a non-backward compatible way later!
        
        ## Read only the rows with dates 2007-02-01 and 2007-02-02
        
        ## There are at least 4 ways (so far!) to read as subset of the file
        ## First is to use grep or sed to filter the file before reading
        ## disadvanatage is that this needs grep or sed to be installed first
        ## especially in windows.  So not portable
        ## Second is to read.csv.sql.  It is  better than read.csv, but seems a 
        ## overkill for this task and is slower than other methods.  
        ## Still seems the safest option now. 
        ## Third is to use skip + nrows (based on time between two days). However
        ## it implicity assumes that raw data is ordered, 
        ## the time interval is correct etc.  So not the safest.
        ## Fourth option is to use filter() from dplyr package.  Probably easiest
        ## but since it is not covered in the course yet, skipping this. 
        
        ## finally chose the skip+nrows for its inventiveness. 
        
        
        ## df <- read.csv.sql(datafile,
        ##             "select * from file where Date in ('1/2/2007','2/2/2007')",
        ##             sep = ';', 
        ##             header = T)
        
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
        
        png(filename = "plot1.png")
        
        hist(DT$Global_active_power, 
             main = "Global Active Power",  
             xlab = "Global Active Power (kilowatts)",
             col = "red")
        
        dev.off()
        
}
        