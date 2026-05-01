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

### 🔹 Year-over-Year Disaster Trend (Advanced)

```sql
SELECT 
    year,
    COUNT(*) AS total_events,
    LAG(COUNT(*)) OVER (ORDER BY year) AS prev_year,
    COUNT(*) - LAG(COUNT(*)) OVER (ORDER BY year) AS yoy_change
FROM disasters
GROUP BY year
ORDER BY year;
```

**Insight:**
Tracks changes in disaster frequency over time, identifying growth patterns and anomalies.

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

* Identification of high-risk disaster types
* Understanding of global and regional impact
* Trend analysis over time
* Data-driven insights for visualization

---
