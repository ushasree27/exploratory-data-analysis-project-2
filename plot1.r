library(ggplot2)
library(dplyr)


NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

plotdata <- NEI %>% group_by(year) %>% select(year, Emissions) %>% summarize(totalemission=sum(Emissions))

png("plot1.png", width = 480, height = 480)
with(plotdata, {
  plot(year, totalemission, xlab = "Year", ylab = "Total emission [tons]", main = "Emission in the United States")
  lines(year, totalemission)
})
dev.off()
