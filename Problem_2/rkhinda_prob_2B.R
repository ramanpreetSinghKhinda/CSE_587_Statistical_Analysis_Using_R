# Once the script "rkhinda_prob_2A.R" is executed we will have created objects which are required during monthly data exploration

# Creating a main collection class for capturing monthly data
# We are grouping counts of clicks, Impressions, Males and Females based on Age Groups
# This summarization will help us do EDA on the monthly data
main_collection <- aggregate(cbind(data_nyt_day_1$Clicks,data_nyt_day_1$Impressions,
                                   (data_nyt_day_1$Gender == "male"), 
                                   (data_nyt_day_1$Gender == "female")
                                   )~Age_Group,data=data_nyt_day_1,sum,na.rm=TRUE)
colnames(main_collection) <- c("Age_Group", "Clicks", "Impressions", "Num_of_Males", "Num_of_Females")
main_collection$Day <- "1"
head(main_collection)

# Loop for capturing monthly data.
# This function will fetch data for each day, aggregate required fields and merge into the main collection
x <- 2
repeat {
  print(paste("Collecting New York Times data for Day ", x, sep=""))
  data_nyt_day_n <- read.csv(url(paste("http://stat.columbia.edu/~rachel/datasets/nyt", x, ".csv", sep = "")))
  data_nyt_day_n$Age_Group <- cut(data_nyt_day_n$Age, c(-Inf, 17, 24, 34, 44, 54, 64, Inf), 
                                  c("<18", "18-24", "25-34", "35-44", "45-54", "55-64", "65+"))
  data_nyt_day_n$Gender = factor(data_nyt_day_n$Gender, levels=c(0,1), labels = c("female", "male"))
  temp_collection <- aggregate(cbind(data_nyt_day_n$Clicks,data_nyt_day_n$Impressions, 
                                     (data_nyt_day_n$Gender == "male"), 
                                     (data_nyt_day_n$Gender == "female")
                                     )~Age_Group,data=data_nyt_day_n,sum,na.rm=TRUE)
  colnames(temp_collection) <- c("Age_Group", "Clicks", "Impressions", "Num_of_Males", "Num_of_Females")
  temp_collection$Day <-  x
  main_collection <- rbind(main_collection, temp_collection)
  rm(data_nyt_day_n)
  x = x+1
  if (x == 32){
    break
  }
}

# Extracting data for different age grpups
# This will help us deeply analyse data for different age groups
Age_Group_1 <- main_collection[main_collection$Age_Group=="<18",]
Age_Group_2 <- main_collection[main_collection$Age_Group=="18-24",]
Age_Group_3 <- main_collection[main_collection$Age_Group=="25-34",]
Age_Group_4 <- main_collection[main_collection$Age_Group=="35-44",]
Age_Group_5 <- main_collection[main_collection$Age_Group=="45-54",]
Age_Group_6 <- main_collection[main_collection$Age_Group=="55-64",]
Age_Group_7 <- main_collection[main_collection$Age_Group=="65+",]

Age_Group_2
Age_Group_4
Age_Group_7

summary(Age_Group_2)
summary(Age_Group_4)
summary(Age_Group_7)

# Plotting graphs for Number of Clicks vs Days by users falling under particular age group
ggplot(data=Age_Group_4,aes(x=Day,y=Clicks,fill=Day)) + geom_bar(stat = "identity")
ggplot(data=Age_Group_7,aes(x=Day,y=Clicks,fill=Day)) + geom_bar(stat = "identity")

ggplot(data=Age_Group_2,aes(x=Day,y=Clicks,fill=Day)) + geom_count()
ggplot(data=Age_Group_4,aes(x=Day,y=Clicks,fill=Day)) + geom_count()
ggplot(data=Age_Group_7,aes(x=Day,y=Clicks,fill=Day)) + geom_count()
