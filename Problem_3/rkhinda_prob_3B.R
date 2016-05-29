# Once the script "rkhinda_prob_3A.R" is executed we will have created objects which are required during monthly data exploration


# collecting and cleaning data for bronx
data_bronx<- read.xls("rollingsales_bronx.xls",pattern="BOROUGH")
names(data_bronx) <- tolower(names(data_bronx))
data_bronx$sale.price.n <- as.numeric(gsub("[^[:digit:]]","", data_bronx$sale.price))
data_bronx$sale.date <- as.Date(data_bronx$sale.date)
data_bronx$year.built <- as.numeric(as.character(data_bronx$year.built))
data_bronx <- data_bronx[data_bronx$sale.price.n!=0,]
data_bronx <- data_bronx[data_bronx$year.built !=0, ]
data_bronx_frame <- data.frame(data_bronx$neighborhood, data_bronx$building.class.category, 
                               data_bronx$year.built, data_bronx$sale.price.n, data_bronx$sale.date)
data_bronx_frame$city_name <- "bronx"
colnames(data_bronx_frame) <- c("Neighborhood", "Home_Category", "Year_Built", 
                                "Sale_Price", "Sale_Date", "City_Name")
head(data_bronx_frame)



# collecting and cleaning data for manhattan
data_manhattan<- read.xls("rollingsales_manhattan.xls",pattern="BOROUGH")
names(data_manhattan) <- tolower(names(data_manhattan))
data_manhattan$sale.price.n <- as.numeric(gsub("[^[:digit:]]","", data_manhattan$sale.price))
data_manhattan$sale.date <- as.Date(data_manhattan$sale.date)
data_manhattan$year.built <- as.numeric(as.character(data_manhattan$year.built))
data_manhattan <- data_manhattan[data_manhattan$sale.price.n!=0,]
data_manhattan <- data_manhattan[data_manhattan$year.built !=0, ]
data_manhattan_frame <- data.frame(data_manhattan$neighborhood, data_manhattan$building.class.category, data_manhattan$year.built, data_manhattan$sale.price.n, data_manhattan$sale.date)
data_manhattan_frame$city_name <- "manhattan"
colnames(data_manhattan_frame) <- c("Neighborhood", "Home_Category", "Year_Built", "Sale_Price", "Sale_Date", "City_Name")
head(data_manhattan_frame)



# collecting and cleaning data for queens
data_queens<- read.xls("rollingsales_queens.xls",pattern="BOROUGH")
names(data_queens) <- tolower(names(data_queens))
data_queens$sale.price.n <- as.numeric(gsub("[^[:digit:]]","", data_queens$sale.price))
data_queens$sale.date <- as.Date(data_queens$sale.date)
data_queens$year.built <- as.numeric(as.character(data_queens$year.built))
data_queens <- data_queens[data_queens$sale.price.n!=0,]
data_queens <- data_queens[data_queens$year.built !=0, ]
data_queens_frame <- data.frame(data_queens$neighborhood, data_queens$building.class.category, data_queens$year.built, data_queens$sale.price.n, data_queens$sale.date)
data_queens_frame$city_name <- "queens"
colnames(data_queens_frame) <- c("Neighborhood", "Home_Category", "Year_Built", "Sale_Price", "Sale_Date", "City_Name")
head(data_queens_frame)



# collecting and cleaning data for statenisland
data_statenisland<- read.xls("rollingsales_statenisland.xls",pattern="BOROUGH")
names(data_statenisland) <- tolower(names(data_statenisland))
data_statenisland$sale.price.n <- as.numeric(gsub("[^[:digit:]]","", data_statenisland$sale.price))
data_statenisland$sale.date <- as.Date(data_statenisland$sale.date)
data_statenisland$year.built <- as.numeric(as.character(data_statenisland$year.built))
data_statenisland <- data_statenisland[data_statenisland$sale.price.n!=0,]
data_statenisland <- data_statenisland[data_statenisland$year.built !=0, ]
data_statenisland_frame <- data.frame(data_statenisland$neighborhood, data_statenisland$building.class.category, data_statenisland$year.built, data_statenisland$sale.price.n, data_statenisland$sale.date)
data_statenisland_frame$city_name <- "statenisland"
colnames(data_statenisland_frame) <- c("Neighborhood", "Home_Category", "Year_Built", "Sale_Price", "Sale_Date", "City_Name")
head(data_statenisland_frame)



