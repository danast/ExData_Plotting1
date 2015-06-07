## plot1.R
require(data.table)

plot1 <- function() {
    ## Read data from file  na.strings="?", 
    DT <- fread("household_power_consumption.txt", sep=";", na.strings="?", colClasses="character")
    ## strptime(d, format="%d/%m/%Y")
    setkey(DT, Date)
    ## Only the dates we're looking for
    data <- DT[c("1/2/2007","2/2/2007")]
    png(filename="plot1.png", width=480, height=480)
    hist(as.numeric(data[,Global_active_power]), main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency", col="red")
    dev.off()
}