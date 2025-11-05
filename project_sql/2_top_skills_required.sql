
/* 
    Question 2: What skills are required for the top-paying data analyst jobs?
        - In this query, we will use the top 10 highest-paying Data analyst jobs from our first query, then
        - Add the specific skills required for these roles
    Why is this Important?
        - it provides a detailed look at which high-paying jobs demand certain skills,
        This will help job seekers understand which skills to develop that align with top salaries
*/

-- We will be doing two main things
-- 1.   Joining the first query with our skill table 
-- 2.   we will be using subquery or CTE because we have previously built a query

        --Making the first query into a CTE
WITH highest_paying_jobs AS (
    SELECT 
        job_id,
        job_title,
        job_location,
        job_schedule_type,
        salary_year_avg,
        job_posted_date,
        name as company_name
    FROM
        job_postings_fact
    left join company_dim on job_postings_fact.company_id = company_dim.company_id
    WHERE 
        job_title_short = 'Data Analyst' AND
        job_location ='Anywhere' AND
        salary_year_avg IS NOT NULL
ORDER BY
        salary_year_avg DESC
LIMIT 10
)
SELECT * 
FROM 
    highest_paying_jobs

/* The CTE is working perfectly,  
from our actual database itself we are going to need to connect two tables the skill_dim table and the skill_job_dim table.

But what Join method are we going to be using to join this to our Job-posting_facts table?
    -In this case we are going to be using the Inner Join    
Here we only care about the skills assocaited with a salary.
*/

WITH highest_paying_jobs AS (
    SELECT 
        job_id,
        job_title,
        job_location,
        job_schedule_type,
        salary_year_avg,
        job_posted_date,
        name as company_name
    FROM
        job_postings_fact
    left join company_dim on job_postings_fact.company_id = company_dim.company_id
    WHERE 
        job_title_short = 'Data Analyst' AND
        job_location ='Anywhere' AND
        salary_year_avg IS NOT NULL
ORDER BY
        salary_year_avg DESC
LIMIT 10
)
SELECT * 
FROM 
    highest_paying_jobs 
Inner join skills_job_dim on highest_paying_jobs.job_id = skills_job_dim.job_id
Inner join skills_dim on skills_job_dim.skill_id = skills_dim.skill_id

-- We are able to join the tables. 
-- Now lets remove the columns that we don't care about in the query

WITH highest_paying_jobs AS (
    SELECT 
        job_id,
        job_title,
        salary_year_avg,
        name as company_name
    FROM
        job_postings_fact
    left join company_dim on job_postings_fact.company_id = company_dim.company_id
    WHERE 
        job_title_short = 'Data Analyst' AND
        job_location ='Anywhere' AND
        salary_year_avg IS NOT NULL
ORDER BY
        salary_year_avg DESC
LIMIT 10
)
SELECT  
    highest_paying_jobs.*,
    skills
FROM 
    highest_paying_jobs 
Inner join skills_job_dim on highest_paying_jobs.job_id = skills_job_dim.job_id
Inner join skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY 
    salary_year_avg DESC

/* COMMENTS:
        Looking at our result, we can see the commonality of seeing SQL as one of the top
        skills followed by Python, R, and the rest.
--Lets use Excel to analyze this result further.
We can do this by extracting this data from our database and moving it to Excel and using our Pivot table to analyze it further.
