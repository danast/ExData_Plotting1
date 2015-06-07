## plot3.R
require(data.table)

plot3 <- function() {
    ## Read data from file 
    DT <- fread("household_power_consumption.txt", sep=";", na.strings="?", colClasses="character")
        
    ## Only select the dates we're looking for
    setkey(DT, Date)
    data <- DT[c("1/2/2007","2/2/2007")]
        
    ## Add a DateTime column for plotting
    data[,dt:=as.POSIXct(strptime(paste(Date,Time), format="%d/%m/%Y %H:%M:%S"))]
    
    # Open file for plotting
    png(filename="plot3.png", width=480, height=480)
    # Create the plot and draw lines for each dataset
    plot(data[,dt], data[,Sub_metering_1], type="l",xlab="",ylab="Energy sub metering")
    lines(data[,dt], data[,Sub_metering_2], col="red")
    lines(data[,dt], data[,Sub_metering_3], col="blue")
    # Add a legend
    ltxt <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
    legend("topright", legend=ltxt, lwd=1, col=c("black","red","blue"))
    # Close device
    dev.off()
    
}