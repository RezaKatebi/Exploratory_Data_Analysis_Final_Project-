# Now we are going to download the data file and unzip it  
if(!file.exists("summarySCC_PM25.rds")){
        Url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
        download.file(Url, destfile = "Pollution.zip")
        unzip("Pollution.zip", exdir = "./")
}
library(ggplot2)
#######################################################
# Let's read the data files in 
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#######################################################
# Now let's subset the data for the Balitomre city 
NEI_Baltimore <- subset(NEI, fips == "24510")
#######################################################
# Here we are going to calculte the Total emissions of 
# PM2.5 per year and per type in Baltimore city 

Total_year_BL <- aggregate(Emissions ~ year + type, NEI_Baltimore , sum)

gg <- ggplot(Total_year_BL, aes(year, Emissions))
gg + geom_line(aes(col = type), lwd = 1) + ylab("PM2.5 Emissions") +
        ggtitle("Total emissions of PM2.5 in Baltimre city")
ggsave("plot3.png")

# As we see in the graph the total emissions from PM2.5 increased between
# 1999 to 2005 for the point type and the other types are decreasing
