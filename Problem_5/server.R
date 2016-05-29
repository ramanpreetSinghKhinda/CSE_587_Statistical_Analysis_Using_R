library(shiny) 
library(tm)
library(wordcloud)
library(twitteR)
library(base64enc)
library(ROAuth)
library(streamR)
library(plyr)
library(stringr)
library(ggplot2)

setwd("/Users/raman/Documents/SUNY_BUFFALO/DIC_CSE_587/Project_1/Problem_5")

#create your OAuth credential
credential <- OAuthFactory$new(consumerKey= ENTER_TWITTER_CONSUMER_KEY,
                               consumerSecret= ENTER_TWITTER_CONSUMER_SECRET,
                               requestURL='https://api.twitter.com/oauth/request_token',
                               accessURL='https://api.twitter.com/oauth/access_token',
                               authURL='https://api.twitter.com/oauth/authorize')

#authentication process
options(RCurlOptions = list(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl")))
download.file(url="http://curl.haxx.se/ca/cacert.pem", destfile="cacert.pem")
credential$handshake(cainfo="cacert.pem")


shinyServer(function(input, output, session) {
 
    observe({
      paste(print("Fetching Live Results..."))

      # This function will fetch live results and save in the file. To avoid delay in showing results on Shiny UI these live files will automatically be considered for analysis when we click on refresh
      # Due to this the app may take some time to load
      filterStream(file.name="Tweets_Hillary_Clinton.json", 
                   track=c("#ImWithHer","#hillaryclinton", "#WhyImNotVotingForHillary"),
                   tweets=1000, oauth=credential, timeout=10, lang='en' )
      filterStream(file.name="Tweets_Bernie_Sander.json", 
                   track=c("#bernie2016","#FeelTheBern", "#Bernie will lose"), 
                   tweets=1000, oauth=credential, timeout=10, lang='en' )
      filterStream(file.name="Tweets_Donald_Trump.json", 
                   track=c("#NeverTrump","#AntiTrump", "#PresidentTrump"), 
                   tweets=1000, oauth=credential, timeout=10, lang='en' )
      filterStream(file.name="Tweets_Marco_Rubio.json", 
                   track=c("#marcorubio","#RubioForPresident", "Rubio will lose"), 
                   tweets=1000, oauth=credential, timeout=10, lang='en' )
      filterStream(file.name="Tweets_Ted_Cruz.json", 
                   track=c("#TedCruz","Cruz will win", "Cruz will lose"), 
                   tweets=1000, oauth=credential, timeout=10, lang='en' )
      filterStream(file.name="Tweets_John_Kasich.json", 
                   track=c("#JohnKasich","Kasich will win", "Kasich will lose"), 
                   tweets=1000, oauth=credential, timeout=10, lang='en' )
    })

    # Fetching and cleaning tweets for Hillary Clinton
    results_hillary_clinton <- get_tweets_df('Tweets_Hillary_Clinton.json')
    df_tweets_hillary_clinton <- results_hillary_clinton$df_tweets
    df_sentiment_hillary_clinton <- results_hillary_clinton$df_sentiment
    df_tweets_clinton_table <-  df_tweets_hillary_clinton[,c(2,3,4,5,12,13)]

    # Fetching and cleaning tweets for Bernie Sander
    results_bernie_sander <- get_tweets_df('Tweets_Bernie_Sander.json')
    df_tweets_bernie_sander <- results_bernie_sander$df_tweets
    df_sentiment_bernie_sander <- results_bernie_sander$df_sentiment
    df_tweets_sander_table <-  df_tweets_bernie_sander[,c(2,3,4,5,12,13)]
    
    # Fetching and cleaning tweets for Donald Trump
    results_donalad_trump <- get_tweets_df('Tweets_Donald_Trump.json')
    df_tweets_donals_trump <- results_donalad_trump$df_tweets
    df_sentiment_donals_trump <- results_donalad_trump$df_sentiment
    df_tweets_trump_table <-  df_tweets_donals_trump[,c(2,3,4,5,12,13)]
    
    # Fetching and cleaning tweets for Marco Rubio
    results_marco_rubio <- get_tweets_df('Tweets_Marco_Rubio.json')
    df_tweets_marco_rubio <- results_marco_rubio$df_tweets
    df_sentiment_marco_rubio <- results_marco_rubio$df_sentiment
    df_tweets_rubio_table <-  df_tweets_marco_rubio[,c(2,3,4,5,12,13)]
    
    # Fetching and cleaning tweets for Ted Cruz
    results_ted_cruz <- get_tweets_df('Tweets_Ted_Cruz.json')
    df_tweets_ted_cruz <- results_ted_cruz$df_tweets
    df_sentiment_ted_cruz <- results_ted_cruz$df_sentiment
    df_tweets_cruz_table <-  df_tweets_ted_cruz[,c(2,3,4,5,12,13)]
    
    # Fetching and cleaning tweets for John Kasich
    results_john_kasich <- get_tweets_df('Tweets_John_Kasich.json')
    df_tweets_john_kasich <- results_john_kasich$df_tweets
    df_sentiment_john_kasich <- results_john_kasich$df_sentiment
    df_tweets_kasich_table <-  df_tweets_john_kasich[,c(2,3,4,5,12,13)]
    
    # Combined Sentiment Analysis
    df_cum_sentiment <- data.frame(candidate = "Hillary Clinton", chance_of_winning = sum(df_sentiment_hillary_clinton[2,2], (df_sentiment_hillary_clinton[3,2])/2))
    df_cum_sentiment <- rbind(df_cum_sentiment, data.frame(candidate = "Bernie Sander", chance_of_winning = sum(df_sentiment_bernie_sander[2,2], (df_sentiment_bernie_sander[3,2]/2))))
    df_cum_sentiment <- rbind(df_cum_sentiment, data.frame(candidate = "Donald Trump", chance_of_winning = sum(df_sentiment_donals_trump[2,2], (df_sentiment_donals_trump[3,2]/2))))
    df_cum_sentiment <- rbind(df_cum_sentiment, data.frame(candidate = "Marco Rubio", chance_of_winning = sum(df_sentiment_marco_rubio[2,2], (df_sentiment_marco_rubio[3,2]/2))))
    df_cum_sentiment <- rbind(df_cum_sentiment, data.frame(candidate = "Ted Cruz", chance_of_winning = sum(df_sentiment_ted_cruz[2,2], (df_sentiment_ted_cruz[3,2]/2))))
    df_cum_sentiment <- rbind(df_cum_sentiment, data.frame(candidate = "John Kasich", chance_of_winning = sum(df_sentiment_john_kasich[2,2], (df_sentiment_john_kasich[3,2]/2))))
    
    
    # Output Analysis on Hillary Clinton
    output$clinton_plot = renderPlot({
      ggplot(data=df_sentiment_hillary_clinton,aes(x=df_sentiment_hillary_clinton$sentiment,y=df_sentiment_hillary_clinton$percent,fill=df_sentiment_hillary_clinton$sentiment)) + geom_bar(stat = "identity") + labs(title = "Will Hillary Clinton make it ?", x = "User Reviews", y = "Percentage") + scale_fill_discrete(name="User Reviews")
    })
    
    output$cum_clinton_plot = renderPlot({
      ggplot(data=df_cum_sentiment,aes(x=df_cum_sentiment$candidate,y=df_cum_sentiment$chance_of_winning,fill=df_cum_sentiment$candidate)) + geom_bar(stat = "identity") + labs(title = "Where Hillary Clinton Stand Among Others ?", x = "Candidates", y = "Chances of Winning") + scale_fill_discrete(name="Candidates")
      
    })
    
    output$clinton_table = renderDataTable({
      df_tweets_clinton_table
    })
    
    
    # Output Analysis on Bernie Sander
    output$sander_plot = renderPlot({
      ggplot(data=df_sentiment_bernie_sander,aes(x=df_sentiment_bernie_sander$sentiment,y=df_sentiment_bernie_sander$percent,fill=df_sentiment_bernie_sander$sentiment)) + geom_bar(stat = "identity") + labs(title = "Will Bernie Sander make it ?", x = "User Reviews", y = "Percentage") + scale_fill_discrete(name="User Reviews")
    })
    
    output$cum_sander_plot = renderPlot({
      ggplot(data=df_cum_sentiment,aes(x=df_cum_sentiment$candidate,y=df_cum_sentiment$chance_of_winning,fill=df_cum_sentiment$candidate)) + geom_bar(stat = "identity") + labs(title = "Where Bernie Sander Stand Among Others ?", x = "Candidates", y = "Chances of Winning") + scale_fill_discrete(name="Candidates")
      
    })
    
    output$sander_table = renderDataTable({
      df_tweets_sander_table
    })

    
    # Output Analysis on Donald Trump
    output$trump_plot = renderPlot({
      ggplot(data=df_sentiment_donals_trump,aes(x=df_sentiment_donals_trump$sentiment,y=df_sentiment_donals_trump$percent,fill=df_sentiment_donals_trump$sentiment)) + geom_bar(stat = "identity") + labs(title = "Will Donald Trump make it ?", x = "User Reviews", y = "Percentage") + scale_fill_discrete(name="User Reviews")
    })
    
    output$cum_trump_plot = renderPlot({
      ggplot(data=df_cum_sentiment,aes(x=df_cum_sentiment$candidate,y=df_cum_sentiment$chance_of_winning,fill=df_cum_sentiment$candidate)) + geom_bar(stat = "identity") + labs(title = "Where Donald Trump Stand Among Others ?", x = "Candidates", y = "Chances of Winning") + scale_fill_discrete(name="Candidates")
      
    })
    
    output$trump_table = renderDataTable({
      df_tweets_trump_table
    })

    
    # Output Analysis on Marco Rubio
    output$rubio_plot = renderPlot({
      ggplot(data=df_sentiment_marco_rubio,aes(x=df_sentiment_marco_rubio$sentiment,y=df_sentiment_marco_rubio$percent,fill=df_sentiment_marco_rubio$sentiment)) + geom_bar(stat = "identity") + labs(title = "Will Marco Rubio make it ?", x = "User Reviews", y = "Percentage") + scale_fill_discrete(name="User Reviews")
    })
    
    output$cum_rubio_plot = renderPlot({
      ggplot(data=df_cum_sentiment,aes(x=df_cum_sentiment$candidate,y=df_cum_sentiment$chance_of_winning,fill=df_cum_sentiment$candidate)) + geom_bar(stat = "identity") + labs(title = "Where Marco Rubio Stand Among Others ?", x = "Candidates", y = "Chances of Winning") + scale_fill_discrete(name="Candidates")
      
    })
    
    output$rubio_table = renderDataTable({
      df_tweets_rubio_table
    })

    
    # Output Analysis on Ted Cruz
    output$cruz_plot = renderPlot({
      ggplot(data=df_sentiment_ted_cruz,aes(x=df_sentiment_ted_cruz$sentiment,y=df_sentiment_ted_cruz$percent,fill=df_sentiment_ted_cruz$sentiment)) + geom_bar(stat = "identity") + labs(title = "Will Ted Cruz make it ?", x = "User Reviews", y = "Percentage") + scale_fill_discrete(name="User Reviews")
    })
    
    output$cum_cruz_plot = renderPlot({
      ggplot(data=df_cum_sentiment,aes(x=df_cum_sentiment$candidate,y=df_cum_sentiment$chance_of_winning,fill=df_cum_sentiment$candidate)) + geom_bar(stat = "identity") + labs(title = "Where Ted Cruz Stand Among Others ?", x = "Candidates", y = "Chances of Winning") + scale_fill_discrete(name="Candidates")
      
    })
    
    output$cruz_table = renderDataTable({
      df_tweets_cruz_table
    })
    
 
    # Output Analysis on John Kasich
    output$kasich_plot = renderPlot({
      ggplot(data=df_sentiment_john_kasich,aes(x=df_sentiment_john_kasich$sentiment,y=df_sentiment_john_kasich$percent,fill=df_sentiment_john_kasich$sentiment)) + geom_bar(stat = "identity") + labs(title = "Will John Kasich make it ?", x = "User Reviews", y = "Percentage") + scale_fill_discrete(name="User Reviews")
    })
    
    output$cum_kasich_plot = renderPlot({
      ggplot(data=df_cum_sentiment,aes(x=df_cum_sentiment$candidate,y=df_cum_sentiment$chance_of_winning,fill=df_cum_sentiment$candidate)) + geom_bar(stat = "identity") + labs(title = "Where John Kasich Stand Among Others ?", x = "Candidates", y = "Chances of Winning") + scale_fill_discrete(name="Candidates")
      
    })
    
    output$kasich_table = renderDataTable({
      df_tweets_kasich_table
    })

  })



get_tweets_df<-function(json_file){
  tweets <- parseTweets(tweets=json_file)
  df_tweets <- data.frame(tweets$id_str, tweets$created_at, tweets$text, tweets$favourites_count, tweets$retweet_count, tweets$user_id_str, tweets$verified, tweets$followers_count, tweets$friends_count, tweets$listed_count, tweets$statuses_count, tweets$location)
  df_tweets$sentiment <- "Neutral"
  colnames(df_tweets) <- c("tweet_id","tweet_created_at","tweet_text","tweet_favorite_count","tweet_retweet_count","user_id","user_verified","user_followers_count","user_friends_count","user_listed_count","user_statuses_count","user_location","sentiment")
  
  positive_words=readLines("positive_words.txt")
  negative_words=readLines("negative_words.txt")
  
  count_positive = 0
  count_negative = 0
  count_neutral = 0
  
  count_tweets <- nrow(df_tweets)
  x <- 1

  repeat {
    tweet <- df_tweets[x, 3]
    
    #http://lists.hexdump.org/pipermail/twitter-users-hexdump.org/2013-May/000335.html
    tweet<-iconv(tweet, 'UTF-8', 'ASCII') 
    tweet <- tolower(tweet)
    
    tweet_split = str_split(tweet, '\\s+')
    tweet_words_list = unlist(tweet_split)
    
    # I am grateful to the developers of these papers and their contribution towards sentiment analysis
    # Minqing Hu and Bing Liu. "Mining and Summarizing Customer Reviews." 
    #       Proceedings of the ACM SIGKDD International Conference on Knowledge 
    #       Discovery and Data Mining (KDD-2004), Aug 22-25, 2004, Seattle, 
    #       Washington, USA, 
    #
    # Bing Liu, Minqing Hu and Junsheng Cheng. "Opinion Observer: Analyzing 
    #       and Comparing Opinions on the Web." Proceedings of the 14th 
    #       International World Wide Web conference (WWW-2005), May 10-14, 
    #       2005, Chiba, Japan.
    
    positive_matches = match(tweet_words_list, positive_words)
    negative_matches = match(tweet_words_list, negative_words)
    
    positive_matches = !is.na(positive_matches)
    negative_matches = !is.na(negative_matches)
    
    score = sum(positive_matches) - sum(negative_matches)
    
    if(score > 0){
      df_tweets[x, 13] <- "Positive"
      count_positive = count_positive +1
    } else if (score < 0){
      df_tweets[x, 13] <- "Negative"
      count_negative = count_negative +1
    } else {
      df_tweets[x, 13] <- "Neutral"
      count_neutral = count_neutral +1
    }
    
    x = x+1
    if (x > count_tweets){
      break
    }
  }
  
  df_tweets <- unique(df_tweets)
  
  df_sentiment <- data.frame(sentiment = "No", percent = round((count_negative*100)/count_tweets))
  df_sentiment <- rbind(df_sentiment, data.frame(sentiment = "Yes", percent = round((count_positive*100)/count_tweets)))
  df_sentiment <- rbind(df_sentiment, data.frame(sentiment = "Can't Say", percent = round((count_neutral*100)/count_tweets)))
  
  
  output <- list("df_tweets" = df_tweets, "df_sentiment" = df_sentiment)
  return(output)
  
}