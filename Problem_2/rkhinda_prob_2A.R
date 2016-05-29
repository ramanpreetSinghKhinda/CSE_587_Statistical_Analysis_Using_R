# Installing the required packages
install.packages("ggplot2")
install.packages("doBy")

# Loading the installed packages
library(ggplot2)
library("doBy")

# Setting the current working directory
setwd("/Users/raman/Documents/SUNY_BUFFALO/DIC_CSE_587/Project_1/rkhinda_DIC_Project_1/Problem_2")

# Reading CSV File
data_nyt_day_1 = read.csv(url("http://stat.columbia.edu/~rachel/datasets/nyt1.csv"))
head(data_nyt_day_1)

# Creating Age Groups
data_nyt_day_1$Age_Group = cut(data_nyt_day_1$Age, c(-Inf, 17, 24, 34, 44, 54, 64, Inf), 
                               c("<18", "18-24", "25-34", "35-44", "45-54", "55-64", "65+"))
head(data_nyt_day_1)

# Changing the labels for Gender from 1 and 0 to Male and Female to make them more intuitive
data_nyt_day_1$Gender = factor(data_nyt_day_1$Gender, levels=c(0,1), labels = c("female", "male"))
head(data_nyt_day_1)

# Creating Summary of the data
summary(data_nyt_day_1)

# Plotting Impressions made by users falling a particular age group
ggplot(data=data_nyt_day_1, aes(x=Age_Group, y=Impressions, fill=Age_Group)) + geom_bar(stat="identity")

# Creating a function for using in further summarization
siterange <- function(x){
  c(length(x), min(x), mean(x), max(x))
}

# Changing the lables for impressions to make them more intuitive
data_nyt_day_1$Has_Impressions <-cut(data_nyt_day_1$Impressions,c(-Inf,0,Inf), c("No", "Yes"))
summaryBy(Clicks~Has_Impressions, data=data_nyt_day_1, FUN=siterange)

# plotting graps for Click thru rate
ggplot(subset(data_nyt_day_1, Impressions>0), aes(x=Clicks/Impressions, colour=Age_Group)) + geom_density()
ggplot(subset(data_nyt_day_1, Clicks>0), aes(x=Clicks/Impressions, colour=Age_Group)) + geom_density()
ggplot(subset(data_nyt_day_1, Clicks>0), aes(x=Age_Group, y=Clicks, fill=Age_Group)) + geom_boxplot()
ggplot(subset(data_nyt_day_1, Clicks>0), aes(x=Clicks, colour=Age_Group)) + geom_density()


# Changing the lables for User Segment to make them more intuitive
data_nyt_day_1$User_Segment[data_nyt_day_1$Impressions==0] <- "No_Impressions"
data_nyt_day_1$User_Segment[data_nyt_day_1$Impressions>0] <- "Impressions"
data_nyt_day_1$User_Segment[data_nyt_day_1$Clicks>0] <- "Clicks"

data_nyt_day_1$User_Segment <- factor(data_nyt_day_1$User_Segment)
head(data_nyt_day_1)