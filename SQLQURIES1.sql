
CREATE TABLE "titles" (
    "title_id" VARCHAR   NOT NULL,
    "title" VARCHAR   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "title_id"
     )
);

SELECT * 
FROM titles


CREATE TABLE "employees" (
    "emp_no" INT   NOT NULL,
    "empl_title_id" VARCHAR   NOT NULL,
    "birth_date" VARCHAR   NOT NULL,
    "first_name" VARCHAR   NOT NULL,
    "last_name" VARCHAR   NOT NULL,
    "sex" VARCHAR   NOT NULL,
    "hire_date" DATE   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

SELECT * 
FROM employees

CREATE TABLE "salaries" (
    "emp_no" INT   NOT NULL,
    "salary" INT   NOT NULL
);

SELECT * 
FROM salaries

CREATE TABLE "dept_eployees" (
    "emp_no" INT   NOT NULL,
    "dept_no" VARCHAR   NOT NULL
);

SELECT * 
FROM dept_eployees

CREATE TABLE "dept_manager" (
    "dept_no" VARCHAR   NOT NULL,
    "emp_no" INT   NOT NULL
);

SELECT * 
FROM dept_manager

CREATE TABLE "departments" (
    "dept_no" VARCHAR   NOT NULL,
    "dept_name" VARCHAR   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

SELECT * 
FROM departments

ALTER TABLE "employees" ADD CONSTRAINT "fk_titles_title_id" FOREIGN KEY("empl_title_id")
REFERENCES "titles" ("title_id");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_eployees" ADD CONSTRAINT "fk_dept_eployees_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_eployees" ADD CONSTRAINT "fk_dept_eployees_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "salaries" ADD PRIMARY KEY("emp_no");

ALTER TABLE "dept_manager" ADD PRIMARY KEY("emp_no","dept_no");

ALTER TABLE "dept_eployees" ADD PRIMARY KEY("emp_no","dept_no");

SELECT * 
FROM titles

SELECT * 
FROM dept_eployees

SELECT * 
FROM dept_manager

SELECT * 
FROM employees

SELECT * 
FROM salaries

SELECT * 
FROM departments


--Data Analysis
--List the employee number, last name, first name, sex, and salary of each employee.
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees as e
INNER JOIN salaries as s
ON e.emp_no = s.emp_no;

--List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT e.last_name, e.first_name, e.hire_date
FROM employees as e 
WHERE hire_date >= '1986-01-01' AND hire_date <= '1986-12-31';

-- List the manager of each department along with their department number, department name, 
-- employee number, last name, and first name.
SELECT d.dept_no, d.dept_name, e.emp_no, e.last_name, e.first_name
FROM departments as d 
INNER JOIN dept_manager
ON d.dept_no = dept_manager.dept_no
INNER JOIN employees as e 
ON dept_manager.emp_no = e.emp_no

--List the department number for each employee along with that employee’s
-- employee number, last name, first name, and department name.
SELECT dept_eployees.dept_no, e.last_name, e.first_name, d.dept_name
FROM dept_eployees
INNER JOIN employees as e 
ON dept_eployees.emp_no = e.emp_no
JOIN departments as d
ON dept_eployees.dept_no = d.dept_no;

-- List first name, last name, and sex of each employee whose first name is Hercules and 
-- whose last name begins with the letter B (2 points)
SELECT first_name, last_name,sex
FROM employees
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%';

-- List each employee in the Sales department, including their employee number, last name, and first name (2 points)
SELECT dept_eployees.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_eployees
JOIN employees as e 
ON dept_eployees.emp_no = e.emp_no
JOIN departments as d
ON dept_eployees.dept_no = d.dept_no
WHERE d.dept_name = 'Sales';

-- List each employee in the Sales and Development departments, including their employee number, 
-- last name, first name, and department name (4 points)
SELECT dept_eployees.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_eployees
INNER JOIN employees as e
ON dept_eployees.emp_no = e.emp_no
INNER JOIN departments as d
ON dept_eployees.dept_no = d.dept_no
WHERE d.dept_name = 'Sales' 
OR d.dept_name = 'Development';


-- List the frequency counts, in descending order, of all the employee last names (that is, 
-- how many employees share each last name) (4 points)
SELECT last_name,
COUNT(last_name) as "frequency counts"
FROM employees
GROUP BY last_name
ORDER BY COUNT(last_name) DESC;

SELECT * FROM information_schema.tables 
WHERE table_schema = 'public'

