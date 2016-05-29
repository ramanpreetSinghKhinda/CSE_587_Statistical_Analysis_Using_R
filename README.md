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


<p align="center">[**We describe the problems to be solved in several parts**]



Problem 1: Data acquisition
---------------------------------------
Data collection is an important step that often is quite time consuming and constrained by regulations and privacy and security issues. The other challenge in data collection is that data comes in different formats (text, html, txt, csv, json etc.) and feature widely varying access methods (web URL, api, hdfs, sqldb etc.). 

We will learn about this by working on few representative methods for data acquisition given in the handout:
https://github.com/ramanpreet1990/CSE_587_Statistical_Analysis_Using_R/blob/master/R_Handout.pdf

**Solution**</br>
We have collected data for a period of 1 week using twitter streaming api's. The data is regarding real estate trends in New York city. Specifically the rent vs. buy trends in Manhattan, Brooklyn, Bronx and StatenIsland.

Refer below: -</br>
https://github.com/ramanpreet1990/CSE_587_Statistical_Analysis_Using_R/tree/master/Problem_1
