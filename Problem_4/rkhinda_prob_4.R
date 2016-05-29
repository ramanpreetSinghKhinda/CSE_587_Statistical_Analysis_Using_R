install.packages("rjson")

library(rjson)
library(streamR)

setwd("/Users/raman/Documents/SUNY_BUFFALO/DIC_CSE_587/Project_1/Problem_4")

tweets_manhattan <- fromJSON(file = "Tweets_Manhattan.json")

df_manhattan <- data.frame(tweets_manhattan[[1]]$id_str, tweets_manhattan[[1]]$created_at, 
                           tweets_manhattan[[1]]$text, tweets_manhattan[[1]]$favorite_count, 
                           tweets_manhattan[[1]]$retweet_count, tweets_manhattan[[1]]$user$id_str, 
                           tweets_manhattan[[1]]$user$verified, tweets_manhattan[[1]]$user$followers_count, 
                           tweets_manhattan[[1]]$user$friends_count, tweets_manhattan[[1]]$user$listed_count, 
                           tweets_manhattan[[1]]$user$statuses_count, tweets_manhattan[[1]]$user$location)
df_manhattan$data_location <- "Manhattan"
df_manhattan$sentiment_buy_home <- "Neutral"
df_manhattan$sentiment_rent_apt <- "Neutral"

colnames(df_manhattan) <- c("tweet_id","tweet_created_at","tweet_text","tweet_favorite_count","tweet_retweet_count","user_id","user_verified","user_followers_count","user_friends_count","user_listed_count","user_statuses_count","user_location","data_location","sentiment_buy_home","sentiment_rent_apt")

# sentiment for buying home
if((grepl("buy", df_manhattan[1 ,]$tweet_text, ignore.case = TRUE) | grepl("purchase", df_manhattan[1 ,]$tweet_text, ignore.case = TRUE) | grepl("acquire", df_manhattan[1 ,]$tweet_text, ignore.case = TRUE) | grepl("bought", df_manhattan[1 ,]$tweet_text, ignore.case = TRUE)) 
   & (grepl("house", df_manhattan[1 ,]$tweet_text, ignore.case = TRUE)   | grepl("housing", df_manhattan[1 ,]$tweet_text, ignore.case = TRUE) | grepl("home", df_manhattan[1 ,]$tweet_text, ignore.case = TRUE)  | grepl("apartment", df_manhattan[1 ,]$tweet_text, ignore.case = TRUE)  | grepl("residence", df_manhattan[1 ,]$tweet_text, ignore.case = TRUE) | grepl("suite", df_manhattan[1 ,]$tweet_text, ignore.case = TRUE) | grepl("lodge", df_manhattan[1 ,]$tweet_text, ignore.case = TRUE) | grepl("loft", df_manhattan[1 ,]$tweet_text, ignore.case = TRUE) | grepl("penthouse", df_manhattan[1 ,]$tweet_text, ignore.case = TRUE) | grepl("flat", df_manhattan[1 ,]$tweet_text, ignore.case = TRUE)) 
   & (grepl("expensive", df_manhattan[1 ,]$tweet_text, ignore.case = TRUE) | grepl("high price", df_manhattan[1 ,]$tweet_text, ignore.case = TRUE) | grepl("can't afford", df_manhattan[1 ,]$tweet_text, ignore.case = TRUE))){
  df_manhattan[1 ,]$sentiment_buy_home <- "Expensive"
} else if((grepl("buy", df_manhattan[1 ,]$tweet_text, ignore.case = TRUE) | grepl("purchase", df_manhattan[1 ,]$tweet_text, ignore.case = TRUE) | grepl("acquire", df_manhattan[1 ,]$tweet_text, ignore.case = TRUE) | grepl("bought", df_manhattan[1 ,]$tweet_text, ignore.case = TRUE)) 
          & (grepl("house", df_manhattan[1 ,]$tweet_text, ignore.case = TRUE)  | grepl("housing", df_manhattan[1 ,]$tweet_text, ignore.case = TRUE) | grepl("home", df_manhattan[1 ,]$tweet_text, ignore.case = TRUE)  | grepl("apartment", df_manhattan[1 ,]$tweet_text, ignore.case = TRUE)  | grepl("residence", df_manhattan[1 ,]$tweet_text, ignore.case = TRUE) | grepl("suite", df_manhattan[1 ,]$tweet_text, ignore.case = TRUE) | grepl("lodge", df_manhattan[1 ,]$tweet_text, ignore.case = TRUE) | grepl("loft", df_manhattan[1 ,]$tweet_text, ignore.case = TRUE) | grepl("penthouse", df_manhattan[1 ,]$tweet_text, ignore.case = TRUE) | grepl("flat", df_manhattan[1 ,]$tweet_text, ignore.case = TRUE))){
  df_manhattan[1 ,]$sentiment_buy_home <- "Affordable"
}

