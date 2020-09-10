-- List the following details of each employee: employee number, last name, first name, sex, and salary.
CREATE VIEW employee_dets AS
SELECT emp.emp_no,
emp.last_name,
emp.first_name,
emp.sex,
sal.salary
FROM employees as emp
INNER JOIN salaries as sal ON
emp.emp_no = sal.emp_no;

-- List first name, last name, and hire date for employees who were hired in 1986.
create view year_1986 as
select 
emp_no
,first_name
,last_name
,hire_date
from employees
where
hire_date >= '1/1/1986' AND hire_date <= '12/31/1986'
order by hire_date;

-- List the manager of each department with the following information: 
-- department number, department name, the manager's employee number, last name, first name.
Create view department_managers_1 as
SELECT
deptm.dept_no
,deptm.emp_no
,depts.dept_name
FROM dept_managers as deptm
JOIN departments as depts on
deptm.dept_no = depts.dept_no;
create view dept_managers_2 as
select
deptm1.dept_no
,deptm1.dept_name
,deptm1.emp_no
,emp.last_name
,emp.first_name
from department_managers_1 as deptm1
join employees as emp on deptm1.emp_no = emp.emp_no
order by dept_no;

-- List the department of each employee with the following information: 
-- employee number, last name, first name, and department name.
create view employees_w_depts as
select
emp.emp_no
,emp.last_name
,emp.first_name
,empd.dept_no
from employees as emp
join dept_employees as empd on emp.emp_no = empd.emp_no;

create view dept_of_employees as
select
empsd.emp_no
,empsd.last_name
,empsd.first_name
,depts.dept_name
from employees_w_depts as empsd
join departments as depts on empsd.dept_no = depts.dept_no
order by dept_name;

-- List first name, last name, and sex for employees 
-- whose first name is "Hercules" and last names begin with "B."
create view hercules_b as
select
first_name
,last_name
,sex
from employees
where first_name = 'Hercules' and last_name like 'B%';

-- List all employees in the Sales department, 
-- including their employee number, last name, first name, and department name.
create view sales_dept as
select * from dept_of_employees
where dept_name = 'Sales';

-- List all employees in the Sales and Development departments, 
-- including their employee number, last name, first name, and department name.
create view sales_dev_depts as
select * from dept_of_employees
where dept_name = 'Sales' or dept_name = 'Development'
order by dept_name asc;

-- In descending order, list the frequency count of employee last names, 
-- i.e., how many employees share each last name.
create view employees_lastnames_grouped as
select
last_name
,count(last_name)
from employees
group by last_name
order by last_name desc;