# Total Monthly Sales for brooklyn
brooklyn_sale_dates <- data_brooklyn_frame$Sale_Date
brooklyn_sale_price <- data_brooklyn_frame$Sale_Price
brooklyn_sale_period <- as.yearmon(brooklyn_sale_dates, "%b-%y")
brooklyn_sale_period_frame <- data.frame(brooklyn_sale_period, brooklyn_sale_price)
Cum_brooklyn_sale_period_frame <- aggregate(brooklyn_sale_price ~ brooklyn_sale_period, brooklyn_sale_period_frame, function(x) sum(as.numeric(x)))
colnames(Cum_brooklyn_sale_period_frame) <- c("Sale_Period", "Total_Sales")
Cum_brooklyn_sale_period_frame


# Total Monthly Sales for bronx
bronx_sale_dates <- data_bronx_frame$Sale_Date
bronx_sale_price <- data_bronx_frame$Sale_Price
bronx_sale_period <- as.yearmon(bronx_sale_dates, "%b-%y")
bronx_sale_period_frame <- data.frame(bronx_sale_period, bronx_sale_price)
Cum_bronx_sale_period_frame <- aggregate(bronx_sale_price ~ bronx_sale_period, bronx_sale_period_frame, function(x) sum(as.numeric(x)))
colnames(Cum_bronx_sale_period_frame) <- c("Sale_Period", "Total_Sales")
Cum_bronx_sale_period_frame


# Total Monthly Sales for manhattan
manhattan_sale_dates <- data_manhattan_frame$Sale_Date
manhattan_sale_price <- data_manhattan_frame$Sale_Price
manhattan_sale_period <- as.yearmon(manhattan_sale_dates, "%b-%y")
manhattan_sale_period_frame <- data.frame(manhattan_sale_period, manhattan_sale_price)
Cum_manhattan_sale_period_frame <- aggregate(manhattan_sale_price ~ manhattan_sale_period, 
                                             manhattan_sale_period_frame, function(x) sum(as.numeric(x)))
colnames(Cum_manhattan_sale_period_frame) <- c("Sale_Period", "Total_Sales")
Cum_manhattan_sale_period_frame


# Total Monthly Sales for queens
queens_sale_dates <- data_queens_frame$Sale_Date
queens_sale_price <- data_queens_frame$Sale_Price
queens_sale_period <- as.yearmon(queens_sale_dates, "%b-%y")
queens_sale_period_frame <- data.frame(queens_sale_period, queens_sale_price)
Cum_queens_sale_period_frame <- aggregate(queens_sale_price ~ queens_sale_period, queens_sale_period_frame, function(x) sum(as.numeric(x)))
colnames(Cum_queens_sale_period_frame) <- c("Sale_Period", "Total_Sales")
Cum_queens_sale_period_frame


# Total Monthly Sales for statenisland
statenisland_sale_dates <- data_statenisland_frame$Sale_Date
statenisland_sale_price <- data_statenisland_frame$Sale_Price
statenisland_sale_period <- as.yearmon(statenisland_sale_dates, "%b-%y")
statenisland_sale_period_frame <- data.frame(statenisland_sale_period, statenisland_sale_price)
Cum_statenisland_sale_period_frame <- aggregate(statenisland_sale_price ~ statenisland_sale_period, statenisland_sale_period_frame, function(x) sum(as.numeric(x)))
colnames(Cum_statenisland_sale_period_frame) <- c("Sale_Period", "Total_Sales")
Cum_statenisland_sale_period_frame


g_range <- range(0, Cum_brooklyn_sale_period_frame, Cum_bronx_sale_period_frame, Cum_manhattan_sale_period_frame, Cum_queens_sale_period_frame, Cum_statenisland_sale_period_frame)
plot(Cum_brooklyn_sale_period_frame, type="o", col="black", ylim=g_range, ann=FALSE)

