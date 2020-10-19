library(ggplot2)
library(dplyr)
library(gridExtra)

NEI <- readRDS("summarySCC_PM25.rds")
SCC_data <- readRDS("Source_Classification_Code.rds")

motorvehicle_scc <- (SCC_data %>% filter(grepl('Highway Veh', Short.Name)))$SCC

plotdata <- NEI %>% filter(SCC %in% motorvehicle_scc, fips %in% c("24510", "06037")) %>% 
  group_by(year, fips) %>% select(year, Emissions, fips) %>% summarize(totalemission=sum(Emissions))
plotdata$fips <- as.factor(plotdata$fips)
levels(plotdata$fips) <- c("New York", "Baltimore")

plotdata_difference <- plotdata %>% ungroup() %>% group_by(fips) %>% 
  mutate(EmissionDiff=abs(first(totalemission) - last(totalemission))) %>%
  filter(year=="1999")

g <- ggplot(data=plotdata, aes(year, totalemission))
p1 <- g + geom_line() + facet_grid(. ~ fips) + 
  labs(title="Emission for motor vehicles", x="Year", y="Total emission [tons]")

g <- ggplot(data=plotdata_difference, aes(fips, EmissionDiff))
p2 <- g + geom_bar(stat="identity") + labs(title="Difference between 1999 and 2008", x="City", y="Difference of Emission")

png("plot6.png", width=480, height=480, units="px")
grid.arrange(p1, p2, heights=c(3, 1))
dev.off()
