# Load data (assume it is in current dir)
nei = readRDS("summarySCC_PM25.rds")
scc = readRDS("Source_Classification_Code.rds")

# Filter records for Baltimore City only
baltimore = nei[nei$fips == "24510", ]
# Motor vehicles are identified by "Onroad" in Data.Category
vehicles = scc[scc$Data.Category == "Onroad", ]
# Filter emissions by found SCC codes
vehicle_emissions = baltimore[baltimore$SCC %in% vehicles$SCC, ]
# Sum emissions by the year
totals = aggregate(Emissions ~ year, data = vehicle_emissions, FUN = sum)

# Draw plot
png(file="plot5.png")
plot(totals, type="o", 
     main=expression("Motor Vehicles " * PM[2.5] * " Emmissions in Baltimore by Year"), 
     xlab="Year", ylab="Emmission (tons)")
dev.off()
