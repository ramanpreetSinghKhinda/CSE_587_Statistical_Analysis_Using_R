# loading the installed packages
library(streamR)
library(rjson)

# Setting the current working directory
setwd("/Users/raman/Documents/SUNY_BUFFALO/DIC_CSE_587/Project_1/Problem_1")

# Function to parse the tweets
get_tweets_df<-function(filename, data_location_name){
  tweets <- parseTweets(tweets=filename)
  
  # Capturing only information of interest and creating data frame out of it
  df_tweets <- data.frame(tweets$id_str, tweets$created_at, tweets$text, tweets$favourites_count, 
                          tweets$retweet_count, tweets$user_id_str, tweets$verified, 
                          tweets$followers_count, tweets$friends_count, tweets$listed_count, 
                          tweets$statuses_count, tweets$location)
  df_tweets$data_location <- data_location_name

  # Adding intuitive column names
  colnames(df_tweets) <- c("tweet_id","tweet_created_at","tweet_text","tweet_favorite_count",
                           "tweet_retweet_count","user_id","user_verified","user_followers_count",
                           "user_friends_count","user_listed_count","user_statuses_count",
                           "user_location","data_location")
  
  # Capturing only unique tweets
  df_tweets <- unique(df_tweets)
  
  return(df_tweets)
}

# Fetching data for Manhattan
df_manhattan <- get_tweets_df('Tweets_Manhattan.json', "Manhattan")
head(df_manhattan)

# Fetching data for Brooklyn
df_brooklyn <- get_tweets_df('Tweets_Brooklyn.json', "Brooklyn")
head(df_brooklyn)

# Fetching data for Bronx
df_bronx <- get_tweets_df('Tweets_Bronx.json', "Bronx")
head(df_bronx)

# Fetching data for Staten island
df_staten_island <- get_tweets_df('Tweets_StatenIsland.json', "Staten Island")
head(df_staten_island)
