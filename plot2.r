
library(ggplot2)
library(dplyr)


NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

plotdata <- NEI %>% filter(fips == "24510") %>% group_by(year) %>% select(year, Emissions) %>% summarize(totalemission=sum(Emissions))

png("plot2.png", width = 480, height = 480)
with(plotdata, {
  plot(year, totalemission, xlab = "Year", ylab = "Total emission [tons]", main = "Emission in Baltimore")
  lines(year, totalemission)
})
dev.off()
