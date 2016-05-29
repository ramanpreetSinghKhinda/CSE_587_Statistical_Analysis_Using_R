<p align="center">Data Intensive Computing</br>Exploratory Data Analysis using R</br>CSE 587
==========================================================================================
<p align="center">![Img_1](https://raw.githubusercontent.com/ramanpreet1990/CSE_587_Statistical_Analysis_Using_R/master/Resources/2.png)


Introduction and Context
------------------------------------
Data Science process involves a phase where preliminary understanding of the data is explored. This phase is commonly known as [**Exploratory Data Analysis**](https://en.wikipedia.org/wiki/Exploratory_data_analysis) (EDA) and is a very useful phase before launching onto a full scale [**big-data analytics**](http://www.webopedia.com/TERM/B/big_data_analytics.html) that often requires extensive infrastructure support and complex or newer algorithms such as [**Hadoop MapReduce**](https://hadoop.apache.org/docs/r1.2.1/mapred_tutorial.html) and [**Apache Spark**](https://en.wikipedia.org/wiki/Apache_Spark) on large clusters. 

The algorithms and methods we will use in our EDA are also highly applicable and useful to perform (run) statistical analysis on commonly available public data sets and on the outputs of big-data processing. 

EDA is perfect complement to big-data analytics that offers a systematic approach to choosing among the many possible outcomes of big-data analytics and will help us gain intuition about the data in the early phases. EDA begins with understanding the schema of the data (head) and ends with an approximate [**statistical model**](https://en.wikipedia.org/wiki/Statistical_model) representing the data.


Data Characteristics
----------------------------
We got to work on a fairly large data sets (**multiple files having millions of rows**) that have been collected for a period of time. We have used structured and semi-structured data i.e. data stored in spreadsheets (like Excel CSV files) and [**streaming data**](https://aws.amazon.com/streaming-data/). 

Download and extract the complete data set available at: -</br>
https://github.com/oreillymedia/doing_data_science


###<p align="center">**We describe the problems to be solved in several parts**



Problem 1: Data acquisition
---------------------------------------
Data collection is an important step that often is quite time consuming and constrained by regulations and privacy and security issues. The other challenge in data collection is that data comes in different formats (text, html, txt, csv, json etc.) and feature widely varying access methods (web URL, api, hdfs, sqldb etc.). 

We will learn about this by working on few representative methods for data acquisition given in the handout:
https://github.com/ramanpreet1990/CSE_587_Statistical_Analysis_Using_R/blob/master/R_Handout.pdf

**Solution**</br>
We have collected data for a period of 1 week using twitter streaming api's. The data is regarding real estate trends in New York city. Specifically the rent vs. buy trends in Manhattan, Brooklyn, Bronx and StatenIsland.

Tutorials followed to understand Twitter Streaming API’s </br>
1. http://bogdanrau.com/blog/collecting-tweets-using-r-and-the-twitter-streaming-api/ </br>
2. http://pablobarbera.com/blog/archives/1.html

Refer complete solution: -</br>
https://github.com/ramanpreet1990/CSE_587_Statistical_Analysis_Using_R/tree/master/Problem_1


Problem 2: Simple EDA
---------------------------------
This problem explores the effectiveness of online newspaper promotions and advertisements. We have used **New York Times data** collected from https://github.com/oreillymedia/doing_data_science that contains information about readers: {age, gender, number of impressions, number of clicks, and logged in or not.} 

**Solution**</br>
We performed exploratory data analysis on the data and tried to get an intuition about behavior change in different Age Groups. As described in one of the charts below.

Refer complete solution: -</br>
https://github.com/ramanpreet1990/CSE_587_Statistical_Analysis_Using_R/tree/master/Problem_2

<p align="center">![Img_1](https://raw.githubusercontent.com/ramanpreet1990/CSE_587_Statistical_Analysis_Using_R/master/Resources/1.png)


Problem 3: Data economy - a real case study
---------------------------------------------------------------
For this problem we have to work on the RealDirect data set collected from https://github.com/oreillymedia/doing_data_science and perform EDA to find some more insights.

This particular problem is a “data problem” from a company is that is currently operational, see http://www.realdirect.com/ . Read the details and understand the business model.

**Solution**</br>
We performed EDA on the RealDirect data and plot graphs for the generated sales and analyzed the cost of living. We take a step ahead and split the Home built dates into groups of 30 years each and analyze fluctuation in sales across different location around the New York city over the years. As described in one of the charts below.

This analysis given us intuition about what home categories got popular during these different time frames.

Refer complete solution: -<br>
https://github.com/ramanpreet1990/CSE_587_Statistical_Analysis_Using_R/tree/master/Problem_3

<p align="center">![Img_3](https://raw.githubusercontent.com/ramanpreet1990/CSE_587_Statistical_Analysis_Using_R/master/Resources/3.png) 



Problem 4: Statistical analysis to support new data product
---------------------------------------------------------------
In this problem we further explore the RealDirect business. We realize that [**RealDirect**](http://www.realdirect.com/) has built a business around existing real estate (buying and selling) business by creatively repurposing the data and building a data product around it. They have created a web (and mobile) portal with tools to facilitate real estate related operations. 

Assume you have been hired by ReaDirect to extend the line of product offerings. You put on your thinking cap and realize that NY is a prime location for apartment rental since buying real estate (houses and apartments) is beyond their means for many. You also realize that many prospective clients take to twitter when they need something and want to express their sentiments and status. You plan to recommend to the executive team at RealDirect that they should offer apartment rental as a product. You want to arm yourself with data to prove your recommendation. You plan to collect twitter data about apartment rental and real estate (buying a house) for a week on a daily basis and show the feasibility of your recommendation with this statistical analysis.

**Solution**</br>
To analyze real estate trends on twitter streaming data we performed sentiment analysis on each tweet and found whether the user is talking about renting an apartment or buying an apartment. This analyses was our backing information for suggesting a new product to Real Direct.

After performing the analysis, we get to know how many users are talking about renting vs buying an apartment and also their response on cost of living at a particular place.

Refer complete solution: -<br>
https://github.com/ramanpreet1990/CSE_587_Statistical_Analysis_Using_R/tree/master/Problem_4

<p align="center">![Img_4](https://raw.githubusercontent.com/ramanpreet1990/CSE_587_Statistical_Analysis_Using_R/master/Resources/4.png) 



Problem 5: Stream processing - US Presidential Elections
---------------------
This is an Election Season and everyone is talking about who will going to be the next President of US and many data analytics companies are gauzing the Social Network data to predict the future.

Since most users take on twitter to express their sentiments on these topics. We collected data on top candidates for Democratic and Republican party and performed analysis on what users say about these candidates.

<p align="center">![Img_5](https://raw.githubusercontent.com/ramanpreet1990/CSE_587_Statistical_Analysis_Using_R/master/Resources/5.png) 


**Solution**</br>
We collected data on US Elections for over 1 week (From 28 Feb to 5 March). Since this is a live ongoing topic we have also opened a live streaming connection to the twitter api and analyzing each tweet.

We performed sentiment analysis on each tweet. To do this we are generating a list of words for each tweet and comparing this list with list of positive and negative words and checking how many words are positive and how many are negative. After this we are marking a tweet as a positive sentiment if the weightage of positive words is more than the weightage of negative words.

We created user interfaces using [**Shiny**](http://shiny.rstudio.com) which is a web application framework for R.

Refer complete solution: -<br>
https://github.com/ramanpreet1990/CSE_587_Statistical_Analysis_Using_R/tree/master/Problem_5

<p align="center">![Img_6](https://raw.githubusercontent.com/ramanpreet1990/CSE_587_Statistical_Analysis_Using_R/master/Resources/6.png) 


References and Acknowledgement
-------------------------------------------------
I am grateful to the authors of these papers and their research on Sentiment Analysis. Their contribution has helped me deeply analyze user’s sentiments.

http://www.cs.uic.edu/~liub/FBS/sentiment-analysis.html

Minqing Hu and Bing Liu. "Mining and Summarizing Customer Reviews."
Proceedings of the ACM SIGKDD International Conference on Knowledge
Discovery and Data Mining (KDD-2004), Aug 22-25, 2004, Seattle,
Washington, USA,

Bing Liu, Minqing Hu and Junsheng Cheng. "Opinion Observer: Analyzing
and Comparing Opinions on the Web." Proceedings of the 14th
International World Wide Web conference (WWW-2005), May 10-14,
2005, Chiba, Japan.


Credits
----------
I acknowledge and grateful to [**Professor Bina Ramamurthy**](http://www.cse.buffalo.edu/faculty/bina/) and [**TA Junfei Wang**](https://www.linkedin.com/in/junfei-wang-5971a848) for their continuous support throughout the Course ([**CSE 587**](http://www.cse.buffalo.edu/~bina/cse487/spring2016/CourseDescription/description.html)) that helped me learn the skills of Data Intensive Computing and solve real life problems using that.


License
-------
Copyright {2016} 
{Ramanpreet Singh Khinda rkhinda@buffalo.edu} 

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
