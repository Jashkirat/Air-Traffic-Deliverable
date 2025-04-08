-- AIR TRAFFIC DELIVERABLE 

-- Use AirTraffic as Default Schema
use Airtraffic;

-- Question 1.1 :

-- Counting the number of flights in 2018
SELECT COUNT(*) AS Flights_In_2018
FROM flights
WHERE YEAR(FlightDate) = 2018; -- Filters flights to include only those in the year 2018

/* Flights in 2018: 3218653 
*/

-- Counting the number of flights in 2019
SELECT COUNT(*) AS FlightsIn2019
FROM flights
WHERE YEAR(FlightDate) = 2019; -- Filters flights to include only those in the year 2019

/* Flights in 2019: 3302708 
*/

/* Comparing 2019 to 2018, there was an increase of 84,055 flights, indicating a year-over-year growth in the total number of flights.
*/

-- Question 1.2 :

-- Counting flights that were either cancelled or departed late in 2018 and 2019
SELECT COUNT(*) AS Cancelled_Or_LateFlights
FROM flights
WHERE (YEAR(FlightDate) = 2018 OR YEAR(FlightDate) = 2019) -- Filters flights to include only those in 2018 and 2019
AND (Cancelled = 1 OR DepDelay > 0); -- Includes flights that were either cancelled or had a departure delay

/* Flights that were Canceled or Late : 2633237 
*/

-- Question 1.3: 

-- Grouping cancelled flights by the reason for cancellation
SELECT CancellationReason, -- Selects the reason for cancellation
       COUNT(*) AS Number_Of_Cancellations -- Counts the number of cancellations for each reason
FROM flights
WHERE Cancelled = 1 -- Filters to include only cancelled flights
GROUP BY CancellationReason; -- Groups the results by the cancellation reason

/* Flights that were canceled and the reasons: 

CancellationReason         | Number_Of_Cancellations
----------------------------|-----------------------
Weather                    | 50225
Carrier                    | 34141
National Air System        | 7962
Security                   | 35
*/

-- Question 1.4: 

