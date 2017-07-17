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
# Now let's subset the data for the Balitomre city 
NEI_Baltimore <- subset(NEI, fips == "24510")
#######################################################
# Here we are going to calculte the Total emissions of 
# PM2.5 per year in Baltimore city

Total_year_BL <- with(NEI_Baltimore, tapply(Emissions, year, sum, na.rm = T))

png(file = "plot2.png")
plot(names(Total_year_BL), Total_year_BL, pch = 19,
     xlab = "Year", ylab = "Total emissions from PM2.5 (tons)", col = "navy",
     main = "Total emissions from PM2.5 in Baltimore city")
lines(names(Total_year_BL), Total_year_BL, lty = 2, col = "navy")
dev.off()

# As we see in the graph the total emissions from PM2.5 decreased from 
# 1999 to 2002 and then increased back up in 2006 then decreased dramatically 
# in 2008. So all in all the total emission dropped form 1999 to 2008 in 
# Baltimore city