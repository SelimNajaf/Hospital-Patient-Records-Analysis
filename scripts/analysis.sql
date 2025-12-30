/* ==========================================================================
   ANALYTICAL QUERIES
   ========================================================================== */

-- --------------------------------------------------------------------------
-- OBJECTIVE 1: ENCOUNTERS OVERVIEW
-- --------------------------------------------------------------------------

-- a. Total encounters per year
SELECT 
    YEAR(START) AS year, 
    COUNT(Id) AS total_encounters
FROM encounters
GROUP BY year
ORDER BY year;


-- b. Percentage of encounter class per year
SELECT 
    year,
    ecc,
    ROUND(cnt * 100 / SUM(cnt) OVER(PARTITION BY year), 2) AS percent
FROM (
    SELECT 
        YEAR(START) AS year,
        ENCOUNTERCLASS AS ecc,
        COUNT(Id) As cnt
    FROM encounters
    GROUP BY year, ecc
) t
ORDER BY year, ecc;


-- c. Encounters duration split (Over/Under 24 hours)
SELECT 
    ROUND(low / total * 100, 2) AS lower,
    ROUND(high / total * 100, 2) AS higher
FROM (
    SELECT
        COUNT(Id) AS total,
        SUM(CASE WHEN TIMESTAMPDIFF(SECOND, START, STOP) / 3600 < 24  THEN 1 ELSE 0 END) AS low,
        SUM(CASE WHEN TIMESTAMPDIFF(SECOND, START, STOP) / 3600 >= 24 THEN 1 ELSE 0 END) AS high
    FROM encounters
) t;


-- --------------------------------------------------------------------------
-- OBJECTIVE 2: COST & COVERAGE INSIGHTS
-- --------------------------------------------------------------------------

-- a. Zero payer coverage analysis
SELECT 
    zero_count,
    ROUND(zero_count / total * 100, 2) AS percentage
FROM (
    SELECT
        SUM(CASE WHEN PAYER_COVERAGE = 0 THEN 1 ELSE 0 END) AS zero_count,
        COUNT(Id) AS total
    FROM encounters
) t;


-- b. Top 10 most frequent procedures & average cost
SELECT 
    CODE,
    DESCRIPTION,
    COUNT(PATIENT) AS count,
    ROUND(AVG(BASE_COST), 2) AS avg
FROM procedures
GROUP BY CODE, DESCRIPTION
ORDER BY 3 DESC
LIMIT 10;


-- c. Top 10 highest cost procedures & frequency
SELECT 
    CODE,
    DESCRIPTION,
    COUNT(PATIENT) AS count,
    ROUND(AVG(BASE_COST), 2) AS avg
FROM procedures
GROUP BY CODE, DESCRIPTION
ORDER BY 4 DESC
LIMIT 10;


-- d. Average total claim cost by Payer
SELECT 
    p.NAME AS payer_Name,
    COUNT(e.Id) AS total_encounters,
    ROUND(AVG(e.TOTAL_CLAIM_COST), 2) AS avg_cost
FROM encounters e
LEFT JOIN payers p 
    ON e.PAYER = p.Id
GROUP BY p.NAME
ORDER BY avg_cost DESC;


-- --------------------------------------------------------------------------
-- OBJECTIVE 3: PATIENT BEHAVIOR ANALYSIS
-- --------------------------------------------------------------------------

-- a. Unique patients admitted per quarter
SELECT 
    YEAR(START) AS year,
    QUARTER(START) AS quarter,
    COUNT(DISTINCT(PATIENT)) AS dist_count
FROM encounters
GROUP BY year, quarter
ORDER BY 1, 2;


-- b. 30-Day Readmission Analysis
WITH PatientLag AS (
    SELECT 
        PATIENT,
        STOP AS Current_Visit_End,
        LEAD(START) OVER (PARTITION BY PATIENT ORDER BY START) AS Next_Visit_Start
    FROM encounters
)
SELECT 
    COUNT(DISTINCT PATIENT) AS Readmitted_Patients
FROM PatientLag
WHERE DATEDIFF(Next_Visit_Start, Current_Visit_End) <= 30;


-- c. Top patients by readmission count
SELECT 
    p.FIRST,
    p.LAST,
    COUNT(e.Id) - 1 AS Readmission_Count 
FROM encounters e
JOIN patients p 
    ON e.PATIENT = p.Id 
GROUP BY p.Id, p.FIRST, p.LAST
HAVING COUNT(e.Id) > 1
ORDER BY Readmission_Count DESC
LIMIT 10;