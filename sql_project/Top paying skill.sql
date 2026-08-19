/*
Top paying skills based salary
Focusing on roles with specified salary, regardless of their location
It reveals how different skills impact salary levels for data analysts  and helps identify most rewarding skill financially
*/

SELECT 
    skills,
    Round(avg(salary_year_avg), 0) as average_salary
from job_postings_fact
INNER JOIN skills_job_dim On job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
where job_title_short = 'Data Analyst' and salary_year_avg is not NULL
GROUP BY skills
order by average_salary DESC
limit 20