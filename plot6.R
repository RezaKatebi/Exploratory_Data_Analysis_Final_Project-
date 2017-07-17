# Now we are going to download the data file and unzip it  
if(!file.exists("summarySCC_PM25.rds")){
        Url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
        download.file(Url, destfile = "Pollution.zip")
        unzip("Pollution.zip", exdir = "./")
}
library(ggplot2)
library(gridExtra)
library(gapminder)
#######################################################
# Let's read the data files in 
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#######################################################
# Now let's subset the data for the Balitomre city 
NEI_Baltimore <- subset(NEI, fips == "24510" & type == "ON-ROAD")
NEI_LA <- subset(NEI, fips == "06037" & type == "ON-ROAD")
#######################################################
# Here we are going to calculte the Total emissions of 
# PM2.5 per year in Baltimore city

Total_year_BL <- aggregate(Emissions ~ year, NEI_Baltimore, sum, na.rm =T)

Total_year_LA <- aggregate(Emissions ~ year, NEI_LA, sum, na.rm =T)
gg1 <- ggplot(Total_year_BL, aes(x = factor(year), y = Emissions,
                                 fill = year, label = round(Emissions,2)))
p1 <- gg1 + geom_bar(stat = "identity") + 
        geom_label(aes(fill =year), col = "white") +
        ylab(expression("PM"[2.5]*"Emissions")) + xlab("Year") +
        ggtitle("Total emissions from motor vehicle sources (Baltimore)")

gg2 <- ggplot(Total_year_LA, aes(x = factor(year), y = Emissions,
                                 fill = year, label = round(Emissions,2)))  
p2 <- gg2 + geom_bar(stat = "identity") + 
        geom_label(aes(fill =year), col = "white") +
        ylab(expression("PM"[2.5]*"Emissions")) + xlab("Year") +
        ggtitle("Total emissions from motor vehicle sources (LA)")
g <- grid.arrange(p1,p2, nrow = 2)
ggsave("plot6.png",g)

# As we can see in the grpah the PM2.5 emissions from the 
# motor vehicle sources sources increased from 1999 to 2008 in 
# Baltimore and in LA it increases from 1999 to 2005 and 
# decreases from 2005 to 2008
