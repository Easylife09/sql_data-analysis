/*
 what are the mopst optimal skills  which are in high demand and are high paying skills?
 -concentrating on remote positions with high salaries
 This helps target skills that offer job security, financial benefits and also offers strategic insights for career development
 */
with skills_demand AS(
 SELECT 
    skills_dim.skill_id,
    skills_dim.skills,
    count(skills_job_dim.job_id) as demand_count
from job_postings_fact
INNER JOIN skills_job_dim On job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
where job_title_short = 'Data Analyst' and job_work_from_home = TRUE
 and salary_year_avg is not NULL
GROUP BY skills_dim.skill_id
), average_salary AS (
SELECT 
    skills_job_dim.skill_id,
    skills,
    Round(avg(salary_year_avg), 0) as average_salary
from job_postings_fact
INNER JOIN skills_job_dim On job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
where job_title_short = 'Data Analyst' and salary_year_avg is not NULL
and job_work_from_home = TRUE
GROUP BY skills_job_dim.skill_id, skills_dim.skills
)
SELECT
skills_demand.skill_id,
skills_demand.skills,
demand_count,
average_salary
from skills_demand
INNER JOIN average_salary on skills_demand.skill_id = average_salary.skill_id
where demand_count > 12
ORDER BY demand_count desc, average_salary DESC
LIMIT 20