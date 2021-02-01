#IS 362 GABRIEL SANTOS 02/05/2021

USE flights;

#1
# How many airplanes have listed speeds? What is the minimum listed speed and the maximum listed speed?

SELECT COUNT(speed), MIN(speed), MAX(speed) FROM planes
WHERE speed IS NOT NULL;

#2
# What is the total distance flown by all of the planes in January 2013? 

SELECT SUM(distance) FROM flights
WHERE year = 2013 and month = 1;

# What is the total distance flown by all of the planes in January 2013 where the tailnum is missing?

SELECT SUM(distance) FROM flights
WHERE year = 2013 and month = 1 and NULLIF(tailnum, '') IS NULL;

#3
#What is the total distance flown for all planes on July 5,2013 grouped by aircraft manufacturer? Write this
# statement first using an INNER JOIN, then using a LEFT OUTER JOIN. How do your results compare?

SELECT p.manufacturer, SUM(f.distance) FROM flights f
INNER JOIN planes p on p.tailnum = f.tailnum
WHERE f.year = 2013 AND f.month = 7 AND f.day = 5
GROUP BY p.manufacturer;

#Using a LEFT OUTER JOIN

SELECT p.manufacturer, SUM(f.distance) FROM flights f
LEFT OUTER JOIN planes p on p.tailnum = f.tailnum
WHERE f.year = 2013 and f.month = 7 AND f.day = 5
GROUP BY p.manufacturer;

#The results are similar, however, using the LEFT OUTER JOIN shows flights that did'nt have a manufacturerdisplayin manufacturer NULL/blank.

#4
# Write and answer at least one question of your own choosing that joins information from at least three of the tables in the flights database.
# Displays the average arrival delays grouped by manufactures on days with high wind speeds (One standard deviation above average wind speed)

SELECT p.manufacturer, avg(f.arr_delay) FROM flights f
INNER JOIN planes p on p.tailnum = f.tailnum
INNER JOIN weather w on w.year = f.year AND w.month = f.month AND w.day = f.day
WHERE w.wind_speed > 21.66
GROUP BY p.manufacturer
ORDER BY avg(f.arr_delay);


#Part 2. Comparing Performance in Tableau. Your task is to use Tableau to compare flight performance within a category for 2013.alter

SELECT AVG(dep_delay) AS 'Average Departure Delay', origin AS 'Airport Name'
FROM flights
WHERE year = 2013 
AND origin = 'LGA' 
OR origin = 'JFK' 
OR origin = 'EWR'
GROUP BY origin;

#Then export the result in CSV file and import it into tableau.


