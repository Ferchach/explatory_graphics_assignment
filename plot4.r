if(!file.exists('exdata_data_household_power_consumption.zip')) {
+ download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
destfile = 'data.zip')}
ct <- 'ccnnnnnnn'
ELPC <- read_delim(unzip("data.zip", "household_power_consumption.txt"), delim = ';', col_names = TRUE, col_types = ct, na = '?')
ELPC <- filter(ELPC, Date == '1/2/2007' | Date == '2/2/2007')
Sys.setlocale("LC_ALL", "English")
ELPC <- mutate(ELPC, Date = as.Date(Date, format = '%d/%m/%Y'))
ELPC <- mutate(ELPC, day = factor(weekdays(Date, abbreviate = T), levels = c('Thu', 'Fri', 'Sat')))
ELPC <- mutate(ELPC, time = paste(Date, Time))
ELPC <- mutate(ELPC, time = strptime(time, format = '%Y-%m-%d %H:%M:%S'))
png(file = 'plot4.png', width = 480, height = 480) 
par(mfrow = c(2, 2))
with(ELPC, plot(time, Global_active_power, type = 'n', xlab = '', ylab = 'Global Active Power(kilowatts)'))
lines(ELPC$time, ELPC$Global_active_power)
with(ELPC, plot(time, Voltage, type = 'n', xlab = 'datetime', ylab = 'Voltage'))
lines(ELPC$time, ELPC$Voltage)
with(ELPC, plot(time, Sub_metering_1, type = 'n', xlab = '', ylab = 'Energy sub metering'))
lines(ELPC$time, ELPC$Sub_metering_1)
lines(ELPC$time, ELPC$Sub_metering_2, col = 'red')
lines(ELPC$time, ELPC$Sub_metering_3, col = 'blue')
legend('topright', 
	pch = '_' , 
	col = c('black', 'red', 'blue'), 
	legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'))

with(ELPC, plot(time, Global_reactive_power, type = 'n', xlab = 'datetime'))
lines(ELPC$time, ELPC$Global_reactive_power)
dev.off()
