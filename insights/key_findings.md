## 📊 SQL Analysis

This project uses structured SQL queries to extract meaningful insights from global disaster data.
Below are key analytical queries along with their relevance to the dashboard.

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

**Insight:**
Identifies the most fatal disaster categories globally, with earthquakes leading in total deaths.

---

### 🔹 Anomaly Detection in Disaster Deaths (Z-Score)

```sql
WITH yearly AS (
    SELECT 
        year,
        SUM(total_deaths) AS deaths
    FROM disasters
    GROUP BY year
),
stats AS (
    SELECT 
        AVG(deaths) AS avg_deaths,
        STDDEV(deaths) AS std_dev
    FROM yearly
)
SELECT 
    y.year,
    y.deaths,
    ROUND((y.deaths - s.avg_deaths) / s.std_dev, 2) AS z_score
FROM yearly y, stats s
ORDER BY z_score DESC;
```

**Insight:**
This query identifies **abnormal disaster years** where fatalities significantly deviate from the average.
Years with high positive z-scores represent **extreme global disaster events** and can be linked to major historical incidents.

---

---

### 🔹 Pareto Analysis (80/20 Rule for Countries)

```sql
WITH country_deaths AS (
    SELECT 
        country,
        SUM(total_deaths) AS deaths
    FROM disasters
    GROUP BY country
),
ranked AS (
    SELECT 
        country,
        deaths,
        SUM(deaths) OVER (ORDER BY deaths DESC) AS cumulative_deaths,
        SUM(deaths) OVER () AS total_deaths
    FROM country_deaths
)
SELECT 
    country,
    deaths,
    ROUND(cumulative_deaths * 100.0 / total_deaths, 2) AS cumulative_pct
FROM ranked
ORDER BY deaths DESC;
```

**Insight:**
This analysis reveals that a **small number of countries contribute a large percentage of total global deaths**, confirming a Pareto distribution.
It highlights regions where disaster impact is disproportionately concentrated.

---

### 🔹 3. Most Dangerous Disaster Type per Country

```sql
SELECT *
FROM (
    SELECT 
        country,
        disaster_type,
        SUM(total_deaths) AS total_deaths,
        RANK() OVER (
            PARTITION BY country 
            ORDER BY SUM(total_deaths) DESC
        ) AS rank_in_country
    FROM disasters
    GROUP BY country, disaster_type
) ranked
WHERE rank_in_country = 1;
```

**Insight:**
This query identifies the **most lethal disaster type for each country**, enabling region-specific risk analysis.
It shows that different countries face different dominant disaster threats based on geography and climate.

---

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

**Insight:**
Calculates each country’s percentage contribution to global disaster deaths, highlighting high-impact regions.

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

**Insight:**
Shows which countries experience the highest economic losses due to disasters.

---

### 🔹 Detect Repeated High-Risk Countries

```sql
SELECT 
    country,
    COUNT(*) AS high_impact_events
FROM disasters
WHERE total_deaths > 1000
GROUP BY country
ORDER BY high_impact_events DESC;
```

**Insight:**
Identifies countries that frequently experience high-impact disasters.

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

**Insight:**
Highlights the most frequently occurring disaster types globally.

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

**Insight:**
Identifies disaster types that cause the highest financial damage per event.

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

**Insight:**
Highlights extreme disaster events with the highest human impact.

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

**Insight:**
Compares disaster impact across global regions.

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

**Insight:**
Measures how deadly disasters are relative to the number of people affected.

---

## 🔗 SQL ↔ Dashboard Alignment

Each dashboard visualization is directly backed by SQL logic:

| Dashboard Component    | SQL Purpose                    |
| ---------------------- | ------------------------------ |
| 📊 Year Trend Chart    | Aggregates deaths per year     |
| 🥧 Disaster Type Chart | Distribution of deaths by type |
| 📋 Top Countries Table | Economic damage ranking        |
| ⚡ High-Risk Countries  | Repeated severe events         |
| 📈 Frequency Chart     | Disaster occurrence patterns   |

---

## 🧠 Summary

These queries form the analytical backbone of the project, enabling:

- Identification of high-impact disaster types and vulnerable regions  
- Quantification of global and regional disaster impact  
- Detection of temporal trends and anomaly patterns  
- Derivation of data-driven insights to support visualization and decision-making

---