# sentiment for renting home
if((grepl("rent", df_manhattan[1 ,]$tweet_text, ignore.case = TRUE) | grepl("rental", df_manhattan[1 ,]$tweet_text, ignore.case = TRUE) | grepl("lease", df_manhattan[1 ,]$tweet_text, ignore.case = TRUE) | grepl("charter", df_manhattan[1 ,]$tweet_text, ignore.case = TRUE) | grepl("hire", df_manhattan[1 ,]$tweet_text, ignore.case = TRUE) | grepl("shelter", df_manhattan[1 ,]$tweet_text, ignore.case = TRUE)  | grepl("move", df_manhattan[1 ,]$tweet_text, ignore.case = TRUE) | grepl("relocate", df_manhattan[1 ,]$tweet_text, ignore.case = TRUE) | grepl("shift", df_manhattan[1 ,]$tweet_text, ignore.case = TRUE) | grepl("transfer", df_manhattan[1 ,]$tweet_text, ignore.case = TRUE) | grepl("live", df_manhattan[1 ,]$tweet_text, ignore.case = TRUE) | grepl("living", df_manhattan[1 ,]$tweet_text, ignore.case = TRUE)) 
   | (grepl("house", df_manhattan[1 ,]$tweet_text, ignore.case = TRUE) | grepl("housing", df_manhattan[1 ,]$tweet_text, ignore.case = TRUE) | grepl("home", df_manhattan[1 ,]$tweet_text, ignore.case = TRUE) | grepl("apartment", df_manhattan[1 ,]$tweet_text, ignore.case = TRUE)  | grepl("residence", df_manhattan[1 ,]$tweet_text, ignore.case = TRUE) | grepl("suite", df_manhattan[1 ,]$tweet_text, ignore.case = TRUE) | grepl("lodge", df_manhattan[1 ,]$tweet_text, ignore.case = TRUE) | grepl("loft", df_manhattan[1 ,]$tweet_text, ignore.case = TRUE) | grepl("penthouse", df_manhattan[1 ,]$tweet_text, ignore.case = TRUE) | grepl("flat", df_manhattan[1 ,]$tweet_text, ignore.case = TRUE))
    & (grepl("expensive", df_manhattan[1 ,]$tweet_text, ignore.case = TRUE) | grepl("high price", df_manhattan[1 ,]$tweet_text, ignore.case = TRUE) | grepl("can't afford", df_manhattan[1 ,]$tweet_text, ignore.case = TRUE))){
  df_manhattan[1 ,]$sentiment_rent_apt <- "Expensive"
} else if((grepl("rent", df_manhattan[1 ,]$tweet_text, ignore.case = TRUE) | grepl("rental", df_manhattan[1 ,]$tweet_text, ignore.case = TRUE) | grepl("lease", df_manhattan[1 ,]$tweet_text, ignore.case = TRUE) | grepl("charter", df_manhattan[1 ,]$tweet_text, ignore.case = TRUE) | grepl("hire", df_manhattan[1 ,]$tweet_text, ignore.case = TRUE) | grepl("shelter", df_manhattan[1 ,]$tweet_text, ignore.case = TRUE) | grepl("move", df_manhattan[1 ,]$tweet_text, ignore.case = TRUE) | grepl("relocate", df_manhattan[1 ,]$tweet_text, ignore.case = TRUE) | grepl("shift", df_manhattan[1 ,]$tweet_text, ignore.case = TRUE) | grepl("transfer", df_manhattan[1 ,]$tweet_text, ignore.case = TRUE) | grepl("live", df_manhattan[1 ,]$tweet_text, ignore.case = TRUE) | grepl("living", df_manhattan[1 ,]$tweet_text, ignore.case = TRUE)) 
          | (grepl("house", df_manhattan[1 ,]$tweet_text, ignore.case = TRUE) | grepl("housing", df_manhattan[1 ,]$tweet_text, ignore.case = TRUE) | grepl("home", df_manhattan[1 ,]$tweet_text, ignore.case = TRUE)  | grepl("apartment", df_manhattan[1 ,]$tweet_text, ignore.case = TRUE)  | grepl("residence", df_manhattan[1 ,]$tweet_text, ignore.case = TRUE) | grepl("suite", df_manhattan[1 ,]$tweet_text, ignore.case = TRUE) | grepl("lodge", df_manhattan[1 ,]$tweet_text, ignore.case = TRUE) | grepl("loft", df_manhattan[1 ,]$tweet_text, ignore.case = TRUE) | grepl("penthouse", df_manhattan[1 ,]$tweet_text, ignore.case = TRUE) | grepl("flat", df_manhattan[1 ,]$tweet_text, ignore.case = TRUE))){
  df_manhattan[1 ,]$sentiment_rent_apt <- "Affordable"
}


count_manhattan_tweets <- length(tweets_manhattan)
print(paste("Total no. of tweets collected from Manhattan : ", count_manhattan_tweets,sep=""))

