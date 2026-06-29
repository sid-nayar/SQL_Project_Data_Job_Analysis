/* 
Question: What skills are required for the top paying data analyst jobs?
- Use the top 10 highest paying Data Analyst jobs from first query.
- Add the specific skills required for these roles.
- Why? It provides a detailed look at which high paying jobs demand certain skills, helping job seekers understand which skills to develop that align with top salaries
*/


-- Making this into a CTE statement to create a temporary table that stores the top 10 highest paying Data Analyst jobs. This allows us to reference this data in subsequent queries without having to repeat the entire query each time.

WITH top_paying_jobs AS (
    SELECT 
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM 
        job_postings_fact

        -- This step helps to get the company name from the company_dim table by joining it with the job_postings_fact table based on the company_id. It allows us to display the company name alongside the job details in the final result set.
    LEFT JOIN 
        company_dim ON job_postings_fact.company_id = company_dim.company_id

    WHERE
        job_title_short = 'Data Analyst' AND
        job_location = 'Anywhere' AND
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)

SELECT 
    top_paying_jobs.*,   -- This selects all the columns from the top_paying_jobs CTE, which includes job_id, job_title, salary_year_avg, and company_name.
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC;
