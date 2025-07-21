
-- Electric Vehicle Registrations Analysis Queries

-- Q1: Total number of vehicles registered each year
SELECT Year, SUM(TOTAL_REGISTERATION_COUNT) AS Total_registrations
FROM ALL_STATE_VEHICLE_MODEL_REGISTRATION_COUNTS_PER_YEAR
GROUP BY Year
ORDER BY Year;

-- Q2: List all distinct vehicle makes
SELECT DISTINCT vehicle_make
FROM ALL_STATES_EV_REGISTRATION;

-- Q3: Count the number of vehicles per state
SELECT state, COUNT(*) AS vehicle_count
FROM ALL_STATES_EV_REGISTRATION
GROUP BY state
ORDER BY vehicle_count;

-- Q4: Number of vehicles registered after a specific date ('2024-01-01')
SELECT DMV_SNAPSHOT_DATE, COUNT(*) AS Total_registrations
FROM ALL_STATES_EV_REGISTRATION
WHERE DMV_SNAPSHOT_DATE = '2024-01-01'
GROUP BY DMV_SNAPSHOT_DATE;

-- Q5: Top 5 most common vehicle makes (basic)
SELECT vehicle_make, COUNT(*) AS vehicle_count
FROM ALL_STATES_EV_REGISTRATION
GROUP BY vehicle_make
ORDER BY vehicle_count DESC
LIMIT 5;

-- Q5 (Advanced): Top 5 most common vehicle makes using RANK
WITH RANKING AS (
    SELECT VEHICLE_MAKE,
           COUNT(*) AS VEHICLE_COUNT,
           DENSE_RANK() OVER (ORDER BY COUNT(*) DESC) AS rnk
    FROM ALL_STATES_EV_REGISTRATION
    GROUP BY VEHICLE_MAKE
)
SELECT VEHICLE_MAKE, VEHICLE_COUNT
FROM RANKING
WHERE rnk <= 5;

-- Q6: Number of vehicles per drivetrain type per state
SELECT DRIVETRAIN_TYPE, STATE, COUNT(*) AS vehicle_count
FROM ALL_STATES_EV_REGISTRATION
GROUP BY DRIVETRAIN_TYPE, STATE
ORDER BY DRIVETRAIN_TYPE;

-- Q7: Vehicles with missing or null model names
SELECT *
FROM ALL_STATES_EV_REGISTRATION
WHERE vehicle_model IS NULL OR vehicle_model = '';

-- Q8: Latest DMV snapshot date for each state
SELECT state, MAX(DMV_SNAPSHOT_DATE) AS latest_date
FROM ALL_STATES_EV_REGISTRATION
GROUP BY state;

-- Q9: Percentage of each vehicle category within each state (basic)
SELECT state, vehicle_category,
       COUNT(*) * 100 / SUM(COUNT(*)) OVER (PARTITION BY state) AS vehicle_percentage
FROM ALL_STATES_EV_REGISTRATION
GROUP BY state, vehicle_category
ORDER BY state;

-- Q9 (Advanced): Using CTEs
WITH state_count AS (
    SELECT state, vehicle_category, COUNT(vehicle_category) AS vehicle_category_count
    FROM ALL_STATES_EV_REGISTRATION
    GROUP BY state, vehicle_category
),
total_count AS (
    SELECT *, SUM(vehicle_category_count) OVER (PARTITION BY state) AS total_vehicle_category
    FROM state_count
)
SELECT sc.state, sc.vehicle_category,
       (sc.vehicle_category_count / tc.total_vehicle_category) * 100 AS vehicles_pct
FROM state_count sc
JOIN total_count tc ON sc.state = tc.state AND sc.vehicle_category = tc.vehicle_category
ORDER BY sc.state;

-- Q10: Distribution of vehicle categories (Light, Medium, Heavy)
SELECT vehicle_category, COUNT(*) AS vehicle_count
FROM ALL_STATES_EV_REGISTRATION
GROUP BY vehicle_category
ORDER BY vehicle_count DESC;

-- Q11: Trend of vehicle registrations over time using DMV snapshot dates
SELECT DMV_SNAPSHOT_DATE, COUNT(*) AS Registration_count
FROM ALL_STATES_EV_REGISTRATION
GROUP BY DMV_SNAPSHOT_DATE
ORDER BY Registration_count DESC;

-- Q12: Vehicles whose registration is expiring within the next 30 days
SELECT *
FROM ALL_STATES_EV_REGISTRATION
WHERE registration_valid_date BETWEEN CURRENT_DATE AND DATEADD(day, 30, CURRENT_DATE);

-- Q13: Rank vehicle models by popularity within each state
SELECT state, vehicle_model, COUNT(*) AS registration_count,
       RANK() OVER (PARTITION BY state ORDER BY COUNT(*) DESC) AS rnk
FROM ALL_STATES_EV_REGISTRATION
GROUP BY state, vehicle_model;

-- Q14: Vehicles with missing or null drivetrain types
SELECT *
FROM ALL_STATES_EV_REGISTRATION
WHERE drivetrain_type IS NULL OR drivetrain_type = '';

-- Q15: States where light vehicles are more common than heavy vehicles (using CTE)
WITH heavy_count AS (
    SELECT state, COUNT(*) AS heavy_count
    FROM ALL_STATES_EV_REGISTRATION
    WHERE vehicle_category = 'Heavy-Duty Vehicle (Class 7-8)'
    GROUP BY state
),
light_count AS (
    SELECT state, COUNT(*) AS light_count
    FROM ALL_STATES_EV_REGISTRATION
    WHERE vehicle_category = 'Light-Duty (Class 1-2A)'
    GROUP BY state
)
SELECT h.state
FROM heavy_count h
JOIN light_count l ON h.state = l.state
WHERE l.light_count > h.heavy_count;

-- Q15 (Alternative): Using CASE statement
SELECT state,
       COUNT(CASE WHEN vehicle_category = 'Heavy-Duty Vehicle (Class 7-8)' THEN 1 END) AS heavy_vehicle_count,
       COUNT(CASE WHEN vehicle_category = 'Light-Duty (Class 1-2A)' THEN 1 END) AS light_vehicle_count
FROM ALL_STATES_EV_REGISTRATION
GROUP BY state
HAVING COUNT(CASE WHEN vehicle_category = 'Heavy-Duty Vehicle (Class 7-8)' THEN 1 END) <
       COUNT(CASE WHEN vehicle_category = 'Light-Duty (Class 1-2A)' THEN 1 END);

-- Q16: EVs with registrations valid beyond a certain date (e.g., '2025-01-01')
SELECT COUNT(*)
FROM ALL_STATES_EV_REGISTRATION
WHERE registration_valid_date > '2025-01-01';