x <- 2
repeat {
  print(paste("Creating Data Frame for Manhattan Tweets Data. Collected ", x," Tweets" ,sep=""))
  temp_df_manhattan <- data.frame(tweets_manhattan[[x]]$id_str, tweets_manhattan[[x]]$created_at, tweets_manhattan[[x]]$text, tweets_manhattan[[x]]$favorite_count, tweets_manhattan[[x]]$retweet_count, tweets_manhattan[[x]]$user$id_str, tweets_manhattan[[x]]$user$verified, tweets_manhattan[[x]]$user$followers_count, tweets_manhattan[[x]]$user$friends_count, tweets_manhattan[[x]]$user$listed_count, tweets_manhattan[[x]]$user$statuses_count, tweets_manhattan[[x]]$user$location)
  temp_df_manhattan$data_location <- "Manhattan"
  temp_df_manhattan$sentiment_buy_home <- "Neutral"
  temp_df_manhattan$sentiment_rent_apt <- "Neutral"
  
  colnames(temp_df_manhattan) <- c("tweet_id","tweet_created_at","tweet_text","tweet_favorite_count","tweet_retweet_count","user_id","user_verified","user_followers_count","user_friends_count","user_listed_count","user_statuses_count","user_location","data_location","sentiment_buy_home","sentiment_rent_apt")
  
  if((grepl("buy", temp_df_manhattan$tweet_text, ignore.case = TRUE) | grepl("purchase", temp_df_manhattan$tweet_text, ignore.case = TRUE) | grepl("acquire", temp_df_manhattan$tweet_text, ignore.case = TRUE) | grepl("bought", temp_df_manhattan$tweet_text, ignore.case = TRUE)) 
     & (grepl("house", temp_df_manhattan$tweet_text, ignore.case = TRUE)   | grepl("housing", temp_df_manhattan$tweet_text, ignore.case = TRUE) | grepl("home", temp_df_manhattan$tweet_text, ignore.case = TRUE)  | grepl("apartment", temp_df_manhattan$tweet_text, ignore.case = TRUE)  | grepl("residence", temp_df_manhattan$tweet_text, ignore.case = TRUE) | grepl("suite", temp_df_manhattan$tweet_text, ignore.case = TRUE) | grepl("lodge", temp_df_manhattan$tweet_text, ignore.case = TRUE) | grepl("loft", temp_df_manhattan$tweet_text, ignore.case = TRUE) | grepl("penthouse", temp_df_manhattan$tweet_text, ignore.case = TRUE) | grepl("flat", temp_df_manhattan$tweet_text, ignore.case = TRUE)) 
     & (grepl("expensive", temp_df_manhattan$tweet_text, ignore.case = TRUE) | grepl("high price", temp_df_manhattan$tweet_text, ignore.case = TRUE) | grepl("can't afford", temp_df_manhattan$tweet_text, ignore.case = TRUE))){
    temp_df_manhattan$sentiment_buy_home <- "Expensive"
  } else if((grepl("buy", temp_df_manhattan$tweet_text, ignore.case = TRUE) | grepl("purchase", temp_df_manhattan$tweet_text, ignore.case = TRUE) | grepl("acquire", temp_df_manhattan$tweet_text, ignore.case = TRUE) | grepl("bought", temp_df_manhattan$tweet_text, ignore.case = TRUE)) 
            & (grepl("house", temp_df_manhattan$tweet_text, ignore.case = TRUE)  | grepl("housing", temp_df_manhattan$tweet_text, ignore.case = TRUE) | grepl("home", temp_df_manhattan$tweet_text, ignore.case = TRUE)  | grepl("apartment", temp_df_manhattan$tweet_text, ignore.case = TRUE)  | grepl("residence", temp_df_manhattan$tweet_text, ignore.case = TRUE) | grepl("suite", temp_df_manhattan$tweet_text, ignore.case = TRUE) | grepl("lodge", temp_df_manhattan$tweet_text, ignore.case = TRUE) | grepl("loft", temp_df_manhattan$tweet_text, ignore.case = TRUE) | grepl("penthouse", temp_df_manhattan$tweet_text, ignore.case = TRUE) | grepl("flat", temp_df_manhattan$tweet_text, ignore.case = TRUE))){
    temp_df_manhattan$sentiment_buy_home <- "Affordable"
  }
  
  # sentiment for renting home
  if((grepl("rent", temp_df_manhattan$tweet_text, ignore.case = TRUE) | grepl("rental", temp_df_manhattan$tweet_text, ignore.case = TRUE) | grepl("lease", temp_df_manhattan$tweet_text, ignore.case = TRUE) | grepl("charter", temp_df_manhattan$tweet_text, ignore.case = TRUE) | grepl("hire", temp_df_manhattan$tweet_text, ignore.case = TRUE) | grepl("shelter", temp_df_manhattan$tweet_text, ignore.case = TRUE)  | grepl("move", temp_df_manhattan$tweet_text, ignore.case = TRUE) | grepl("relocate", temp_df_manhattan$tweet_text, ignore.case = TRUE) | grepl("shift", temp_df_manhattan$tweet_text, ignore.case = TRUE) | grepl("transfer", temp_df_manhattan$tweet_text, ignore.case = TRUE) | grepl("live", temp_df_manhattan$tweet_text, ignore.case = TRUE) | grepl("living", temp_df_manhattan$tweet_text, ignore.case = TRUE)) 
     | (grepl("house", temp_df_manhattan$tweet_text, ignore.case = TRUE) | grepl("housing", temp_df_manhattan$tweet_text, ignore.case = TRUE) | grepl("home", temp_df_manhattan$tweet_text, ignore.case = TRUE) | grepl("apartment", temp_df_manhattan$tweet_text, ignore.case = TRUE)  | grepl("residence", temp_df_manhattan$tweet_text, ignore.case = TRUE) | grepl("suite", temp_df_manhattan$tweet_text, ignore.case = TRUE) | grepl("lodge", temp_df_manhattan$tweet_text, ignore.case = TRUE) | grepl("loft", temp_df_manhattan$tweet_text, ignore.case = TRUE) | grepl("penthouse", temp_df_manhattan$tweet_text, ignore.case = TRUE) | grepl("flat", temp_df_manhattan$tweet_text, ignore.case = TRUE))
     & (grepl("expensive", temp_df_manhattan$tweet_text, ignore.case = TRUE) | grepl("high price", temp_df_manhattan$tweet_text, ignore.case = TRUE) | grepl("can't afford", temp_df_manhattan$tweet_text, ignore.case = TRUE))){
    temp_df_manhattan$sentiment_rent_apt <- "Expensive"
  } else if((grepl("rent", temp_df_manhattan$tweet_text, ignore.case = TRUE) | grepl("rental", temp_df_manhattan$tweet_text, ignore.case = TRUE) | grepl("lease", temp_df_manhattan$tweet_text, ignore.case = TRUE) | grepl("charter", temp_df_manhattan$tweet_text, ignore.case = TRUE) | grepl("hire", temp_df_manhattan$tweet_text, ignore.case = TRUE) | grepl("shelter", temp_df_manhattan$tweet_text, ignore.case = TRUE) | grepl("move", temp_df_manhattan$tweet_text, ignore.case = TRUE) | grepl("relocate", temp_df_manhattan$tweet_text, ignore.case = TRUE) | grepl("shift", temp_df_manhattan$tweet_text, ignore.case = TRUE) | grepl("transfer", temp_df_manhattan$tweet_text, ignore.case = TRUE) | grepl("live", temp_df_manhattan$tweet_text, ignore.case = TRUE) | grepl("living", temp_df_manhattan$tweet_text, ignore.case = TRUE)) 
            | (grepl("house", temp_df_manhattan$tweet_text, ignore.case = TRUE) | grepl("housing", temp_df_manhattan$tweet_text, ignore.case = TRUE) | grepl("home", temp_df_manhattan$tweet_text, ignore.case = TRUE)  | grepl("apartment", temp_df_manhattan$tweet_text, ignore.case = TRUE)  | grepl("residence", temp_df_manhattan$tweet_text, ignore.case = TRUE) | grepl("suite", temp_df_manhattan$tweet_text, ignore.case = TRUE) | grepl("lodge", temp_df_manhattan$tweet_text, ignore.case = TRUE) | grepl("loft", temp_df_manhattan$tweet_text, ignore.case = TRUE) | grepl("penthouse", temp_df_manhattan$tweet_text, ignore.case = TRUE) | grepl("flat", temp_df_manhattan$tweet_text, ignore.case = TRUE))){
    temp_df_manhattan$sentiment_rent_apt <- "Affordable"
  }
  
  df_manhattan <- rbind(df_manhattan, temp_df_manhattan)
  x = x+1
  if (x > count_manhattan_tweets){
    break
  }
}  
df_manhattan = unique(df_manhattan)
nrow(df_manhattan)
head(df_manhattan)


df_manhattan.sentiment_buy_home <- data.frame(Sentiment = "Expensive", Frequency = length(which(df_manhattan$sentiment_buy_home=="Expensive")))
df_manhattan.sentiment_buy_home <- rbind(df_manhattan.sentiment_buy_home, data.frame(Sentiment = "Affordable", Frequency = length(which(df_manhattan$sentiment_buy_home=="Affordable"))))
df_manhattan.sentiment_buy_home <- rbind(df_manhattan.sentiment_buy_home, data.frame(Sentiment = "Neutral", Frequency = length(which(df_manhattan$sentiment_buy_home=="Neutral"))))
df_manhattan.sentiment_buy_home
ggplot(data=df_manhattan.sentiment_buy_home,aes(x=df_manhattan.sentiment_buy_home$Sentiment,y=df_manhattan.sentiment_buy_home$Frequency,fill=df_manhattan.sentiment_buy_home$Sentiment)) + geom_bar(stat = "identity")


df_manhattan.sentiment_rent_apt <- data.frame(Sentiment = "Expensive", Frequency = length(which(df_manhattan$sentiment_rent_apt=="Expensive")))
df_manhattan.sentiment_rent_apt <- rbind(df_manhattan.sentiment_rent_apt, data.frame(Sentiment = "Affordable", Frequency = length(which(df_manhattan$sentiment_rent_apt=="Affordable"))))
df_manhattan.sentiment_rent_apt <- rbind(df_manhattan.sentiment_rent_apt, data.frame(Sentiment = "Neutral", Frequency = length(which(df_manhattan$sentiment_rent_home=="Neutral"))))
df_manhattan.sentiment_rent_apt
ggplot(data=df_manhattan.sentiment_rent_apt,aes(x=df_manhattan.sentiment_rent_apt$Sentiment,y=df_manhattan.sentiment_rent_apt$Frequency,fill=df_manhattan.sentiment_rent_apt$Sentiment)) + geom_bar(stat = "identity")