title(main="Total Monthly Sales", font.main=4,col.lab=rgb(0,0.5,0))
title(xlab="Sale Period",  col.lab=rgb(0,0.5,0))
title(ylab="Total Sales",  col.lab=rgb(0,0.5,0))

lines(Cum_bronx_sale_period_frame, type="o", pch=18, lty=1, col="purple")
lines(Cum_manhattan_sale_period_frame, type="o", pch=12, lty=12, col="red")
lines(Cum_queens_sale_period_frame, type="o", pch=22, lty=2, col="blue")
lines(Cum_statenisland_sale_period_frame, type="o", pch=18, lty=2, col="orange")


home_category_frame_brooklyn <- arrange(data_brooklyn_frame, -desc(data_brooklyn_frame$Year_Built))
Cum_home_category_frame_brooklyn <- aggregate(Sale_Price ~ Home_Category, home_category_frame_brooklyn, function(x) sum(as.numeric(x)))
names(Cum_home_category_frame_brooklyn) <- c("Home_Category" ,"Total_Sales")
Cum_home_category_frame_brooklyn
ggplot(data=Cum_home_category_frame_brooklyn, aes(x=Cum_home_category_frame_brooklyn$Home_Category, y=Cum_home_category_frame_brooklyn$Total_Sales, fill=Cum_home_category_frame_brooklyn$Home_Category)) + geom_bar(stat="identity")


home_category_frame_bronx <- arrange(data_bronx_frame, -desc(data_bronx_frame$Year_Built))
Cum_home_category_frame_bronx <- aggregate(Sale_Price ~ Home_Category, home_category_frame_bronx, function(x) sum(as.numeric(x)))
names(Cum_home_category_frame_bronx) <- c("Home_Category" ,"Total_Sales")
Cum_home_category_frame_bronx
ggplot(data=Cum_home_category_frame_bronx, aes(x=Cum_home_category_frame_bronx$Home_Category, y=Cum_home_category_frame_bronx$Total_Sales, fill=Cum_home_category_frame_bronx$Home_Category)) + geom_bar(stat="identity")


home_category_frame_manhattan <- arrange(data_manhattan_frame, -desc(data_manhattan_frame$Year_Built))
Cum_home_category_frame_manhattan <- aggregate(Sale_Price ~ Home_Category, home_category_frame_manhattan, function(x) sum(as.numeric(x)))
names(Cum_home_category_frame_manhattan) <- c("Home_Category" ,"Total_Sales")
Cum_home_category_frame_manhattan
ggplot(data=Cum_home_category_frame_manhattan, aes(x=Cum_home_category_frame_manhattan$Home_Category, y=Cum_home_category_frame_manhattan$Total_Sales, fill=Cum_home_category_frame_manhattan$Home_Category)) + geom_bar(stat="identity")


home_category_frame_queens <- arrange(data_queens_frame, -desc(data_queens_frame$Year_Built))
Cum_home_category_frame_queens <- aggregate(Sale_Price ~ Home_Category, home_category_frame_queens, function(x) sum(as.numeric(x)))
names(Cum_home_category_frame_queens) <- c("Home_Category" ,"Total_Sales")
Cum_home_category_frame_queens
ggplot(data=Cum_home_category_frame_queens, aes(x=Cum_home_category_frame_queens$Home_Category, y=Cum_home_category_frame_queens$Total_Sales, fill=Cum_home_category_frame_queens$Home_Category)) + geom_bar(stat="identity")


home_category_frame_statenisland <- arrange(data_statenisland_frame, -desc(data_statenisland_frame$Year_Built))
Cum_home_category_frame_statenisland <- aggregate(Sale_Price ~ Home_Category, home_category_frame_statenisland, function(x) sum(as.numeric(x)))
names(Cum_home_category_frame_statenisland) <- c("Home_Category" ,"Total_Sales")
Cum_home_category_frame_statenisland
ggplot(data=Cum_home_category_frame_statenisland, aes(x=Cum_home_category_frame_statenisland$Home_Category, y=Cum_home_category_frame_statenisland$Total_Sales, fill=Cum_home_category_frame_statenisland$Home_Category)) + geom_bar(stat="identity")

