# Installing the required packages
install.packages("streamR")
install.packages("ROAuth")

# Loading the installed packages
library(ROAuth)
library(streamR)

# Setting the current working directory
setwd("/Users/raman/Documents/SUNY_BUFFALO/DIC_CSE_587/Project_1/Problem_1")

# CreatingOAuth Credentials
credential <- OAuthFactory$new(consumerKey= ENTER_TWITTER_CONSUMER_KEY,
                               consumerSecret= ENTER_TWITTER_CONSUMER_SECRET,
                               requestURL='https://api.twitter.com/oauth/request_token',
                               accessURL='https://api.twitter.com/oauth/access_token',
                               authURL='https://api.twitter.com/oauth/authorize')

# Authentication Process
options(RCurlOptions = list(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl")))
download.file(url="http://curl.haxx.se/ca/cacert.pem", destfile="cacert.pem")
credential$handshake(cainfo="cacert.pem")


# Function to scrape Twitter

# Scrapping data for Manhattan
filterStream( file.name="Tweets_Manhattanj.json", track="manhattan", tweets=100, oauth=credential, timeout=10, lang='en' )

# Scrapping data for Manhattan
filterStream( file.name="Tweets_Brooklyn.json", track="brooklyn", tweets=100, oauth=credential, timeout=10, lang='en' )

# Scrapping data for Manhattan
filterStream( file.name="Tweets_Bronx.json", track="bronx", tweets=100, oauth=credential, timeout=10, lang='en' )

# Scrapping data for Manhattan
filterStream( file.name="Tweets_StatenIsland.json", track="staten island", tweets=100, oauth=credential, timeout=10, lang='en' )