df_tweet_collection <- df_manhattan

# -----------------------------------
# Collecting and Cleaning tweets for brooklyn
tweets_brooklyn <- fromJSON(file = "Tweets_Brooklyn.json")

count_brooklyn_tweets <- length(tweets_brooklyn)
print(paste("Total no. of tweets collected from brooklyn : ", count_brooklyn_tweets,sep=""))

df_brooklyn <- data.frame(tweet_id = 1,tweet_created_at=1,tweet_text=1,tweet_favorite_count=1,tweet_retweet_count=1,user_id=1,user_verified=1,user_followers_count=1,user_friends_count=1,user_listed_count=1,user_statuses_count=1,user_location=1,data_location=1,sentiment_buy_home=1,sentiment_rent_apt=1)

x <- 1
repeat {
  print(paste("Creating Data Frame for brooklyn Tweets Data. Collected ", x," Tweets" ,sep=""))
  temp_df_brooklyn <- data.frame(tweets_brooklyn[[x]]$id_str, tweets_brooklyn[[x]]$created_at, tweets_brooklyn[[x]]$text, tweets_brooklyn[[x]]$favorite_count, tweets_brooklyn[[x]]$retweet_count, tweets_brooklyn[[x]]$user$id_str, tweets_brooklyn[[x]]$user$verified, tweets_brooklyn[[x]]$user$followers_count, tweets_brooklyn[[x]]$user$friends_count, tweets_brooklyn[[x]]$user$listed_count, tweets_brooklyn[[x]]$user$statuses_count, tweets_brooklyn[[x]]$user$location)
  temp_df_brooklyn$data_location <- "brooklyn"
  temp_df_brooklyn$sentiment_buy_home <- "Neutral"
  temp_df_brooklyn$sentiment_rent_apt <- "Neutral"
  
  colnames(temp_df_brooklyn) <- c("tweet_id","tweet_created_at","tweet_text","tweet_favorite_count","tweet_retweet_count","user_id","user_verified","user_followers_count","user_friends_count","user_listed_count","user_statuses_count","user_location","data_location","sentiment_buy_home","sentiment_rent_apt")
  
  if((grepl("buy", temp_df_brooklyn$tweet_text, ignore.case = TRUE) | grepl("purchase", temp_df_brooklyn$tweet_text, ignore.case = TRUE) | grepl("acquire", temp_df_brooklyn$tweet_text, ignore.case = TRUE) | grepl("bought", temp_df_brooklyn$tweet_text, ignore.case = TRUE)) 
     & (grepl("house", temp_df_brooklyn$tweet_text, ignore.case = TRUE)   | grepl("housing", temp_df_brooklyn$tweet_text, ignore.case = TRUE) | grepl("home", temp_df_brooklyn$tweet_text, ignore.case = TRUE)  | grepl("apartment", temp_df_brooklyn$tweet_text, ignore.case = TRUE)  | grepl("residence", temp_df_brooklyn$tweet_text, ignore.case = TRUE) | grepl("suite", temp_df_brooklyn$tweet_text, ignore.case = TRUE) | grepl("lodge", temp_df_brooklyn$tweet_text, ignore.case = TRUE) | grepl("loft", temp_df_brooklyn$tweet_text, ignore.case = TRUE) | grepl("penthouse", temp_df_brooklyn$tweet_text, ignore.case = TRUE) | grepl("flat", temp_df_brooklyn$tweet_text, ignore.case = TRUE)) 
     & (grepl("expensive", temp_df_brooklyn$tweet_text, ignore.case = TRUE) | grepl("high price", temp_df_brooklyn$tweet_text, ignore.case = TRUE) | grepl("can't afford", temp_df_brooklyn$tweet_text, ignore.case = TRUE))){
    temp_df_brooklyn$sentiment_buy_home <- "Expensive"
  } else if((grepl("buy", temp_df_brooklyn$tweet_text, ignore.case = TRUE) | grepl("purchase", temp_df_brooklyn$tweet_text, ignore.case = TRUE) | grepl("acquire", temp_df_brooklyn$tweet_text, ignore.case = TRUE) | grepl("bought", temp_df_brooklyn$tweet_text, ignore.case = TRUE)) 
            & (grepl("house", temp_df_brooklyn$tweet_text, ignore.case = TRUE)  | grepl("housing", temp_df_brooklyn$tweet_text, ignore.case = TRUE) | grepl("home", temp_df_brooklyn$tweet_text, ignore.case = TRUE)  | grepl("apartment", temp_df_brooklyn$tweet_text, ignore.case = TRUE)  | grepl("residence", temp_df_brooklyn$tweet_text, ignore.case = TRUE) | grepl("suite", temp_df_brooklyn$tweet_text, ignore.case = TRUE) | grepl("lodge", temp_df_brooklyn$tweet_text, ignore.case = TRUE) | grepl("loft", temp_df_brooklyn$tweet_text, ignore.case = TRUE) | grepl("penthouse", temp_df_brooklyn$tweet_text, ignore.case = TRUE) | grepl("flat", temp_df_brooklyn$tweet_text, ignore.case = TRUE))){
    temp_df_brooklyn$sentiment_buy_home <- "Affordable"
  }
  
  # sentiment for renting home
  if((grepl("rent", temp_df_brooklyn$tweet_text, ignore.case = TRUE) | grepl("rental", temp_df_brooklyn$tweet_text, ignore.case = TRUE) | grepl("lease", temp_df_brooklyn$tweet_text, ignore.case = TRUE) | grepl("charter", temp_df_brooklyn$tweet_text, ignore.case = TRUE) | grepl("hire", temp_df_brooklyn$tweet_text, ignore.case = TRUE) | grepl("shelter", temp_df_brooklyn$tweet_text, ignore.case = TRUE)  | grepl("move", temp_df_brooklyn$tweet_text, ignore.case = TRUE) | grepl("relocate", temp_df_brooklyn$tweet_text, ignore.case = TRUE) | grepl("shift", temp_df_brooklyn$tweet_text, ignore.case = TRUE) | grepl("transfer", temp_df_brooklyn$tweet_text, ignore.case = TRUE) | grepl("live", temp_df_brooklyn$tweet_text, ignore.case = TRUE) | grepl("living", temp_df_brooklyn$tweet_text, ignore.case = TRUE)) 
     | (grepl("house", temp_df_brooklyn$tweet_text, ignore.case = TRUE) | grepl("housing", temp_df_brooklyn$tweet_text, ignore.case = TRUE) | grepl("home", temp_df_brooklyn$tweet_text, ignore.case = TRUE) | grepl("apartment", temp_df_brooklyn$tweet_text, ignore.case = TRUE)  | grepl("residence", temp_df_brooklyn$tweet_text, ignore.case = TRUE) | grepl("suite", temp_df_brooklyn$tweet_text, ignore.case = TRUE) | grepl("lodge", temp_df_brooklyn$tweet_text, ignore.case = TRUE) | grepl("loft", temp_df_brooklyn$tweet_text, ignore.case = TRUE) | grepl("penthouse", temp_df_brooklyn$tweet_text, ignore.case = TRUE) | grepl("flat", temp_df_brooklyn$tweet_text, ignore.case = TRUE))
     & (grepl("expensive", temp_df_brooklyn$tweet_text, ignore.case = TRUE) | grepl("high price", temp_df_brooklyn$tweet_text, ignore.case = TRUE) | grepl("can't afford", temp_df_brooklyn$tweet_text, ignore.case = TRUE))){
    temp_df_brooklyn$sentiment_rent_apt <- "Expensive"
  } else if((grepl("rent", temp_df_brooklyn$tweet_text, ignore.case = TRUE) | grepl("rental", temp_df_brooklyn$tweet_text, ignore.case = TRUE) | grepl("lease", temp_df_brooklyn$tweet_text, ignore.case = TRUE) | grepl("charter", temp_df_brooklyn$tweet_text, ignore.case = TRUE) | grepl("hire", temp_df_brooklyn$tweet_text, ignore.case = TRUE) | grepl("shelter", temp_df_brooklyn$tweet_text, ignore.case = TRUE) | grepl("move", temp_df_brooklyn$tweet_text, ignore.case = TRUE) | grepl("relocate", temp_df_brooklyn$tweet_text, ignore.case = TRUE) | grepl("shift", temp_df_brooklyn$tweet_text, ignore.case = TRUE) | grepl("transfer", temp_df_brooklyn$tweet_text, ignore.case = TRUE) | grepl("live", temp_df_brooklyn$tweet_text, ignore.case = TRUE) | grepl("living", temp_df_brooklyn$tweet_text, ignore.case = TRUE)) 
            | (grepl("house", temp_df_brooklyn$tweet_text, ignore.case = TRUE) | grepl("housing", temp_df_brooklyn$tweet_text, ignore.case = TRUE) | grepl("home", temp_df_brooklyn$tweet_text, ignore.case = TRUE)  | grepl("apartment", temp_df_brooklyn$tweet_text, ignore.case = TRUE)  | grepl("residence", temp_df_brooklyn$tweet_text, ignore.case = TRUE) | grepl("suite", temp_df_brooklyn$tweet_text, ignore.case = TRUE) | grepl("lodge", temp_df_brooklyn$tweet_text, ignore.case = TRUE) | grepl("loft", temp_df_brooklyn$tweet_text, ignore.case = TRUE) | grepl("penthouse", temp_df_brooklyn$tweet_text, ignore.case = TRUE) | grepl("flat", temp_df_brooklyn$tweet_text, ignore.case = TRUE))){
    temp_df_brooklyn$sentiment_rent_apt <- "Affordable"
  }
  
  df_brooklyn <- rbind(df_brooklyn, temp_df_brooklyn)
  x = x+1
  if (x > count_brooklyn_tweets){
    break
  }
}
df_brooklyn <- df_brooklyn[-1,]
df_brooklyn = unique(df_brooklyn)
nrow(df_brooklyn)
head(df_brooklyn)


