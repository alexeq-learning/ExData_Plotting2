# Load data (assume it is in current dir)
nei = readRDS("summarySCC_PM25.rds")
scc = readRDS("Source_Classification_Code.rds")

# Filter records for Baltimore City only
baltimore = nei[nei$fips == "24510", ]
# Sum emissions by the year and type
totals = aggregate(Emissions ~ year + type, data = baltimore, FUN = sum)

# Draw plot
library(ggplot2)
png(file="plot3.png")
qplot(year, Emissions, data = totals) +
    facet_wrap(~ type, nrow = 2, ncol = 2) +
    labs(title = expression(PM[2.5] * " Emmissions in Baltimore by Year and Type")) +
    labs(x = "Year", y = "Emmissions (tons)")
dev.off()
