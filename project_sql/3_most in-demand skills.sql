/* 
QUESTION 3: What are the most in-demand skills for data analysts?
What we are going to be doing here
    1. Join job_postings to the inner join table similar to query 2
    2. Identify the top 5 in-demand skills for a data analyst.
    3. focus on all job postings.
why are we doing this
    - To provide insights into the most valuable skills for job seekers.
*/

SELECT 
    skills,
    COUNT (skills_job_dim.job_id) as demand_skills_count
FROM 
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE   
    job_title_short = 'Data Analyst' AND
    job_work_from_home = TRUE
GROUP BY
    skills
ORDER BY
    demand_skills_count DESC
LIMIT 5

-- From our results, SQL is topping the list as the most in-demand skill for data analysts, followed by Exce, Python and others.