# -----------------------------------
# Collecting and Cleaning tweets for bronx
tweets_bronx <- fromJSON(file = "Tweets_Bronx.json")
df_bronx <- data.frame(tweet_id = 1,tweet_created_at=1,tweet_text=1,tweet_favorite_count=1,tweet_retweet_count=1,user_id=1,user_verified=1,user_followers_count=1,user_friends_count=1,user_listed_count=1,user_statuses_count=1,user_location=1,data_location=1,sentiment_buy_home=1,sentiment_rent_apt=1)

count_bronx_tweets <- length(tweets_bronx)
print(paste("Total no. of tweets collected from bronx : ", count_bronx_tweets,sep=""))

x <- 1
repeat {
  print(paste("Creating Data Frame for bronx Tweets Data. Collected ", x," Tweets" ,sep=""))
  temp_df_bronx <- data.frame(tweets_bronx[[x]]$id_str, tweets_bronx[[x]]$created_at, tweets_bronx[[x]]$text, tweets_bronx[[x]]$favorite_count, tweets_bronx[[x]]$retweet_count, tweets_bronx[[x]]$user$id_str, tweets_bronx[[x]]$user$verified, tweets_bronx[[x]]$user$followers_count, tweets_bronx[[x]]$user$friends_count, tweets_bronx[[x]]$user$listed_count, tweets_bronx[[x]]$user$statuses_count, tweets_bronx[[x]]$user$location)
  temp_df_bronx$data_location <- "bronx"
  temp_df_bronx$sentiment_buy_home <- "Neutral"
  temp_df_bronx$sentiment_rent_apt <- "Neutral"
  
  colnames(temp_df_bronx) <- c("tweet_id","tweet_created_at","tweet_text","tweet_favorite_count","tweet_retweet_count","user_id","user_verified","user_followers_count","user_friends_count","user_listed_count","user_statuses_count","user_location","data_location","sentiment_buy_home","sentiment_rent_apt")
  
  if((grepl("buy", temp_df_bronx$tweet_text, ignore.case = TRUE) | grepl("purchase", temp_df_bronx$tweet_text, ignore.case = TRUE) | grepl("acquire", temp_df_bronx$tweet_text, ignore.case = TRUE) | grepl("bought", temp_df_bronx$tweet_text, ignore.case = TRUE)) 
     & (grepl("house", temp_df_bronx$tweet_text, ignore.case = TRUE)   | grepl("housing", temp_df_bronx$tweet_text, ignore.case = TRUE) | grepl("home", temp_df_bronx$tweet_text, ignore.case = TRUE)  | grepl("apartment", temp_df_bronx$tweet_text, ignore.case = TRUE)  | grepl("residence", temp_df_bronx$tweet_text, ignore.case = TRUE) | grepl("suite", temp_df_bronx$tweet_text, ignore.case = TRUE) | grepl("lodge", temp_df_bronx$tweet_text, ignore.case = TRUE) | grepl("loft", temp_df_bronx$tweet_text, ignore.case = TRUE) | grepl("penthouse", temp_df_bronx$tweet_text, ignore.case = TRUE) | grepl("flat", temp_df_bronx$tweet_text, ignore.case = TRUE)) 
     & (grepl("expensive", temp_df_bronx$tweet_text, ignore.case = TRUE) | grepl("high price", temp_df_bronx$tweet_text, ignore.case = TRUE) | grepl("can't afford", temp_df_bronx$tweet_text, ignore.case = TRUE))){
    temp_df_bronx$sentiment_buy_home <- "Expensive"
  } else if((grepl("buy", temp_df_bronx$tweet_text, ignore.case = TRUE) | grepl("purchase", temp_df_bronx$tweet_text, ignore.case = TRUE) | grepl("acquire", temp_df_bronx$tweet_text, ignore.case = TRUE) | grepl("bought", temp_df_bronx$tweet_text, ignore.case = TRUE)) 
            & (grepl("house", temp_df_bronx$tweet_text, ignore.case = TRUE)  | grepl("housing", temp_df_bronx$tweet_text, ignore.case = TRUE) | grepl("home", temp_df_bronx$tweet_text, ignore.case = TRUE)  | grepl("apartment", temp_df_bronx$tweet_text, ignore.case = TRUE)  | grepl("residence", temp_df_bronx$tweet_text, ignore.case = TRUE) | grepl("suite", temp_df_bronx$tweet_text, ignore.case = TRUE) | grepl("lodge", temp_df_bronx$tweet_text, ignore.case = TRUE) | grepl("loft", temp_df_bronx$tweet_text, ignore.case = TRUE) | grepl("penthouse", temp_df_bronx$tweet_text, ignore.case = TRUE) | grepl("flat", temp_df_bronx$tweet_text, ignore.case = TRUE))){
    temp_df_bronx$sentiment_buy_home <- "Affordable"
  }
  
  # sentiment for renting home
  if((grepl("rent", temp_df_bronx$tweet_text, ignore.case = TRUE) | grepl("rental", temp_df_bronx$tweet_text, ignore.case = TRUE) | grepl("lease", temp_df_bronx$tweet_text, ignore.case = TRUE) | grepl("charter", temp_df_bronx$tweet_text, ignore.case = TRUE) | grepl("hire", temp_df_bronx$tweet_text, ignore.case = TRUE) | grepl("shelter", temp_df_bronx$tweet_text, ignore.case = TRUE)  | grepl("move", temp_df_bronx$tweet_text, ignore.case = TRUE) | grepl("relocate", temp_df_bronx$tweet_text, ignore.case = TRUE) | grepl("shift", temp_df_bronx$tweet_text, ignore.case = TRUE) | grepl("transfer", temp_df_bronx$tweet_text, ignore.case = TRUE) | grepl("live", temp_df_bronx$tweet_text, ignore.case = TRUE) | grepl("living", temp_df_bronx$tweet_text, ignore.case = TRUE)) 
     | (grepl("house", temp_df_bronx$tweet_text, ignore.case = TRUE) | grepl("housing", temp_df_bronx$tweet_text, ignore.case = TRUE) | grepl("home", temp_df_bronx$tweet_text, ignore.case = TRUE) | grepl("apartment", temp_df_bronx$tweet_text, ignore.case = TRUE)  | grepl("residence", temp_df_bronx$tweet_text, ignore.case = TRUE) | grepl("suite", temp_df_bronx$tweet_text, ignore.case = TRUE) | grepl("lodge", temp_df_bronx$tweet_text, ignore.case = TRUE) | grepl("loft", temp_df_bronx$tweet_text, ignore.case = TRUE) | grepl("penthouse", temp_df_bronx$tweet_text, ignore.case = TRUE) | grepl("flat", temp_df_bronx$tweet_text, ignore.case = TRUE))
     & (grepl("expensive", temp_df_bronx$tweet_text, ignore.case = TRUE) | grepl("high price", temp_df_bronx$tweet_text, ignore.case = TRUE) | grepl("can't afford", temp_df_bronx$tweet_text, ignore.case = TRUE))){
    temp_df_bronx$sentiment_rent_apt <- "Expensive"
  } else if((grepl("rent", temp_df_bronx$tweet_text, ignore.case = TRUE) | grepl("rental", temp_df_bronx$tweet_text, ignore.case = TRUE) | grepl("lease", temp_df_bronx$tweet_text, ignore.case = TRUE) | grepl("charter", temp_df_bronx$tweet_text, ignore.case = TRUE) | grepl("hire", temp_df_bronx$tweet_text, ignore.case = TRUE) | grepl("shelter", temp_df_bronx$tweet_text, ignore.case = TRUE) | grepl("move", temp_df_bronx$tweet_text, ignore.case = TRUE) | grepl("relocate", temp_df_bronx$tweet_text, ignore.case = TRUE) | grepl("shift", temp_df_bronx$tweet_text, ignore.case = TRUE) | grepl("transfer", temp_df_bronx$tweet_text, ignore.case = TRUE) | grepl("live", temp_df_bronx$tweet_text, ignore.case = TRUE) | grepl("living", temp_df_bronx$tweet_text, ignore.case = TRUE)) 
            | (grepl("house", temp_df_bronx$tweet_text, ignore.case = TRUE) | grepl("housing", temp_df_bronx$tweet_text, ignore.case = TRUE) | grepl("home", temp_df_bronx$tweet_text, ignore.case = TRUE)  | grepl("apartment", temp_df_bronx$tweet_text, ignore.case = TRUE)  | grepl("residence", temp_df_bronx$tweet_text, ignore.case = TRUE) | grepl("suite", temp_df_bronx$tweet_text, ignore.case = TRUE) | grepl("lodge", temp_df_bronx$tweet_text, ignore.case = TRUE) | grepl("loft", temp_df_bronx$tweet_text, ignore.case = TRUE) | grepl("penthouse", temp_df_bronx$tweet_text, ignore.case = TRUE) | grepl("flat", temp_df_bronx$tweet_text, ignore.case = TRUE))){
    temp_df_bronx$sentiment_rent_apt <- "Affordable"
  }
  
  df_bronx <- rbind(df_bronx, temp_df_bronx)
  x = x+1
  if (x > count_bronx_tweets){
    break
  }
}
df_bronx <- df_bronx[-1,]
df_bronx = unique(df_bronx)
nrow(df_bronx)
head(df_bronx)


