/*
Question 1: What are the top-paying data analyst jobs?
    - Identify the top 10 highest-paying Data Analyst roles that are available remotely.
    - Focuses on job postings with specified salaries (excluding Nulls).

Why are we doing this? Overall is to offer insight into finding the most optimal roles or 
skills you need to be pusring as a data analyst
    - we will be Highligh the top-paying opportunities for Data Analyst, offering insights into employment

*/



SELECT 
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date
FROM
    job_postings_fact
WHERE 
    job_title_short = 'Data Analyst' AND
    job_location ='Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10

-- Now let look at the companies that are associated with the roles
-- that has the highest jobs.
-- The company name is located in our company dim table, we are going to join the table together using left join.

SELECT 
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name as compnay_name
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

/* we have identified the different jobs that we have 
and we've also been able to see what salary we could expect at some of the
top-paying roles. 
Now, as a data analyst you have a good frame of mind of what you should be targeting for.

Also when you are looking at this query, please feel free to modify the Job_title_short to your preferences
you can also change the job_location to where you are

see you in the next query.
*/
