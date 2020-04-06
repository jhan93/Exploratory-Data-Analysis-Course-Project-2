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

## Have total emissions from PM2.5 decreased in the Baltimore City, Maryland from 1999 to 2008? Use the base
## Plotting system to make a plot answering this question

sub_NEI <- NEI %>% filter(fips == '24510') %>%
                    group_by(year) %>% summarize(Total_Emissions = sum(Emissions))
png('plot2.png')
barplot(sub_NEI$Total_Emissions, main = 'Total Emissions (1999 and 2008) in Baltimore, MD', xlab = 'Year', ylab = 'Emissions',
        names.arg = sub_NEI$year)
dev.off()