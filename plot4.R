## plot4.R
require(data.table)

plot4 <- function() {
    ## Read data from file 
    DT <- fread("household_power_consumption.txt", sep=";", na.strings="?", colClasses="character")
    
    ## Only select the dates we're looking for
    setkey(DT, Date)
    data <- DT[c("1/2/2007","2/2/2007")]
    
    ## Add a DateTime column for plotting
    data[,dt:=as.POSIXct(strptime(paste(Date,Time), format="%d/%m/%Y %H:%M:%S"))]
    
    # Open file for plotting
    png(filename="plot4.png", width=480, height=480)
    
    ## 2 by 2 plots
    par(mfrow=c(2,2))
    
    ## Power plot from part 2 (no unit in label)
    plot(data[,dt], data[,Global_active_power], type="l",xlab="",ylab="Global Active Power")
    
    ## Voltage plot
    plot(data[,dt], data[,Voltage], type="l" ,xlab="datetime",ylab="Voltage")
    
    ## Sub metering plot from part 3 (slightly modified since legend has changed)
    # Create the plot and draw lines for each dataset, use with to simplify slightly
    with(data, {
        plot(dt, Sub_metering_1, type="l",xlab="",ylab="Energy sub metering")
        lines(dt, Sub_metering_2, col="red")
        lines(dt, Sub_metering_3, col="blue")
    })
    # Add a legend (no box this time, so bty="n")
    ltxt <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
    legend("topright", legend=ltxt, lwd=1, col=c("black","red","blue"), bty="n")
    
    ## Reactive power
    plot(data[,dt], data[,Global_reactive_power], type="l", xlab="datetime",ylab="Global_reactive_power")
        
    # Close device
    dev.off()
    
}