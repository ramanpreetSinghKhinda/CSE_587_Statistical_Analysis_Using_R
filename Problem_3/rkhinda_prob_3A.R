# Installing the required packages
install.packages("gdata")
install.packages("zoo")

# Loading the installed packages
require(zoo)
require(gdata)

library(plyr)
library(ggplot2)


# Setting the current working directory
setwd("/Users/raman/Documents/SUNY_BUFFALO/DIC_CSE_587/Project_1/rkhinda_DIC_Project_1/Problem_3")

# Reading the data from CSV File
data_brooklyn <- read.xls("rollingsales_brooklyn.xls",pattern="BOROUGH")
head(data_brooklyn)
summary(data_brooklyn)

# Performing cleaning on the data
data_brooklyn$SALE.PRICE.N <- as.numeric(gsub("[^[:digit:]]","",data_brooklyn$SALE.PRICE))
count(is.na(data_brooklyn$SALE.PRICE.N))
names(data_brooklyn) <- tolower(names(data_brooklyn))

data_brooklyn$gross.sqft <- as.numeric(gsub("[^[:digit:]]","", data_brooklyn$gross.square.feet))
data_brooklyn$land.sqft <- as.numeric(gsub("[^[:digit:]]","", data_brooklyn$land.square.feet))
data_brooklyn$sale.date <- as.Date(data_brooklyn$sale.date)
data_brooklyn$year.built <- as.numeric(as.character(data_brooklyn$year.built))
head(data_brooklyn)

attach(data_brooklyn)
head(sale.price.n)
hist(sale.price.n)
hist(sale.price.n[sale.price.n>0])
hist(log(sale.price.n[sale.price.n>0]))
hist(gross.sqft[sale.price.n==0])
detach(data_brooklyn)

data_brooklyn.sale <- data_brooklyn[data_brooklyn$sale.price.n!=0,]
head(data_brooklyn)

# Creating a new object with sales >0
head(data_brooklyn.sale)

head(data_brooklyn, 10)
head(data_brooklyn.sale, 10)

# Plotting graphs
plot(data_brooklyn.sale$gross.sqft,data_brooklyn.sale$sale.price.n)
plot(log(data_brooklyn.sale$gross.sqft),log(data_brooklyn.sale$sale.price.n))

# Collecting only family homes
data_brooklyn.homes <- data_brooklyn.sale[which(grepl("FAMILY", data_brooklyn.sale$building.class.category)),]
head(data_brooklyn.homes)

plot(log(data_brooklyn.homes$gross.sqft),log(data_brooklyn.homes$sale.price.n))
data_brooklyn.homes[which(data_brooklyn.homes$sale.price.n<100000),] [order(data_brooklyn.homes[which(data_brooklyn.homes$sale.price.n<100000),] $sale.price.n),]


# Removing outliers
data_brooklyn.homes$outliers <- (log(data_brooklyn.homes$sale.price.n) <=5) + 0
data_brooklyn.homes <- data_brooklyn.homes[which(data_brooklyn.homes$outliers==0),]
plot(log(data_brooklyn.homes$gross.sqft),log(data_brooklyn.homes$sale.price.n))


# Comparing neighborhoods
data_brooklyn.locality <- data_brooklyn.sale[!is.na(data_brooklyn.sale$neighborhood),]
locality = unique(data_brooklyn.locality$neighborhood)
locality.avg.price <- list()
for(i in 1:length(locality)){
locality.avg.price[i] = mean(subset(data_brooklyn.sale, data_brooklyn.sale$neighborhood == locality[i])$sale.price.n)
}

plot(locality,locality.avg.price,type="o", main="Neighborhood vs Average Price" ,xlab="Locality", ylab="Average Price", col=locality)

locality <- aggregate(data_brooklyn.sale$sale.price.n,by=list(Category=data_brooklyn.sale$neighborhood),FUN=sum)
names(locality) <- c("Neighborhood", "Total_Sales")
locality <- arrange(locality,desc(Total_Sales))
head(locality)
ggplot(head(locality),aes(x=Neighborhood,y=Total_Sales,fill=Neighborhood)) + geom_bar(stat="identity")
ggplot(tail(locality),aes(x=Neighborhood,y=Total_Sales,fill=Neighborhood)) + geom_bar(stat="identity")


# Analysing Sales Data by aggregating over months
Sale_Dates <- data_brooklyn.sale$sale.date
Sale_Price <- data_brooklyn.sale$sale.price.n
Sale_Period <- as.yearmon(Sale_Dates, "%b-%y")
Sale_Period_Frame <- data.frame(Sale_Period, Sale_Price)
Cum_Sale_Period_Frame <- aggregate(Sale_Price ~ Sale_Period, 
                                   Sale_Period_Frame, function(x) sum(as.numeric(x)))