-- Calculating total flights and percentage of cancellations for each month in 2019
SELECT 
    MONTH(FlightDate) AS Month, -- Extracts the month from the flight date and names the column as 'Month'
    COUNT(*) AS TotalFlights, -- Counts the total number of flights for each month and names the column as 'TotalFlights'
    SUM(CASE WHEN Cancelled = 1 THEN 1 ELSE 0 END) AS CancelledFlights, -- Sums up the number of cancelled flights for each month; if a flight is cancelled (Cancelled = 1), it counts as 1, otherwise 0. The result is named 'CancelledFlights'
    (SUM(CASE WHEN Cancelled = 1 THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS PercentageCancelled -- Calculates the percentage of cancelled flights for each month. It divides the number of cancelled flights by the total number of flights and multiplies by 100 to get a percentage. The result is named 'PercentageCancelled'
FROM flights -- Specifies the 'flights' table from which to retrieve the data
WHERE YEAR(FlightDate) = 2019 -- Filters the data to include only flights from the year 2019
GROUP BY MONTH(FlightDate); -- Groups the results by the month of the flight date

/*
Total flights and percentage of cancellations for each month in 2019

Month  Total Flights  Cancelled Flights  Percentage Cancelled
1      262,165        5,788              2.2078%
2      237,896        5,502              2.3128%
3      283,648        7,079              2.4957%
4      274,115        7,429              2.7102%
5      285,094        6,912              2.4245%
6      282,653        6,172              2.1836%
7      291,955        4,523              1.5492%
8      290,493        3,624              1.2475%
9      268,625        3,318              1.2352%
10     283,815        2,291              0.8072%
11     266,878        1,580              0.5920%
12     275,371        1,397              0.5073%

Seasonal Variability: Higher cancellation rates in winter and spring (January to May) likely due to adverse weather, impacting airline revenue negatively.

Stabilization in Late Summer and Fall: Lower cancellation rates from July to December suggest more stable operations, potentially leading to steadier revenue.

Holiday Travel: Despite lower cancellations towards year-end, the holiday season surge in travel demands efficient management for revenue maximization.
*/

-- Question 2.1: 

-- Creating a table for 2018 flights data
CREATE TABLE Flights2018 AS
SELECT 
    Reporting_Airline, -- Selects the airline code
    SUM(Distance) AS TotalMiles, -- Sums up the total miles flown by each airline
    COUNT(*) AS NumberOfFlights -- Counts the total number of flights for each airline
FROM flights
WHERE YEAR(FlightDate) = 2018 -- Filters flights to include only those in the year 2018
GROUP BY Reporting_Airline; -- Groups the results by airline

-- Creating a table for 2019 flights data
CREATE TABLE Flights2019 AS
SELECT 
    Reporting_Airline, -- Selects the airline code
    SUM(Distance) AS TotalMiles, -- Sums up the total miles flown by each airline
    COUNT(*) AS NumberOfFlights -- Counts the total number of flights for each airline
FROM flights
WHERE YEAR(FlightDate) = 2019 -- Filters flights to include only those in the year 2019
GROUP BY Reporting_Airline; -- Groups the results by airline

-- Question 2.2: 

-- Calculating year-over-year percent change in total flights and miles for each airline
SELECT 
    a.Reporting_Airline, -- Selects the airline code from the 2018 data
    a.TotalMiles AS TotalMiles2018, -- Selects the total miles flown in 2018
    b.TotalMiles AS TotalMiles2019, -- Selects the total miles flown in 2019
    ((b.TotalMiles - a.TotalMiles) / a.TotalMiles) * 100 AS PercentChangeMiles, -- Calculates the percent change in miles from 2018 to 2019
    a.NumberOfFlights AS Flights2018, -- Selects the number of flights in 2018
    b.NumberOfFlights AS Flights2019, -- Selects the number of flights in 2019
    ((b.NumberOfFlights - a.NumberOfFlights) / a.NumberOfFlights) * 100 AS PercentChangeFlights -- Calculates the percent change in flights from 2018 to 2019
FROM Flights2018 a
JOIN Flights2019 b ON a.Reporting_Airline = b.Reporting_Airline; -- Joins the 2018 and 2019 data on the airline code

/*
Airline Data:

Reporting_Airline  TotalMiles2018   TotalMiles2019   PercentChangeMiles  Flights2018  Flights2019  PercentChangeFlights
DL                 842,409,169      889,277,534      5.56%               949,283      991,986      4.50%
AA                 933,094,276      938,328,443      0.56%               916,818      946,776      3.27%
WN                 1,012,847,097    1,011,583,832    -0.12%              1,352,552    1,363,946    0.84%

Analysis:
- DL shows strong growth in both miles and flights, indicating market expansion and potential as a strong investment.
- AA demonstrates modest growth, suggesting steady growth and stability, making it a safer investment option.
- WN's slight decrease in miles but increase in flights might indicate a strategic shift towards shorter routes or operational efficiency.
*/



-- Question 3.1: 

-- Finding the top 10 most popular destination airports
SELECT 
    a.AirportName, -- Selects the name of the airport from the 'airports' table
    COUNT(*) AS NumberOfFlights -- Counts the number of flights for each airport
FROM 
    flights f
JOIN 
    airports a ON f.DestAirportID = a.AirportID -- Joins the 'flights' table with the 'airports' table on the destination airport ID
GROUP BY 
    a.AirportName -- Groups the results by airport name
ORDER BY 
    NumberOfFlights DESC -- Orders the results by the number of flights in descending order
LIMIT 10; -- Limits the results to the top 10 airports

/* The Top 10 Airports are : 
AirportName                                        NumberOfFlights
Hartsfield-Jackson Atlanta International                    595527
Dallas/Fort Worth International                             314423
Phoenix Sky Harbor International                   			253697
Los Angeles International                          			238092
Charlotte Douglas International                   		    216389
Harry Reid International                           			200121
Denver International                               			184935
Baltimore/Washington International Thurgood Marshall 		168334
Minneapolis-St Paul International                 			165367
Chicago Midway International                       			165007
*/

-- Question 3.2: 

-- Optimized query to find the top 10 destination airports using a subquery
SELECT 
    a.AirportName, -- Selects the name of the airport from the 'airports' table
    f.NumberOfFlights -- Selects the number of flights associated with each airport from the subquery 'f'
FROM 
    (SELECT 
         DestAirportID, -- Selects the destination airport ID from the 'flights' table
         COUNT(*) AS NumberOfFlights -- Counts the total number of flights for each destination airport
     FROM 
         flights -- Specifies the 'flights' table
     GROUP BY 
         DestAirportID -- Groups the results by destination airport ID
     ORDER BY 
         NumberOfFlights DESC -- Orders the results by the number of flights in descending order
     LIMIT 10) f -- Limits the results to the top 10 airports with the most flights
JOIN 
    airports a ON f.DestAirportID = a.AirportID; -- Joins the subquery 'f' with the 'airports' table on the destination airport ID

/* 
Query 1 (12.922 seconds) is slower because it joins the large flights table with the airports table before aggregating, leading to a more resource-intensive process.

Query 2 (1.919 seconds) is faster as it first aggregates and limits the data in a subquery, reducing the dataset size before joining with the airports table, resulting in a more efficient operation. 
*/


-- Question 4.1:

-- Counting unique aircraft for each airline over 2018-2019
SELECT 
    Reporting_Airline, -- Selects the airline code
    COUNT(DISTINCT Tail_Number) AS Unique_Aircraft -- Counts the distinct tail numbers (unique aircraft) for each airline
FROM 
    flights
WHERE 
    YEAR(FlightDate) IN (2018, 2019) -- Filters flights to include only those in 2018 and 2019
GROUP BY 
    Reporting_Airline; -- Groups the results by airline"
    
/*
Unique Aircraft Data by Airline:
Reporting_Airline  Unique_Aircraft
AA                 993
DL                 988
WN                 754
*/
   
-- Question 4.2:

-- Calculating average distance traveled per aircraft for each airline
SELECT 
    Reporting_Airline, -- Selects the airline code
    SUM(Distance) / COUNT(DISTINCT Tail_Number) AS Avg_Distance_Per_Aircraft -- Calculates the average distance traveled per unique aircraft
FROM 
    flights
WHERE 
    YEAR(FlightDate) IN (2018, 2019) -- Filters flights to include only those in 2018 and 2019
GROUP BY 
    Reporting_Airline; -- Groups the results by airline
    
/*
Average Distance Per Aircraft by Airline:
Reporting_Airline  Avg_Distance_Per_Aircraft
AA                 1,884,615.024
DL                 1,752,719.335
WN                 2,684,921.657
*/

/*
Analysis of Airlines Based on Average Distance Traveled Per Aircraft:

1. American Airlines (AA):
   - High average distance shows good use of aircraft.
   - Could lead to higher costs but also strong revenue per plane.

2. Delta Airlines (DL):
   - Lower average distance suggests a variety of flight lengths.
   - Indicates balanced costs and a range of routes.

3. Southwest Airlines (WN):
   - Much higher average distance indicates a focus on longer flights or very efficient use of aircraft.
   - Likely means higher earnings per plane, though fuel costs may be higher.
   
Investment Guidance. 

- AA and DL: Balanced route strategies and fleet use suggest stable and diverse revenue sources.
- WN: High average distance per aircraft indicates efficient use, appealing for higher revenue potential, but may involve greater fuel and maintenance costs.

   */

-- Question 5.1:

-- Calculating average departure delay for each time-of-day category
SELECT 
    CASE
        WHEN HOUR(CRSDepTime) BETWEEN 7 AND 11 THEN '1-morning' -- Categorizes flights between 7 and 11 as morning
        WHEN HOUR(CRSDepTime) BETWEEN 12 AND 16 THEN '2-afternoon' -- Categorizes flights between 12 and 16 as afternoon
        WHEN HOUR(CRSDepTime) BETWEEN 17 AND 21 THEN '3-evening' -- Categorizes flights between 17 and 21 as evening
        ELSE '4-night' -- Categorizes all other flights as night
    END AS time_of_day,
    AVG(CASE WHEN DepDelay < 0 THEN 0 ELSE DepDelay END) AS AvgDepartureDelay -- Calculates the average departure delay, treating early departures as 0 delay
FROM 
    flights
GROUP BY 
    time_of_day; -- Groups the results by time of day
    
/* 
- Morning (7.9055 minutes): Lower delays, likely due to less air traffic and favorable weather conditions early in the day.
- Afternoon (13.6596 minutes): Increased delays, possibly from accumulated delays and higher air traffic.
- Evening (18.3138 minutes): Highest delays, likely due to peak air traffic and the cascading effect of earlier delays.
- Night (7.7866 minutes): Delays decrease again, similar to morning, with reduced air traffic and cooler temperatures.

This pattern indicates that delays tend to increase from morning to evening and then decrease at night.
*/    

-- Question 5.2:

-- Calculating average departure delay for each airport and time-of-day combination
SELECT 
    OriginAirportID, -- Selects the origin airport ID
    time_of_day, -- Selects the time of day category
    AVG(CASE WHEN DepDelay < 0 THEN 0 ELSE DepDelay END) AS AvgDepartureDelay -- Calculates the average departure delay, treating early departures as 0 delay
FROM 
    (SELECT 
         OriginAirportID, -- Selects the origin airport ID from the 'flights' table
         CASE
             WHEN HOUR(CRSDepTime) BETWEEN 7 AND 11 THEN '1-morning' -- Categorizes flights between 7 and 11 as morning
             WHEN HOUR(CRSDepTime) BETWEEN 12 AND 16 THEN '2-afternoon' -- Categorizes flights between 12 and 16 as afternoon
             WHEN HOUR(CRSDepTime) BETWEEN 17 AND 21 THEN '3-evening' -- Categorizes flights between 17 and 21 as evening
             ELSE '4-night' -- Categorizes all other flights as night
         END AS time_of_day,
         DepDelay -- Selects the departure delay
     FROM 
         flights) AS subquery -- Creates a subquery for further processing
GROUP BY 
    OriginAirportID, 
    time_of_day; -- Groups the results by origin airport ID and time of day

-- Question 5.3:

-- Finding average morning delay for airports with more than 10,000 flights
SELECT 
    OriginAirportID, -- Selects the origin airport ID
    AVG(CASE WHEN DepDelay < 0 THEN 0 ELSE DepDelay END) AS AvgMorningDelay -- Calculates the average morning departure delay, treating early departures as 0 delay
FROM 
    flights
WHERE 
    HOUR(CRSDepTime) BETWEEN 7 AND 11 -- Filters flights to include only those in the morning (7 to 11)
GROUP BY 
    OriginAirportID -- Groups the results by origin airport ID
HAVING 
    COUNT(*) > 10000; -- Includes only airports with more than 10,000 flights

-- Question 5.4:

-- Identifying the top-10 airports with the highest average morning delay
SELECT 
    a.AirportName, -- Selects the name of the airport from the 'airports' table
    a.City, -- Selects the city of the airport
    subquery.AvgMorningDelay -- Selects the average morning delay from the subquery
FROM 
    (SELECT 
         OriginAirportID, -- Selects the origin airport ID
         AVG(CASE WHEN DepDelay < 0 THEN 0 ELSE DepDelay END) AS AvgMorningDelay -- Calculates the average morning departure delay, treating early departures as 0 delay
     FROM 
         flights
     WHERE 
         HOUR(CRSDepTime) BETWEEN 7 AND 11 -- Filters flights to include only those in the morning (7 to 11)
     GROUP BY 
         OriginAirportID -- Groups the results by origin airport ID
     HAVING 
         COUNT(*) > 10000 -- Includes only airports with more than 10,000 flights
     ORDER BY 
         AvgMorningDelay DESC -- Orders the results by average morning delay in descending order
     LIMIT 10) AS subquery -- Limits the results to the top 10 airports
JOIN 
    airports a ON subquery.OriginAirportID = a.AirportID; -- Joins the subquery with the 'airports' table on the origin airport ID

-- Top 10 Airports. 
/* 
AirportName                  City                     AvgMorningDelay
San Francisco International  San Francisco, CA         13.6068
Chicago O'Hare International Chicago, IL               11.5389
Dallas/Fort Worth International Dallas/Fort Worth, TX  11.4443
Los Angeles International    Los Angeles, CA           10.9616
Seattle/Tacoma International Seattle, WA               10.1776
Chicago Midway International Chicago, IL               10.1540
Logan International          Boston, MA                 8.9300
Raleigh-Durham International Raleigh/Durham, NC         8.7763
Denver International         Denver, CO                 8.7339
San Diego International      San Diego, CA              8.6609
*/

/*
-- Airport-Specific Performance:
1. Airports with higher delays (e.g., San Francisco International, Chicago O'Hare) can impact airline punctuality negatively.
2. Airports with lower delays (e.g., San Diego International, Denver International) are likely to enhance airline on-time performance.

-- Airline-Specific Considerations:
1. Airlines with more flights during evening peak delay times at high-delay airports may struggle more with on-time performance.
2. Airlines with flights predominantly in morning or night, or at more efficient airports, are likely to have better on-time performance.

-- Investment Oppurtunity: The on-time performance of airlines is influenced by the time of day and airport efficiency. 
Airlines that manage these aspects well could offer better investment opportunities, particularly with strategic scheduling and strong airport partnerships.
*/




