# Load data (assume it is in current dir)
nei = readRDS("summarySCC_PM25.rds")
scc = readRDS("Source_Classification_Code.rds")

# Sum emissions by the year
totals = aggregate(Emissions ~ year, data = nei, FUN = sum)

# Draw plot
png(file="plot1.png")
plot(totals, type="o", 
     main=expression("Total " * PM[2.5] * " Emmissions by Year"), 
     xlab="Year", ylab="Emmission (tons)")
dev.off()