colnames(Cum_Sale_Period_Frame) <- c("Sale_Period", "Total_Sales")
Cum_Sale_Period_Frame

plot(Cum_Sale_Period_Frame$Sale_Period,Cum_Sale_Period_Frame$Total_Sales,type="o", main="Total Monthly Sales" ,xlab="Sale Period", ylab="Total Sales", col=Cum_Sale_Period_Frame$Total_Sales)



# Building Class Category and clubbed Sales
data_brooklyn.building_class <- data_brooklyn.sale[!(is.na(data_brooklyn.sale$building.class.category) | data_brooklyn.sale$building.class.category==""),]
head(data_brooklyn.building_class, 10)

Home_Category <- data_brooklyn.building_class$building.class.category
Year_Built <- data_brooklyn.building_class$year.built
Sale_Price <- data_brooklyn.building_class$sale.price.n
Home_Category_Frame <- data.frame(Home_Category, Year_Built, Sale_Price)
Home_Category_Frame <- Home_Category_Frame[Home_Category_Frame$Year_Built!=0,]
head(Home_Category_Frame)


Cum_Home_Category_Frame <- aggregate(Sale_Price ~ Home_Category, Home_Category_Frame, function(x) sum(as.numeric(x)))
Cum_Home_Category_Frame <- arrange(Cum_Home_Category_Frame,desc(Sale_Price))
names(Cum_Home_Category_Frame) <- c("Home_Category", "Total_Sales")
Cum_Home_Category_Frame
ggplot(data=Cum_Home_Category_Frame, aes(x=Cum_Home_Category_Frame$Home_Category, y=Cum_Home_Category_Frame$Total_Sales, fill=Cum_Home_Category_Frame$Home_Category)) + geom_bar(stat="identity")
Home_Category_Frame.Year_Sort <- arrange(Home_Category_Frame, -desc(Year_Built))

# Period [1800 - 1835]
Home_Category_Frame.1800_1835 <- Home_Category_Frame.Year_Sort[Home_Category_Frame.Year_Sort$Year_Built >=1800 & Home_Category_Frame.Year_Sort$Year_Built <=1835,]
Cum_Home_Category_Frame_1800_1835 <- aggregate(Sale_Price ~ Home_Category, Home_Category_Frame.1800_1835, function(x) sum(as.numeric(x)))
names(Cum_Home_Category_Frame_1800_1835) <- c("Home_Category" ,"Total_Sales")
Cum_Home_Category_Frame_1800_1835
ggplot(data=Cum_Home_Category_Frame_1800_1835, aes(x=Cum_Home_Category_Frame_1800_1835$Home_Category, y=Cum_Home_Category_Frame_1800_1835$Total_Sales, fill=Cum_Home_Category_Frame_1800_1835$Home_Category)) + geom_bar(stat="identity")


# Period (1835 - 1865]
Home_Category_Frame.1835_1865 <- Home_Category_Frame.Year_Sort[Home_Category_Frame.Year_Sort$Year_Built >1835 & Home_Category_Frame.Year_Sort$Year_Built <=1865,]
Cum_Home_Category_Frame_1835_1865 <- aggregate(Sale_Price ~ Home_Category, Home_Category_Frame.1835_1865, function(x) sum(as.numeric(x)))
names(Cum_Home_Category_Frame_1835_1865) <- c("Home_Category" ,"Total_Sales")
Cum_Home_Category_Frame_1835_1865
ggplot(data=Cum_Home_Category_Frame_1835_1865, aes(x=Cum_Home_Category_Frame_1835_1865$Home_Category, y=Cum_Home_Category_Frame_1835_1865$Total_Sales, fill=Cum_Home_Category_Frame_1835_1865$Home_Category)) + geom_bar(stat="identity")


# Period (1865 - 1895]
Home_Category_Frame.1865_1895 <- Home_Category_Frame.Year_Sort[Home_Category_Frame.Year_Sort$Year_Built >1865 & Home_Category_Frame.Year_Sort$Year_Built <=1895,]
Cum_Home_Category_Frame_1865_1895 <- aggregate(Sale_Price ~ Home_Category, Home_Category_Frame.1865_1895, function(x) sum(as.numeric(x)))
names(Cum_Home_Category_Frame_1865_1895) <- c("Home_Category" ,"Total_Sales")
Cum_Home_Category_Frame_1865_1895
ggplot(data=Cum_Home_Category_Frame_1865_1895, aes(x=Cum_Home_Category_Frame_1865_1895$Home_Category, y=Cum_Home_Category_Frame_1865_1895$Total_Sales, fill=Cum_Home_Category_Frame_1865_1895$Home_Category)) + geom_bar(stat="identity")


