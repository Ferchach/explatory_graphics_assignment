if(!file.exists('exdata_data_household_power_consumption.zip')) {
+ download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
destfile = 'data.zip')}
ct <- 'ccnnnnnnn'
ELPC <- read_delim(unzip("data.zip", "household_power_consumption.txt"), delim = ';', col_names = TRUE, col_types = ct, na = '?')
ELPC <- filter(ELPC, Date == '1/2/2007' | Date == '2/2/2007')
png(file = 'plot1.png', width = 480, height = 480)
with(ELPC, hist(
	Global_active_power, 
	col = 'red', 
	xlab = 'Global Active Power(kilowatts)', 
	main ='Global Active Power'))
dev.off()