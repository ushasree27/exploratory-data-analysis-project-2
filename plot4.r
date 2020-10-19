library(ggplot2)
library(dplyr)
NEI <- readRDS("summarySCC_PM25.rds")
SCC_data <- readRDS("Source_Classification_Code.rds")

coalcombustion_scc <- (SCC_data %>% filter(grepl('Coal', Short.Name), grepl('Combustion', SCC.Level.One)))$SCC

plotdata <- NEI %>% filter(SCC %in% coalcombustion_scc) %>% group_by(year) %>% select(year, Emissions) %>% summarize(totalemission=sum(Emissions))

g <- ggplot(data=plotdata, aes(year, totalemission))
g + geom_line() + labs(title="Emission in US for coal combustion", x="Year", y="Total emission [tons]")
ggsave("plot4.png", width=4.80, height=4.80, dpi=100)
