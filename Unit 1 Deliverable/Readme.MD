##Air Traffic Project - Part 1 - Data Analysis in SQL

You work for the BrainStation Mutual Fund and the fund managers wish to invest in one of three major airline stocks. Your goal is to provide answers to specific business questions (see below) using the provided flight and airport data. Along with concise and clear explanations of your results, use your findings to provide the fund managers with valuable, data-derived insights.

In addition to wanting to gain actionable business insights, the fund managers also want to secretly test your skill working with SQL databases. Be sure not to disappoint on either objective!

Data Description

The database contains two tables, flights and airports. The flights table contains flight data for 2018 and 2019 from the three most traveled airlines. The airports table contains data for all origin and destination airports, including full name and location. 


Question 1
The managers of the BrainStation Mutual Fund want to know some basic details about the data. Use fully commented SQL queries to address each of the following questions:

How many flights were there in 2018 and 2019 separately?

In total, how many flights were cancelled or departed late over both years?

Show the number of flights that were cancelled broken down by the reason for cancellation.

For each month in 2019, report both the total number of flights and percentage of flights cancelled. Based on your results, what might you say about the cyclic nature of airline revenue?

Question 2
Create two new tables, one for each year (2018 and 2019) showing the total miles traveled and number of flights broken down by airline.

Using your new tables, find the year-over-year percent change in total flights and miles traveled for each airline.

Use fully commented SQL queries to address the questions above. What investment guidance would you give to the fund managers based on your results?

Question 3
Another critical piece of information is what airports the three airlines utilize most commonly.

What are the names of the 10 most popular destination airports overall? For this question, generate a SQL query that first joins flights and airports then does the necessary aggregation.

Answer the same question but using a subquery to aggregate & limit the flight data before your join with the airport information, hence optimizing your query runtime.

If done correctly, the results of these two queries are the same, but their runtime is not. In your SQL script, comment on the runtime: which is faster and why?

Question 4
The fund managers are interested in operating costs for each airline. We don't have actual cost or revenue information available, but we may be able to infer a general overview of how each airline's costs compare by looking at data that reflects equipment and fuel costs.

A flight's tail number is the actual number affixed to the fuselage of an aircraft, much like a car license plate. As such, each plane has a unique tail number and the number of unique tail numbers for each airline should approximate how many planes the airline operates in total. Using this information, determine the number of unique aircrafts each airline operated in total over 2018-2019.

Similarly, the total miles traveled by each airline gives an idea of total fuel costs and the distance traveled per plane gives an approximation of total equipment costs. What is the average distance traveled per aircraft for each of the three airlines?

As before, use fully commented SQL queries to address the questions. Compare the three airlines with respect to your findings: how do these results impact your estimates of each airline's finances?

Question 5:
Finally, the fund managers would like you to investigate the three airlines and major airports in terms of on-time performance as well. For each of the following questions, consider early departures and arrivals (negative values) as on-time (0 delay) in your calculations.

Next, we will look into on-time performance more granularly in relation to the time of departure. We can break up the departure times into three categories as follows:

CASE
    WHEN HOUR(CRSDepTime) BETWEEN 7 AND 11 THEN "1-morning"
    WHEN HOUR(CRSDepTime) BETWEEN 12 AND 16 THEN "2-afternoon"
    WHEN HOUR(CRSDepTime) BETWEEN 17 AND 21 THEN "3-evening"
    ELSE "4-night"
END AS "time_of_day"

Find the average departure delay for each time-of-day across the whole data set. Can you explain the pattern you see?

Now, find the average departure delay for each airport and time-of-day combination.

Next, limit your average departure delay analysis to morning delays and airports with at least 10,000 flights.

By extending the query from the previous question, name the top-10 airports (with >10000 flights) with the highest average morning delay. In what cities are these airports located?

##Air Traffic Project - Part 2 - Visual Analytics in Tableau

In the first deliverable for this unit you explored using SQL queries to generate insights from a real-world dataset stored in a relational database. For this deliverable, you will create data visualizations using Tableau, allowing the user to interactively derive business insights from the same dataset without having to write code.

The work you started for BrainStation Mutual Fund will be continued here, working with the same Air Traffic data set. Your goal will be to address each question below with an appropriate visual or dashboard in Tableau and provide quantitative comments and actionable insights based on your findings. Finally, your charts will be organized into a Tableau Story to deliver your insights as a professional presentation using a consistent narrative.

Question 1:
Create visualizations to address the questions and add descriptive titles, subtitles, captions, and/or annotations for highlighting your insights.

1.1 How do the three carriers compare in terms of total number of flights between 2018 and 2019?

1.2 How do the monthly number of flights vary over time for each of the three carriers?

1.3 What are the top 10 most highly utilized origin airports for the three carriers and how are the number of flights from these airports distributed between these carriers? Build a stacked bar chart to answer this question and describe the key patterns, similarities, and differences in how each carrier's flights are distributed at each of the 10 airports.

Question 2:
We will investigate on-time performance next in terms of departure delays and cancellations.

2.1 Create a calculated field that identifies on-time vs delayed departures: consider negative or missing delay times as on-time. Then, create a visualization that contrasts the number of on-time vs delayed flights broken down by month for the year 2019. Which month has the highest/lowest total number of delayed flights?

2.2 Create a highlight table (crosstab) that shows the average departure delay for each state broken down by year and fiscal quarter. Use the calculated field from the previous question to include only those flights that are delayed. What states have the highest departure delay for flights and when? Describe your insights and do some research why these delays could have occurred. Indicate which 3 states have the highest average delays in Q1 of 2019.

2.3 Next, generate a map of the US states which shows the average departure delay by state. Using this map and the tabulation from Q2.2, comment on notable trends or patterns observed in departure delays versus state.

2.4 How do the reasons reported for flight cancellation vary by month? Visualize the total number of cancelled flights for each month in both years broken down by the reason for cancellation. What trends do you notice about the flights cancelled?

Use descriptive titles, subtitles, captions, and/or annotations for describing your findings.

Question 3:
Next, we will analyze the fleet and distance traveled by each airline which can provide an indication of their revenue.

3.1 How are flight times and distances related to one another? Create a scatter plot of average flight time vs average distance traveled on the airport level. What is the approximate range of flight times in which most flights in this dataset tend to lie? Include a trend line and comment on what this represents. Are there any outliers?

3.2 How do the three carriers compare year-over-year in terms of total distance flown and total number of planes in service? Use the "Year over year growth" quick table calculation to visualize the percent change in total distance flown and total unique tail numbers in 2019 vs 2018 (Hint: the COUNTD() function will return the number of distinct elements). Describe the differences between the three carriers.

3.3 Create a calculated field to show the average distance traveled per plane using the SUM() and COUNTD() functions. How do carriers compare in this respect? Visualize the average broken down by airline. Now, imagine we want to start thinking about carrier profits, even though we have no data on costs or revenue. Which airline do you believe is the most efficient in terms of costs per mile flown and why?

Make sure your plots have descriptive titles and utilize captions and/or annotations for highlights.

Question 4:
Finally, the fund managers would like an interactive dashboard to explore the data further about departure delays and cancellations state-by-state. Your goal is to use Q2.3, Q2.4 and to create one extra visual of your choice for the dashboard (you can, for example, look into the cancellation rates). Make sure you enable some interactive capabilities to filter the data in order to dig into the details.

