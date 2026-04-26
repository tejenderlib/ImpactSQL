-- Show all disasters that happened after 2015
SELECT * FROM disasters;
SELECT COUNT(*) FROM disasters
WHERE start_year = 2015;

-- Show top 10 disasters with highest deaths
SELECT disaster_type, total_deaths FROM disasters
ORDER BY total_deaths DESC
LIMIT 10;

-- Count how many disasters happened between 2000 and 2010
SELECT 
	total_deaths AS total_events,
    start_year
FROM disasters
WHERE total_events BETWEEN 2008 AND 2010;