# 🚀 Introduction  
Being a **Data Analyst** is more than just having technical skills — it’s about developing **business acumen**, improving **project management**, and continuously learning and growing.  

We don’t analyze data just for the sake of it; we analyze to **create impact**, **drive improvement**, and **learn from insights** that can change lives.  

In this project, our goal is to help **job seekers** (like myself) identify the most valuable **skills to focus on** when pursuing a Data Analyst career. This way, they can save time and effort by learning what truly matters in today’s job market.  

📊 **Project Focus:**  
We dive into the **data analyst job market**, exploring:  
- The most **in-demand skills** for data analysts  
- The **highest-paying roles** in the industry  
- Where **high demand meets high salary**  

🧰 **Tools & Technologies Used:**  
- Visual Studio Code  
- PostgreSQL  
- Git & GitHub  
- Microsoft Excel  
- Microsoft PowerPoint (for presentation)  

🔗 Click here to view the SQL queries used in this project [Project SQL FOLDER](/project_sql/)


# 💡 Background  

Driven by the need to navigate the **data analyst job market** more effectively, this project was inspired by a desire to help job seekers understand **which skills truly matter** — saving time and effort on skills that may not add value to their career growth.  

As a young data enthusiast, I noticed a flood of online tutorials, courses, and advice on what aspiring analysts “should” learn. But I wanted to take a different approach — to analyze **real-world job data** and uncover insights based on **actual industry demand** rather than opinions.  

The dataset used for this project was sourced from **[Data Source](/csv_files/)** and contains valuable insights on:  
- 🎯 Job titles  
- 💰 Salaries  
- 🏢 Companies  
- 🌍 Locations  
- 🧠 Essential skills  

---

### 🧩 Key Questions Explored with SQL  

1. 💼 What are the **top-paying data analyst jobs**?  
2. 🧠 What **skills** are required for those top-paying roles?  
3. 📈 What are the **most in-demand skills** for data analysts?  
4. 💵 Which skills are **associated with higher salaries**?  
5. 🚀 What are the **most optimal skills to learn** to stay competitive in the job market?  

#  🧰 Tools I Used  

To dive deeply into the **Data Analyst job market**, I leveraged a combination of powerful tools that helped me extract, analyze, and visualize meaningful insights:  

1. 🧮 **SQL** – The backbone of my analysis, enabling me to query the database efficiently and uncover critical insights.  
2. 🐘 **PostgreSQL** – The chosen database management system, ideal for handling large volumes of job posting data with reliability and speed.  
3. 💻 **Visual Studio Code** – My go-to environment for managing databases, writing, and executing SQL queries seamlessly.  
4. 🌐 **Git & GitHub** – Essential for version control, collaboration, and sharing SQL scripts and analysis, ensuring smooth project tracking and transparency.  
5. 📊 **Excel Dashboard** – Used for creating clear and engaging visualizations that summarize key insights from the analysis.  

# 📊 The Analysis  

Each SQL query in this project was designed to explore specific aspects of the **Data Analyst job market**.  
Below is how I approached each key question step by step.  

---

### 💼 1. The Top-Paying Data Analyst Jobs  

To identify the **highest-paying roles**, I filtered Data Analyst positions by their **average yearly salary** and **location**, focusing primarily on **remote jobs**.  

This analysis highlights some of the best-paying opportunities available in the field.  

```sql
SELECT 
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM
    job_postings_fact
LEFT JOIN 
    company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE 
    job_title_short = 'Data Analyst' 
    AND job_location = 'Anywhere' 
    AND salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;
```
📈 Findings  

Here’s the breakdown of insights from the **Top 10 Highest-Paying Data Analyst Jobs** query:  

- 💰 **Salary Range:**  
  The top 10 Data Analyst roles have salaries ranging from **$184,000 to $650,000**, highlighting the **strong earning potential** in this field.  

- 🏢 **Diverse Employers:**  
  Companies like **SmartAsset**, **Meta**, and **AT&T** are among those offering high salaries — showing that **data analytics expertise** is valued across multiple industries.  

- 🧑‍💼 **Job Title Variety:**  
  There’s notable diversity in job titles, from **Data Analyst** to **Director of Analytics**, reflecting a wide range of **specializations and career paths** within the analytics domain.  

![Top Paying Data Analyst Jobs](project_sql\images\top_paying_data_analyst_jobs.png) 
*A bar graph visualizing the salaries for the top 10 salaries for data analysts*

### 💡 2. Skills for Top-Paying Data Analyst Jobs 🚀

To understand **which skills are most valued in high-paying roles**, I joined the top-paying job postings with the skills dataset.  
This analysis highlights the **key skills employers expect** from data analysts in top-paying positions.  

By reviewing these skills, aspiring data analysts can **focus on the areas that matter most** to boost their earning potential.  

```sql
WITH highest_paying_jobs AS (
    SELECT 
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM
        job_postings_fact
    LEFT JOIN company_dim 
        ON job_postings_fact.company_id = company_dim.company_id
    WHERE 
        job_title_short = 'Data Analyst' 
        AND job_location = 'Anywhere' 
        AND salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)
SELECT  
    highest_paying_jobs.*,
    skills
FROM 
    highest_paying_jobs 
INNER JOIN skills_job_dim 
    ON highest_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim 
    ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY 
    salary_year_avg DESC;
```
### 📈 Findings  

