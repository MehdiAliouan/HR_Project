-- Set the database context
USE Project;

-- Define the project_status CTE
WITH project_status AS (
    SELECT 
        project_id,
        project_name,
        project_budget,
        'upcoming' AS status 
    FROM [upcoming_projects]
    UNION ALL
    SELECT
        project_id,
        project_name,
        project_budget,
        'completed' AS status
    FROM completed_projects
)

-- Query to join employees, departments, project assignments, and project status
SELECT 
    e.employee_id,
    e.first_name,
    e.last_name,
    e.job_title,
    e.salary,
    d.department_name, -- Ensure the correct column name and case
    pa.project_id,
    p.project_name,
    p.status
FROM employees e
JOIN departments d
    ON e.department_id = d.department_id -- Ensure case matches actual schema
JOIN project_assignments pa
    ON pa.employee_id = e.employee_id
JOIN project_status p
    ON p.project_id = pa.project_id;
