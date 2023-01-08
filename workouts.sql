WITH avg_bonus_department AS
    (SELECT department, AVG(bonus) AS average_bonus_per_employee
    FROM employees
    GROUP BY department),
    above_average AS
    (SELECT e.department, count(*) AS employees_with_above_average_bonus
     FROM employees e
     JOIN avg_bonus_department avg
     ON e.department = avg.department
     WHERE bonus > average_bonus
     GROUP BY e.department),
     below_average AS
     (SELECT e.department, count(*) AS employees_with_below_average_bonus
     FROM employees e
     JOIN avg_bonus_department avg
     ON e.department = avg.department
     WHERE bonus < average_bonus
     GROUP BY e.department)
SELECT avg.department, avg.average_bonus, aa.employees_above_average, ba.employees_below_average
FROM avg_bonus_department avg
LEFT JOIN above_average aa
ON avg.department = aa.department
LEFT JOIN below_average ba
ON avg.department = ba.department
