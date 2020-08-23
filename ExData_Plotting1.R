ct <- 'ccnnnnnnn'
ELPC <- read_delim("household_power_consumption.txt", delim = ';', col_names = TRUE, col_types = ct, na = '?')
ELPC <- filter(ELPC, Date == '1/2/2007' | Date == '2/2/2007')
Sys.setlocale("LC_ALL", "English")
ELPC <- mutate(ELPC, Date = as.Date(Date, format = '%d/%m/%Y'))
with(ELPC, hist(
	Global_active_power, 
	col = 'red', 
	xlab = 'Global Active Power(kilowatts)', 
	main ='Global Active Power'))
ELPC <- mutate(ELPC, day = factor(weekdays(Date, abbreviate = T), levels = c('Thu', 'Fri', 'Sat')))
ELPC1 <- mutate(ELPC1, Time = format(strptime(Time, '%T'), format = '%H:%M:%S'))
with(ELPC1, {
         plot(day, Global_active_power)
         lines(loess.smooth(day, Global_active_power))
})

ELPC1 <- mutate(ELPC1, time = paste(Date, Time))
ELPC1 <- mutate(ELPC1, time = strptime(time, format = '%Y-%m-%d %H:%M:%S'))
with(ELPC1, plot(time, Global_active_power, type = 'n', xlab = '', ylab = 'Global Active Power(kilowatts)'))
lines(ELPC1$time, ELPC1$Global_active_power)

> with(ELPC1, plot(time, Sub_metering_1, type = 'n', xlab = '', ylab = 'Energy sub metering'))
> lines(ELPC1$time, ELPC1$Sub_metering_1)
> lines(ELPC1$time, ELPC1$Sub_metering_2, col = 'red')
> lines(ELPC1$time, ELPC1$Sub_metering_3, col = 'blue')
legend('topright', pch = '_' , col = c('black', 'red', 'blue'), legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'))


with(ELPC1, plot(time, Voltage, type = 'n', xlab = 'datetime', ylab = 'Voltage'))
> lines(ELPC1$time, ELPC1$Voltage)

