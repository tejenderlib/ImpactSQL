## 📊 SQL Analysis

This project uses structured SQL queries to extract meaningful insights from global disaster data.
Below are key analytical queries used during the analysis phase:

---

### 🔹 Deadliest Disaster Types

```sql
SELECT 
    disaster_type,
    SUM(total_deaths) AS total_deaths
FROM disasters
GROUP BY disaster_type
ORDER BY total_deaths DESC
LIMIT 10;
```

---
### 🔹 Contribution of Each Country to Global Deaths

```sql
SELECT 
    country,
    SUM(total_deaths) AS deaths,
    ROUND(
        SUM(total_deaths) * 100.0 / 
        SUM(SUM(total_deaths)) OVER (), 
        2
    ) AS global_share_pct
FROM disasters
GROUP BY country
ORDER BY global_share_pct DESC;
```


---

### 🔹 Economic Damage by Country

```sql
SELECT 
    country,
    SUM(total_damage_usd) AS total_damage
FROM disasters
GROUP BY country
ORDER BY total_damage DESC
LIMIT 10;
```


---

### 🔹 Yearly Trend of Disaster Deaths

```sql
SELECT 
    year,
    SUM(total_deaths) AS total_deaths
FROM disasters
GROUP BY year
ORDER BY year;
```


---

### 🔹 Disaster Frequency by Type

```sql
SELECT 
    disaster_type,
    COUNT(*) AS total_events
FROM disasters
GROUP BY disaster_type
ORDER BY total_events DESC;
```


---

### 🔹 Average Economic Damage by Disaster Type

```sql
SELECT 
    disaster_type,
    AVG(total_damage_usd) AS avg_damage
FROM disasters
WHERE total_damage_usd IS NOT NULL
GROUP BY disaster_type
ORDER BY avg_damage DESC;
```


---

### 🔹 Most Severe Disaster Events

```sql
SELECT 
    country,
    year,
    disaster_type,
    total_deaths,
    total_affected,
    total_damage_usd
FROM disasters
ORDER BY total_deaths DESC
LIMIT 5;
```


---

### 🔹 Region-wise Impact Analysis

```sql
SELECT 
    region,
    SUM(total_deaths) AS total_deaths,
    SUM(total_affected) AS total_affected
FROM disasters
GROUP BY region
ORDER BY total_deaths DESC;
```


---

### 🔹 Disaster Severity Ratio (Deaths vs Affected)

```sql
SELECT 
    disaster_type,
    SUM(total_deaths) / SUM(total_affected) AS death_ratio
FROM disasters
WHERE total_affected > 0
GROUP BY disaster_type
ORDER BY death_ratio DESC;
```


## 🧠 Summary

These queries form the analytical backbone of the project, enabling:

* Identification of high-risk disaster types
* Understanding of global and regional impact
* Trend analysis over time
* Data-driven insights for visualization

