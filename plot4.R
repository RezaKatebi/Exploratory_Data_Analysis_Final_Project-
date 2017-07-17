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
# Let's find rws with the "Coal" name in the Short.Name 
# column 
SCC_coal <- SCC[grepl("Coal", SCC$Short.Name, ignore.case = T),]
#######################################################
# Now we can subset NEI dataset for the numbers that 
# hve the same SCC numbers as SCC column in SCC_coal 
NEI_coal <- NEI[NEI$SCC %in% SCC_coal$SCC, ]
#######################################################
# # Here we are going to calculte the Total emissions of 
# PM2.5 per year and per type from coal combustion-related 
# sources

Total_year_coal <- aggregate(Emissions ~ year + type, NEI_coal, sum)

gg <- ggplot(Total_year_coal, aes(year, Emissions))
gg + geom_line(aes(col = type), lwd = 1) + ylab("PM2.5 Emissions") + 
        ggtitle("Total emissions from coal combustion-related source (USA)")
ggsave("plot4.png")
# As we can see in the grpah the PM2.5 emissions from the 
# coal combustion-related point type sources increased 


