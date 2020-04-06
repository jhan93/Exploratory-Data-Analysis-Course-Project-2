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
sub_NEI <- NEI %>% filter(fips == '24510') %>%
  group_by(year, type) %>% summarize(Total_Emissions = sum(Emissions))
sub_NEI

sub_NEI$year <- as.character(sub_NEI$year)
png('plot3.png')
g <- ggplot(data = sub_NEI, aes(x= year, y = Total_Emissions))
g+geom_bar(stat = 'identity') + facet_wrap(~type) + ggtitle('Emissions in Baltimore, MD from All Sources')
dev.off()