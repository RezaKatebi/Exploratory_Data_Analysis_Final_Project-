# Now we are going to download the data file and unzip it  
if(!file.exists("summarySCC_PM25.rds")){
        Url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
        download.file(Url, destfile = "Pollution.zip")
        unzip("Pollution.zip", exdir = "./")
}

#######################################################
# Let's read the data files in 
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#######################################################
# Here we are going to calculte the Total emissions of 
# PM2.5 per year 

Total_year <- with(NEI, tapply(Emissions, year, sum, na.rm = T))

png(file = "plot1.png")
plot(names(Total_year), Total_year, pch = 19,
     xlab = "Year", ylab = "Total emissions from PM2.5 (tons)", col = "navy",
     main = "Total emissions from PM2.5 in USA")
lines(names(Total_year), Total_year, col = "navy", lty = 2)
dev.off()

# As we see in the graph the total emissions from PM2.5 decreased in
# the United States from 1999 to 2008 decreased 