# -----------------------------------
# Collecting and Cleaning tweets for Staten Island
tweets_statenisland <- fromJSON(file = "Tweets_StatenIsland.json")
df_statenisland <- data.frame(tweet_id = 1,tweet_created_at=1,tweet_text=1,tweet_favorite_count=1,tweet_retweet_count=1,user_id=1,user_verified=1,user_followers_count=1,user_friends_count=1,user_listed_count=1,user_statuses_count=1,user_location=1,data_location=1,sentiment_buy_home=1,sentiment_rent_apt=1)

count_statenisland_tweets <- length(tweets_statenisland)
print(paste("Total no. of tweets collected from statenisland : ", count_statenisland_tweets,sep=""))

x <- 1
repeat {
  print(paste("Creating Data Frame for statenisland Tweets Data. Collected ", x," Tweets" ,sep=""))
  temp_df_statenisland <- data.frame(tweets_statenisland[[x]]$id_str, tweets_statenisland[[x]]$created_at, tweets_statenisland[[x]]$text, tweets_statenisland[[x]]$favorite_count, tweets_statenisland[[x]]$retweet_count, tweets_statenisland[[x]]$user$id_str, tweets_statenisland[[x]]$user$verified, tweets_statenisland[[x]]$user$followers_count, tweets_statenisland[[x]]$user$friends_count, tweets_statenisland[[x]]$user$listed_count, tweets_statenisland[[x]]$user$statuses_count, tweets_statenisland[[x]]$user$location)
  temp_df_statenisland$data_location <- "statenisland"
  temp_df_statenisland$sentiment_buy_home <- "Neutral"
  temp_df_statenisland$sentiment_rent_apt <- "Neutral"
  
  colnames(temp_df_statenisland) <- c("tweet_id","tweet_created_at","tweet_text","tweet_favorite_count","tweet_retweet_count","user_id","user_verified","user_followers_count","user_friends_count","user_listed_count","user_statuses_count","user_location","data_location","sentiment_buy_home","sentiment_rent_apt")
  
  if((grepl("buy", temp_df_statenisland$tweet_text, ignore.case = TRUE) | grepl("purchase", temp_df_statenisland$tweet_text, ignore.case = TRUE) | grepl("acquire", temp_df_statenisland$tweet_text, ignore.case = TRUE) | grepl("bought", temp_df_statenisland$tweet_text, ignore.case = TRUE)) 
     & (grepl("house", temp_df_statenisland$tweet_text, ignore.case = TRUE)   | grepl("housing", temp_df_statenisland$tweet_text, ignore.case = TRUE) | grepl("home", temp_df_statenisland$tweet_text, ignore.case = TRUE)  | grepl("apartment", temp_df_statenisland$tweet_text, ignore.case = TRUE)  | grepl("residence", temp_df_statenisland$tweet_text, ignore.case = TRUE) | grepl("suite", temp_df_statenisland$tweet_text, ignore.case = TRUE) | grepl("lodge", temp_df_statenisland$tweet_text, ignore.case = TRUE) | grepl("loft", temp_df_statenisland$tweet_text, ignore.case = TRUE) | grepl("penthouse", temp_df_statenisland$tweet_text, ignore.case = TRUE) | grepl("flat", temp_df_statenisland$tweet_text, ignore.case = TRUE)) 
     & (grepl("expensive", temp_df_statenisland$tweet_text, ignore.case = TRUE) | grepl("high price", temp_df_statenisland$tweet_text, ignore.case = TRUE) | grepl("can't afford", temp_df_statenisland$tweet_text, ignore.case = TRUE))){
    temp_df_statenisland$sentiment_buy_home <- "Expensive"
  } else if((grepl("buy", temp_df_statenisland$tweet_text, ignore.case = TRUE) | grepl("purchase", temp_df_statenisland$tweet_text, ignore.case = TRUE) | grepl("acquire", temp_df_statenisland$tweet_text, ignore.case = TRUE) | grepl("bought", temp_df_statenisland$tweet_text, ignore.case = TRUE)) 
            & (grepl("house", temp_df_statenisland$tweet_text, ignore.case = TRUE)  | grepl("housing", temp_df_statenisland$tweet_text, ignore.case = TRUE) | grepl("home", temp_df_statenisland$tweet_text, ignore.case = TRUE)  | grepl("apartment", temp_df_statenisland$tweet_text, ignore.case = TRUE)  | grepl("residence", temp_df_statenisland$tweet_text, ignore.case = TRUE) | grepl("suite", temp_df_statenisland$tweet_text, ignore.case = TRUE) | grepl("lodge", temp_df_statenisland$tweet_text, ignore.case = TRUE) | grepl("loft", temp_df_statenisland$tweet_text, ignore.case = TRUE) | grepl("penthouse", temp_df_statenisland$tweet_text, ignore.case = TRUE) | grepl("flat", temp_df_statenisland$tweet_text, ignore.case = TRUE))){
    temp_df_statenisland$sentiment_buy_home <- "Affordable"
  }
  
  # sentiment for renting home
  if((grepl("rent", temp_df_statenisland$tweet_text, ignore.case = TRUE) | grepl("rental", temp_df_statenisland$tweet_text, ignore.case = TRUE) | grepl("lease", temp_df_statenisland$tweet_text, ignore.case = TRUE) | grepl("charter", temp_df_statenisland$tweet_text, ignore.case = TRUE) | grepl("hire", temp_df_statenisland$tweet_text, ignore.case = TRUE) | grepl("shelter", temp_df_statenisland$tweet_text, ignore.case = TRUE)  | grepl("move", temp_df_statenisland$tweet_text, ignore.case = TRUE) | grepl("relocate", temp_df_statenisland$tweet_text, ignore.case = TRUE) | grepl("shift", temp_df_statenisland$tweet_text, ignore.case = TRUE) | grepl("transfer", temp_df_statenisland$tweet_text, ignore.case = TRUE) | grepl("live", temp_df_statenisland$tweet_text, ignore.case = TRUE) | grepl("living", temp_df_statenisland$tweet_text, ignore.case = TRUE)) 
     | (grepl("house", temp_df_statenisland$tweet_text, ignore.case = TRUE) | grepl("housing", temp_df_statenisland$tweet_text, ignore.case = TRUE) | grepl("home", temp_df_statenisland$tweet_text, ignore.case = TRUE) | grepl("apartment", temp_df_statenisland$tweet_text, ignore.case = TRUE)  | grepl("residence", temp_df_statenisland$tweet_text, ignore.case = TRUE) | grepl("suite", temp_df_statenisland$tweet_text, ignore.case = TRUE) | grepl("lodge", temp_df_statenisland$tweet_text, ignore.case = TRUE) | grepl("loft", temp_df_statenisland$tweet_text, ignore.case = TRUE) | grepl("penthouse", temp_df_statenisland$tweet_text, ignore.case = TRUE) | grepl("flat", temp_df_statenisland$tweet_text, ignore.case = TRUE))
     & (grepl("expensive", temp_df_statenisland$tweet_text, ignore.case = TRUE) | grepl("high price", temp_df_statenisland$tweet_text, ignore.case = TRUE) | grepl("can't afford", temp_df_statenisland$tweet_text, ignore.case = TRUE))){
    temp_df_statenisland$sentiment_rent_apt <- "Expensive"
  } else if((grepl("rent", temp_df_statenisland$tweet_text, ignore.case = TRUE) | grepl("rental", temp_df_statenisland$tweet_text, ignore.case = TRUE) | grepl("lease", temp_df_statenisland$tweet_text, ignore.case = TRUE) | grepl("charter", temp_df_statenisland$tweet_text, ignore.case = TRUE) | grepl("hire", temp_df_statenisland$tweet_text, ignore.case = TRUE) | grepl("shelter", temp_df_statenisland$tweet_text, ignore.case = TRUE) | grepl("move", temp_df_statenisland$tweet_text, ignore.case = TRUE) | grepl("relocate", temp_df_statenisland$tweet_text, ignore.case = TRUE) | grepl("shift", temp_df_statenisland$tweet_text, ignore.case = TRUE) | grepl("transfer", temp_df_statenisland$tweet_text, ignore.case = TRUE) | grepl("live", temp_df_statenisland$tweet_text, ignore.case = TRUE) | grepl("living", temp_df_statenisland$tweet_text, ignore.case = TRUE)) 
            | (grepl("house", temp_df_statenisland$tweet_text, ignore.case = TRUE) | grepl("housing", temp_df_statenisland$tweet_text, ignore.case = TRUE) | grepl("home", temp_df_statenisland$tweet_text, ignore.case = TRUE)  | grepl("apartment", temp_df_statenisland$tweet_text, ignore.case = TRUE)  | grepl("residence", temp_df_statenisland$tweet_text, ignore.case = TRUE) | grepl("suite", temp_df_statenisland$tweet_text, ignore.case = TRUE) | grepl("lodge", temp_df_statenisland$tweet_text, ignore.case = TRUE) | grepl("loft", temp_df_statenisland$tweet_text, ignore.case = TRUE) | grepl("penthouse", temp_df_statenisland$tweet_text, ignore.case = TRUE) | grepl("flat", temp_df_statenisland$tweet_text, ignore.case = TRUE))){
    temp_df_statenisland$sentiment_rent_apt <- "Affordable"
  }
  
  df_statenisland <- rbind(df_statenisland, temp_df_statenisland)
  x = x+1
  if (x > count_statenisland_tweets){
    break
  }
} 
df_statenisland <- df_statenisland[-1,]
df_statenisland = unique(df_statenisland)
nrow(df_statenisland)
head(df_statenisland)

