# Hospital Operations & Financial Performance Analysis in SQL

![MySQL](https://img.shields.io/badge/mysql-4479A1.svg?style=for-the-badge&logo=mysql&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-CC2927?style=for-the-badge&logo=data&logoColor=white)
![Data Analysis](https://img.shields.io/badge/Data%20Analysis-8A2BE2?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-Complete-brightgreen?style=for-the-badge)

## 1. Executive Summary

This project conducts a deep-dive analysis of a hospital's patient and financial data to uncover critical trends in operational efficiency, cost management, and patient care. By querying a relational database of encounters, procedures, and patient records, this analysis translates raw data into a strategic roadmap for improving the hospital's financial health and standard of care.

*   **The Problem:** The hospital faces rising operational costs, significant revenue leakage from unpaid claims, and costly patient readmissions. To address this, management needs a data-driven understanding of patient flow, cost structures, and the key drivers of financial strain.

*   **Key Findings:**
    *   **Critical Revenue Leakage:** Nearly half (**48.7%**) of all patient encounters result in **zero payer coverage**, representing a significant and immediate threat to financial stability.
    *   **High-Cost Patient Segments:** Encounters covered by **Medicaid** or with **No Insurance** are the most expensive, with average total claim costs of **$6,205** and **$5,593** respectively—far exceeding other payers.
    *   **Operational Focus on Outpatient Care:** The vast majority of encounters (**95.9%**) are short-stay (under 24 hours), confirming that the hospital's primary operational function revolves around ambulatory, outpatient, and urgent care services rather than traditional inpatient stays.
    *   **Identifiable High-Risk Patients:** A specific cohort of **773 patients** is responsible for all 30-day readmissions, with a small group of "super-utilizers" accounting for thousands of repeat visits.

*   **Business Impact:** These insights enable the hospital to launch targeted interventions that can directly improve the bottom line. This includes overhauling the billing and claims process to capture lost revenue, creating proactive case management programs to reduce costly readmissions, and optimizing resource allocation to better support the dominant outpatient model.

---

## 2. Key Business Questions & Analysis

### I. How has patient volume and the nature of care changed over time?

*   **Business Question:** "To optimize staffing and resources, we need to understand our core operational rhythm. What are the long-term trends in patient encounters, and what type of care do we primarily provide?"

*   **Key Insight:** Patient encounters have been cyclical, with significant peaks in 2014 and 2021. Operationally, the hospital is an outpatient-focused facility. Analysis shows that **over 95% of encounters last less than 24 hours**, and a review of encounter types reveals that **Ambulatory and Outpatient visits consistently constitute the majority of services rendered each year**, while inpatient care represents a small fraction (typically 3-6%).

*   **Actionable Recommendation:**
    *   Align staffing models and resource allocation with the high-volume, short-duration nature of outpatient and ambulatory care.
    *   Conduct a follow-up analysis to investigate the root causes of the patient volume spikes in 2014 and 2021 to better prepare for future surges.

---

### II. Where are our biggest financial risks and revenue opportunities?

*   **Business Question:** "Our margins are shrinking. We need to identify the primary sources of revenue loss and understand which services and payers have the largest financial impact."

*   **Key Insight:** The single greatest financial risk is claim denial or lack of coverage, with **48.7% of all encounters generating $0 in payer coverage**. Furthermore, **Medicaid** and **No Insurance** patient encounters are the most costly, averaging over $5,500 per claim. Analysis of procedures reveals a disconnect between frequency and cost; common procedures like "Depression screening" have a low base cost (~$431), while high-cost procedures like "Admit to ICU" (~$206k) are rare.

*   **Actionable Recommendation:**
    *   **Immediate Priority:** Form a task force to investigate the 48.7% zero-coverage rate. This team should audit billing codes, the patient registration process, and pre-authorization procedures to reclaim lost revenue.
    *   Develop financial counseling and assistance programs for uninsured patients *before* services are rendered to mitigate bad debt.

---

### III. How can we reduce costly readmissions and improve patient outcomes?

*   **Business Question:** "Patient readmissions are a major penalty and indicator of care quality. Who is being readmitted, and how can we intervene effectively?"

*   **Key Insight:** A focused group of **773 unique patients** accounts for 100% of 30-day readmissions. The problem is further concentrated among a handful of "super-utilizers." For example, the top patient was readmitted **1,380 times**. This pattern demonstrates that readmissions are not a hospital-wide issue, but one driven by a specific, high-risk patient population.

*   **Actionable Recommendation:**
    *   Launch a **Proactive Case Management Program** for the identified 773 high-risk patients.
    *   Assign dedicated care coordinators to the top 10 "super-utilizers" to manage their post-discharge care, medication adherence, and follow-up appointments, thereby breaking the cycle of readmission.

---

## 3. Methodology & Database Schema

*   **Methodology:** The analysis was conducted using SQL to query a relational database. The process involved joining data from multiple tables, aggregating results by different dimensions (time, patient, payer), and calculating key performance indicators such as percentages, averages, and readmission rates using window functions.

*   **Database Schema:** The database is comprised of four core tables: `patients` (demographic data), `payers` (insurance provider details), `encounters` (the central fact table linking all events), and `procedures` (specific medical services). The `encounters` table connects a patient to a specific visit, a payer, and its associated costs, serving as the hub for all analytical queries.

---

## 4. Limitations & Future Work

*   **Limitations:**
    *   **No Provider Data:** The dataset lacks information on attending physicians or surgeons, making it impossible to analyze performance or costs by individual provider.
    *   **No Clinical Outcomes:** The data captures encounters and procedures but does not include clinical outcomes (e.g., patient condition improved, infection rates), limiting the ability to assess quality of care directly.
    *   **Geographic Granularity:** While patient addresses are available, the queries do not perform a deep-dive analysis into geographic health trends or service gaps.

*   **Future Work:**
    *   **Provider Efficiency Analysis:** Integrate provider data to analyze cost and procedure variation among physicians for the same diagnosis.
    *   **Predictive Readmission Model:** Build a machine learning model using patient demographics and encounter history to predict the likelihood of a 30-day readmission upon discharge.
    *   **Geospatial Health Mapping:** Analyze patient addresses to map disease prevalence and identify underserved communities, informing decisions on where to open new clinics or allocate community health resources.

---

## 5. Technical Appendix

*   **Tools:** SQL (MySQL)

*   **Database Setup & Replication:**
    To replicate this analysis, follow these steps:
    1.  Create a new MySQL database named `hospital_db`.
    2.  Ensure the `local_infile` system variable is enabled in your MySQL server configuration (`SET GLOBAL local_infile = 1;`). This is required for loading data from local CSV files.
    3.  Execute the `CREATE TABLE` statements from the provided `hospital_analysis.sql` script to create the `patients`, `payers`, `encounters`, and `procedures` tables.
    4.  Update the `LOAD DATA LOCAL INFILE` file paths in the script to match the location of the CSV files on your local machine.
    5.  Execute the `LOAD DATA` statements to populate the tables.
    6.  Run the analytical queries from the script to generate the results.
    
---

## 📬 Contact
**Selim Najaf**

*   **LinkedIn:** [linkedin.com/in/selimnajaf-data-analyst](https://www.linkedin.com/in/selimnajaf-data-analyst/)
*   **GitHub:** [github.com/SelimNajaf](https://github.com/SelimNajaf)
