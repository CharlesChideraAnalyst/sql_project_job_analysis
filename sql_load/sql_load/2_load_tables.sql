--Loading the files inside of the table created
COPY company_dim
FROM 'C:\Users\Chidera\sql_project_job_analysis\csv_files\csv_files\company_dim.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY skills_dim
FROM 'C:\Users\Chidera\sql_project_job_analysis\csv_files\csv_files\skills_dim.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY job_postings_fact
FROM 'C:\Users\Chidera\sql_project_job_analysis\csv_files\csv_files\job_postings_fact.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY skills_job_dim
FROM 'C:\Users\Chidera\sql_project_job_analysis\csv_files\csv_files\skills_job_dim.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');



/* 
I encountered error while loading my files inside my tables. So i used this second step of loading it directly inside my postgres database
1. Open pgAdmin
2. In Object Explorer (left-hand pane), navigate to `sql_course` database
3. Right-click `sql_course` and select `PSQL Tool`
            - This opens a terminal window to write the following code
4. Get the absolute file path of your csv files
            1. Find path by right-clicking a CSV file in VS Code and selecting “Copy Path”
5. Paste the following into `PSQL Tool`, (with the CORRECT file path)

\copy company_dim FROM 'C:\Users\Chidera\sql_project_job_analysis\csv_files\csv_files\company_dim.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

\copy skills_dim FROM 'C:\Users\Chidera\sql_project_job_analysis\csv_files\csv_files\skills_dim.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

\copy job_postings_fact FROM 'C:\Users\Chidera\sql_project_job_analysis\csv_files\csv_files\job_postings_fact.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

\copy skills_job_dim FROM 'C:\Users\Chidera\sql_project_job_analysis\csv_files\csv_files\skills_job_dim.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

*/

-- Now everthing is working fine and have sucessfully loaded into my tables. 
-- I used this command to query my table to make sure all my tables are loaded

SELECT *
FROM job_postings_fact
limit 5

select *
from company_dim
limit 5


select *
from skills_dim
limit 5


select *
from skills_job_dim
limit 5