#--------------------------
# Sentiment Analysis

df_sentiment <- data.frame(location = "Manhattan_Expensive", freq_sentiment_buy_home = length(which(df_manhattan$sentiment_buy_home=="Expensive")), freq_sentiment_rent_apt = length(which(df_manhattan$sentiment_rent_apt=="Expensive")))
df_sentiment <- rbind(df_sentiment, data.frame(location = "M_Affordable", freq_sentiment_buy_home = length(which(df_manhattan$sentiment_buy_home=="Affordable")), freq_sentiment_rent_apt = length(which(df_manhattan$sentiment_rent_apt=="Affordable"))))
df_sentiment <- rbind(df_sentiment, data.frame(location = "M_Neutral", freq_sentiment_buy_home = length(which(df_manhattan$sentiment_buy_home=="Neutral")), freq_sentiment_rent_apt = length(which(df_manhattan$sentiment_rent_apt=="Neutral"))))

df_sentiment <- rbind(df_sentiment, data.frame(location = "Brooklyn_Expensive", freq_sentiment_buy_home = length(which(df_brooklyn$sentiment_buy_home=="Expensive")), freq_sentiment_rent_apt = length(which(df_brooklyn$sentiment_rent_apt=="Expensive"))))
df_sentiment <- rbind(df_sentiment, data.frame(location = "Br_Affordable", freq_sentiment_buy_home = length(which(df_brooklyn$sentiment_buy_home=="Affordable")), freq_sentiment_rent_apt = length(which(df_brooklyn$sentiment_rent_apt=="Affordable"))))
df_sentiment <- rbind(df_sentiment, data.frame(location = "Br_Neutral", freq_sentiment_buy_home = length(which(df_brooklyn$sentiment_buy_home=="Neutral")), freq_sentiment_rent_apt = length(which(df_brooklyn$sentiment_rent_apt=="Neutral"))))

