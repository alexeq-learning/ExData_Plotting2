# Load data (assume it is in current dir)
nei = readRDS("summarySCC_PM25.rds")
scc = readRDS("Source_Classification_Code.rds")

# Coal-combustion related sources are identified by "coal" in EI.Sector 
coal = scc[grep("coal", scc$EI.Sector, ignore.case = TRUE), ]
# Filter emissions by found SCC codes
coal_emissions = nei[nei$SCC %in% coal$SCC, ]
# Sum emissions by year
totals = aggregate(Emissions ~ year, data = coal_emissions, FUN = sum)

# Draw plot
png(file="plot4.png")
plot(totals, type="o", 
     main=expression("Coal Combustion " * PM[2.5] * " Emmissions by Year"), 
     xlab="Year", ylab="Emmission (tons)")
dev.off()
