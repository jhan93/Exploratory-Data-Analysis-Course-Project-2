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
names(NEI)
names(SCC)
combined <- merge(NEI, SCC, by = 'SCC')

test <- subset(combined, grepl("comb", combined$SCC.Level.One, ignore.case=TRUE) & grepl("coal", combined$SCC.Level.Four, ignore.case=TRUE))


sub_NEI <- test %>% group_by(year) %>% summarize(Total_Emissions = sum(Emissions))

png('plot4.png')
barplot(sub_NEI$Total_Emissions, main = 'Emissions from Coal Combustion Related Sources from All of U.S.', xlab = 'Year', ylab = 'Emissions',
        names.arg = sub_NEI$year)
dev.off()