df_sentiment <- rbind(df_sentiment, data.frame(location = "Bronx_Expensive", freq_sentiment_buy_home = length(which(df_bronx$sentiment_buy_home=="Expensive")), freq_sentiment_rent_apt = length(which(df_bronx$sentiment_rent_apt=="Expensive"))))
df_sentiment <- rbind(df_sentiment, data.frame(location = "B_Affordable", freq_sentiment_buy_home = length(which(df_bronx$sentiment_buy_home=="Affordable")), freq_sentiment_rent_apt = length(which(df_bronx$sentiment_rent_apt=="Affordable"))))
df_sentiment <- rbind(df_sentiment, data.frame(location = "B_Neutral", freq_sentiment_buy_home = length(which(df_bronx$sentiment_buy_home=="Neutral")), freq_sentiment_rent_apt = length(which(df_bronx$sentiment_rent_apt=="Neutral"))))

df_sentiment <- rbind(df_sentiment, data.frame(location = "Staten_Island_Expensive", freq_sentiment_buy_home = length(which(df_statenisland$sentiment_buy_home=="Expensive")), freq_sentiment_rent_apt = length(which(df_statenisland$sentiment_rent_apt=="Expensive"))))
df_sentiment <- rbind(df_sentiment, data.frame(location = "S_Affordable", freq_sentiment_buy_home = length(which(df_statenisland$sentiment_buy_home=="Affordable")), freq_sentiment_rent_apt = length(which(df_statenisland$sentiment_rent_apt=="Affordable"))))
df_sentiment <- rbind(df_sentiment, data.frame(location = "S_Neutral", freq_sentiment_buy_home = length(which(df_statenisland$sentiment_buy_home=="Neutral")), freq_sentiment_rent_apt = length(which(df_statenisland$sentiment_rent_apt=="Neutral"))))

df_sentiment
ggplot(data=df_sentiment,aes(x=df_sentiment$location,y=df_sentiment$freq_sentiment_buy_home,fill=df_sentiment$location)) + geom_bar(stat = "identity")
ggplot(data=df_sentiment,aes(x=df_sentiment$location,y=df_sentiment$freq_sentiment_rent_apt,fill=df_sentiment$location)) + geom_bar(stat = "identity")