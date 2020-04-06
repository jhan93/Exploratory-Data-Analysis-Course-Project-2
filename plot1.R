setwd('Exploratory Data Analysis')
## fips - five digit number indicating the US county
## SCC - name of source
## Pollutant - indicating the pollutant
## Emissions - PM2.5 in tons
## type - type of source (ie. point, non-point, on-road, non-road)
## year - year of emissions recorded

NEI <- readRDS('summarySCC_PM25.rds')
SCC <- readRDS('Source_Classification_Code.rds')

## Have total emissions from PM2.5 decreased in the US from 1999 to 2008?
## Using the base plotting system, make a plot showing the total PM2.5
## emission from all sources for each of the years 1999, 2002, 2005, 2008

## Different plot for each year: 1999, 2002, 2005, 2008

library(dplyr)
str(NEI)
sum_NEI <- NEI %>% group_by(year) %>% summarize(Total_Emissions = sum(Emissions))

png('plot1.png')
barplot(sum_NEI$Total_Emissions, main = "Total Emission by Year", xlab = "Year", ylab = "Emissions", names.arg = sum_NEI$year)
dev.off()