library(ggplot2)
library(dplyr)

NEI <- readRDS("summarySCC_PM25.rds")
SCC_data <- readRDS("Source_Classification_Code.rds")

motorvehicle_scc <- (SCC_data %>% filter(grepl('Highway Veh', Short.Name)))$SCC

plotdata <- NEI %>% filter(SCC %in% motorvehicle_scc, fips == "24510") %>% group_by(year) %>% select(year, Emissions) %>% summarize(totalemission=sum(Emissions))

g <- ggplot(data=plotdata, aes(year, totalemission))
g + geom_line() + labs(title="Emission in Baltimore for motor vehicles", x="Year", y="Total emission [tons]")
ggsave("plot5.png", width=4.80, height=4.80, dpi=100)
