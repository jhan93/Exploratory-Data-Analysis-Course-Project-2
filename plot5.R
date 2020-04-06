setwd('Exploratory Data Analysis')
## fips - five digit number indicating the US county
## SCC - name of source
## Pollutant - indicating the pollutant
## Emissions - PM2.5 in tons
## type - type of source (ie. point, non-point, on-road, non-road)
## year - year of emissions recorded

NEI <- readRDS('summarySCC_PM25.rds')
SCC <- readRDS('Source_Classification_Code.rds')

library(dplyr)
library(ggplot2)

combined <- merge(NEI, SCC, by = 'SCC')


test <- subset(combined, grepl("vehicle", combined$SCC.Level.Two, ignore.case=TRUE))

sub_NEI <- test %>% filter(fips == '24510') %>% group_by(year) %>% summarize(Total_Emissions = sum(Emissions))

png('plot5.png')
barplot(sub_NEI$Total_Emissions, main = 'Total Motor Vehicles Emissions in Baltimore, MD', xlab = 'Year', ylab = 'Emissions',
        names.arg = sub_NEI$year)
dev.off()