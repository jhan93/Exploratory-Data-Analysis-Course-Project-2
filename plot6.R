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

combined <- subset(combined, grepl("vehicle", combined$SCC.Level.Two, ignore.case=TRUE))

test <- combined %>% filter(fips == '24510' | fips == '06037') %>% group_by(year, fips) %>% summarize(Total_Emissions = sum(Emissions))
test$fips <- ifelse(test$fips == '24510', 'Baltimore City', 
                    ifelse(test$fips == '06037', 'Los Angeles County', 'aklsjflksjf'))
test$year= as.character(test$year)

png('plot6.png')
g <- ggplot(data = test, aes(x = year, y = Total_Emissions))
g+geom_bar(stat = 'identity') + facet_wrap(~fips) + ggtitle('Emissions from Motor Vehicle Sources')
dev.off()