# Period (1895 - 1925]
Home_Category_Frame.1895_1925 <- Home_Category_Frame.Year_Sort[Home_Category_Frame.Year_Sort$Year_Built >1895 & Home_Category_Frame.Year_Sort$Year_Built <=1925,]
Cum_Home_Category_Frame_1895_1925 <- aggregate(Sale_Price ~ Home_Category, Home_Category_Frame.1895_1925, function(x) sum(as.numeric(x)))
names(Cum_Home_Category_Frame_1895_1925) <- c("Home_Category" ,"Total_Sales")
Cum_Home_Category_Frame_1895_1925
ggplot(data=Cum_Home_Category_Frame_1895_1925, aes(x=Cum_Home_Category_Frame_1895_1925$Home_Category, y=Cum_Home_Category_Frame_1895_1925$Total_Sales, fill=Cum_Home_Category_Frame_1895_1925$Home_Category)) + geom_bar(stat="identity")


# Period (1925 - 1955]
Home_Category_Frame.1925_1955 <- Home_Category_Frame.Year_Sort[Home_Category_Frame.Year_Sort$Year_Built >1925 & Home_Category_Frame.Year_Sort$Year_Built <=1955,]
Cum_Home_Category_Frame_1925_1955 <- aggregate(Sale_Price ~ Home_Category, Home_Category_Frame.1925_1955, function(x) sum(as.numeric(x)))
names(Cum_Home_Category_Frame_1925_1955) <- c("Home_Category" ,"Total_Sales")
Cum_Home_Category_Frame_1925_1955
ggplot(data=Cum_Home_Category_Frame_1925_1955, aes(x=Cum_Home_Category_Frame_1925_1955$Home_Category, y=Cum_Home_Category_Frame_1925_1955$Total_Sales, fill=Cum_Home_Category_Frame_1925_1955$Home_Category)) + geom_bar(stat="identity")



# Period (1955 - 1985]
Home_Category_Frame.1955_1985 <- Home_Category_Frame.Year_Sort[Home_Category_Frame.Year_Sort$Year_Built >1955 & Home_Category_Frame.Year_Sort$Year_Built <=1985,]
Cum_Home_Category_Frame_1955_1985 <- aggregate(Sale_Price ~ Home_Category, Home_Category_Frame.1955_1985, function(x) sum(as.numeric(x)))
names(Cum_Home_Category_Frame_1955_1985) <- c("Home_Category" ,"Total_Sales")
Cum_Home_Category_Frame_1955_1985
ggplot(data=Cum_Home_Category_Frame_1955_1985, aes(x=Cum_Home_Category_Frame_1955_1985$Home_Category, y=Cum_Home_Category_Frame_1955_1985$Total_Sales, fill=Cum_Home_Category_Frame_1955_1985$Home_Category)) + geom_bar(stat="identity")


# Period (1985 - 2015]
Home_Category_Frame.1985_2015 <- Home_Category_Frame.Year_Sort[Home_Category_Frame.Year_Sort$Year_Built >1985 & Home_Category_Frame.Year_Sort$Year_Built <=2015,]
Cum_Home_Category_Frame_1985_2015 <- aggregate(Sale_Price ~ Home_Category, Home_Category_Frame.1985_2015, function(x) sum(as.numeric(x)))
names(Cum_Home_Category_Frame_1985_2015) <- c("Home_Category" ,"Total_Sales")
Cum_Home_Category_Frame_1985_2015
ggplot(data=Cum_Home_Category_Frame_1985_2015, aes(x=Cum_Home_Category_Frame_1985_2015$Home_Category, y=Cum_Home_Category_Frame_1985_2015$Total_Sales, fill=Cum_Home_Category_Frame_1985_2015$Home_Category)) + geom_bar(stat="identity")

# final data for brooklyn
data_brooklyn_frame <- data.frame(data_brooklyn.sale$neighborhood, data_brooklyn.sale$building.class.category, data_brooklyn.sale$year.built, data_brooklyn.sale$sale.price.n, data_brooklyn.sale$sale.date)
data_brooklyn_frame <- data_brooklyn_frame[data_brooklyn_frame$data_brooklyn.sale.year.built !=0, ]
data_brooklyn_frame$city_name <- "brooklyn"
colnames(data_brooklyn_frame) <- c("Neighborhood","Home_Category", "Year_Built","Sale_Price", "Sale_Date", "City_Name")

main_collection <- data_brooklyn_frame
head(main_collection)
head(data_brooklyn_frame)

######## Linear Regression #####
