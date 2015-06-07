## plot2.R
require(data.table)

plot2 <- function() {
    ## Read data from file  na.strings="?", 
    DT <- fread("household_power_consumption.txt", sep=";", na.strings="?", colClasses="character")
    ## strptime(d, format="%d/%m/%Y")
    setkey(DT, Date)
    ## Only the dates we're looking for
    data <- DT[c("1/2/2007","2/2/2007")]
    ##data[,dt:=paste(Date, Time)]
    ## Add a DateTime column for plotting
    data[,dt:=as.POSIXct(strptime(paste(Date,Time), format="%d/%m/%Y %H:%M:%S"))]
    png(filename="plot2.png", width=480, height=480)
    ##plot(data[,as.POSIXct(strptime(dt, format="%d/%m/%Y %H:%M:%S"))], data[,Global_active_power], type="l",xlab="",ylab="Global Active Power (kilowatts)")
    plot(data[,dt], data[,Global_active_power], type="l",xlab="",ylab="Global Active Power (kilowatts)")
    dev.off()
    ##data
}