SELECT * FROM employees_departments.employees;

-- Rank employees by salary within each department
With dept_salary_rank as(Select empid, EmpName, deptid, salary, rank() over(partition by deptid order by salary desc) as salary_rank from employees)
Select * from dept_salary_rank;

-- Find the highest-paid employee in each department
With highest_paid_employee as(Select EmpId, EmpName, salary, deptId, rank() over(partition by deptId order by salary desc) as salary_rank from employees)
Select * from highest_paid_employee where salary_rank = 1;

 -- Show previous employee salary using LAG()
 Select employees.EmpID, employees.EmpName, employees.Salary as current_salary, lag(salary) over(order by employees.JoiningDate) as prev_Salary from employees;
 
 -- Show next employee’s joining date using LEAD()
 Select EmpId, EmpName, Salary, JoiningDate, lead(JoiningDate) over(partition by JoiningDate) as next_joining_date from employees;
 
  -- Salary difference between current and previous employee
  With salary_diff as(Select EmpID, EmpName, Salary, LAG(Salary) over(partition by salary) as prev_salary from employees)
  Select EmpID, EmpName, Salary, prev_salary, Salary - prev_salary as salary_difference from salary_diff;
 