Here’s the breakdown of insights from the **Skills for Top 10 Highest-Paying Data Analyst Jobs** query:  

- 🥇 **Top Skill:**  
  **SQL** is the most in-demand skill, appearing across nearly all top-paying roles.  

- 🐍 **Programming Importance:**  
  **Python** follows closely, showing its critical role in high-paying data analyst positions.  

- 📊 **Visualization Tools:**  
  **Tableau** is highly sought after, appearing in **6 of the top 10 jobs**, emphasizing the need for strong data visualization skills.  

- 📚 **Other Valuable Skills:**  
  Skills like **R**, **Snowflake**, **Pandas**, and **Excel** show varying degrees of demand, highlighting additional areas for skill development.  

![Top Skills requried](project_sql\images\Top_skills_req.png)
*A bar graph visualizing the top skills required for data analysts*


### 💡 3. In-Demand Skills for Data Analysts 🚀

To provide insights into the **most valuable skills for job seekers**, this query identifies the skills most frequently requested in **Data Analyst job postings**, especially for **remote roles**.  

By understanding these in-demand skills, candidates can focus on **areas with high market demand** to improve their employability.  

```sql
SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS demand_skills_count
FROM 
    job_postings_fact
INNER JOIN skills_job_dim 
    ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim 
    ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE   
    job_title_short = 'Data Analyst' 
    AND job_work_from_home = TRUE
GROUP BY
    skills
ORDER BY
    demand_skills_count DESC
LIMIT 5;
```
### 📈 Findings  

Here’s the breakdown of the **most demanded skills for Data Analysts**, based on remote job postings:  

- 🥇 **Foundational Skills:**  
  **SQL** and **Excel** remain fundamental, emphasizing the need for a strong foundation in **data processing** and **spreadsheet manipulation**.  

- 🐍 **Technical & Visualization Skills:**  
  Programming and visualization tools like **Python**, **Tableau**, and **Power BI** are essential, highlighting the increasing importance of **technical expertise** for **data storytelling** and **decision support**.  

  ![Demand Skills Count](project_sql\images\demand_skills_count.png)
*A pie chart  visualizing the most demand skills required for data analysts*

### 💡 4. Skills Based on Salary 🚀

To understand the **financial value of different skills**, this query explores how **average salaries vary by skill** for remote Data Analyst roles.  
It highlights which skills are associated with **higher-paying positions**, helping job seekers identify the **most financially rewarding skills to acquire or improve**.  

```sql
SELECT 
    skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM 
    job_postings_fact
INNER JOIN skills_job_dim 
    ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim 
    ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE   
    job_title_short = 'Data Analyst' 
    AND salary_year_avg IS NOT NULL 
    AND job_work_from_home = TRUE
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 25;
```
### 📈 Findings  

Here’s the breakdown of the **top-paying skills for Data Analysts**:  

- ⚡ **High Demand for Big Data & ML Skills:**  
  Analysts with expertise in **big data, machine learning, and Python libraries** command top salaries, reflecting the industry’s high valuation of **data processing and predictive modeling capabilities**.  

- 💻 **Software Development & Deployment Proficiency:**  
  Knowledge of **development and deployment tools** indicates a lucrative crossover between **data analysis and engineering**, with a premium on skills that enable **automation and efficient data pipeline management**.  

- ☁️ **Cloud Computing Expertise:**  
  Familiarity with **cloud platforms and data engineering tools** underscores the growing importance of **cloud-based analytics environments**, suggesting that cloud proficiency **significantly boosts earning potential** for data analysts.  

 ![Top Skills based on Salary](project_sql\images\Skills_based_onSalary.png)
*A Bar chart  visualizing the most top skills based on high salary required for data analysts*

### 💡 5. Most Optimal Skills to Learn 🚀

This analysis identifies **skills that offer both job security and financial benefits**.  
By combining insights from **demand and salary data**, we pinpoint skills that are **highly sought-after and well-compensated**, providing a strategic focus for career development in data analysis.  

```sql
SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM 
    job_postings_fact
INNER JOIN skills_job_dim 
    ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim 
    ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = TRUE
GROUP BY
    skills_dim.skill_id
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;
```
### 📈 Findings  

Here’s the breakdown of the **most optimal skills for Data Analysts** — combining both demand and salary insights:  

- 🐍 **High-Demand Programming Languages:**  
  **Python** and **R** stand out for their high demand, with demand counts of **236** and **148**, respectively.  
  Despite their popularity, their average salaries — around **$101,397 for Python** and **$100,499 for R** — suggest these skills are **highly valued but also widely available**.  

- ☁️ **Cloud Tools and Technologies:**  
  Skills in specialized cloud technologies such as **Snowflake**, **Azure**, **AWS**, and **BigQuery** show **strong earning potential** and are increasingly vital in modern data analysis.  

- 📊 **Business Intelligence & Visualization Tools:**  
  **Tableau** and **Looker**, with demand counts of **230** and **49**, and average salaries of **$99,288** and **$103,795**, highlight the critical role of **data visualization and business intelligence** in transforming raw data into actionable insights.  

- 🗄️ **Database Technologies:**  
  Strong demand for both **traditional and NoSQL databases** (such as **Oracle**, **SQL Server**, and **NoSQL**) — with average salaries ranging from **$97,786 to $104,534** — underscores the **enduring importance of data storage, retrieval, and management expertise**.  

# What I Learned
# Conclusions 