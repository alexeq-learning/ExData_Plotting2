# Load data (assume it is in current dir)
nei = readRDS("summarySCC_PM25.rds")
scc = readRDS("Source_Classification_Code.rds")

# Filter records for Baltimore City and Los Angeles
baltimore = nei[nei$fips == "24510", ]
losangelos = nei[nei$fips == "06037", ]

# Motor vehicles are identified by "Onroad" in Data.Category
vehicles = scc[scc$Data.Category == "Onroad", ]
# Filter emissions by found SCC codes
baltimore_emissions = baltimore[baltimore$SCC %in% vehicles$SCC, ]
losangelos_emissions = losangelos[losangelos$SCC %in% vehicles$SCC, ]
# Sum emissions by the year
baltimore_totals = aggregate(Emissions ~ year, data = baltimore_emissions, FUN = sum)
losangelos_totals = aggregate(Emissions ~ year, data = losangelos_emissions, FUN = sum)

# Draw plot
png(file="plot6.png")
plot(baltimore_totals$year, baltimore_totals$Emissions, type="o", col="red",
     main=expression("Motor Vehicles " * PM[2.5] * " Emmissions by Year"), 
     xlab="Year", ylab="Emmission (tons)", 
     ylim=range(baltimore_totals$Emissions, losangelos_totals$Emissions))
lines(losangelos_totals$year, losangelos_totals$Emissions, type="o", col="blue")
legend("right", col=c("red", "blue"), lty=1, legend=c("Baltimore", "Los Angeles"))
dev.off()
