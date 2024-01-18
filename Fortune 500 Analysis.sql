CREATE TABLE fortune_companies (
    company_id INTEGER PRIMARY KEY,
    company_name TEXT,
    industry TEXT,
    revenue REAL,
    employees INTEGER,
    healthcare_benefits BIT,
    paid_time_off_days INTEGER,
    maternity_leave_weeks INTEGER,
    avg_employee_tenure REAL
);

INSERT INTO fortune_companies (company_name, industry, revenue, employees, healthcare_benefits, paid_time_off_days, maternity_leave_weeks, avg_employee_tenure)
VALUES
    ('Apple Inc.', 'Technology', 365.7, 147000, 1, 20, 12, 4.5),
    ('Walmart Inc.', 'Retail', 523.96, 2200000, 1, 15, 8, 6.2),
    ('Exxon Mobil Corporation', 'Energy', 265.01, 72000, 0, 18, 6, 7.8),
    ('Amazon.com Inc.', 'Technology', 386.06, 1370000, 1, 22, 14, 5.1),
    ('JPMorgan Chase & Co.', 'Financials', 160.1, 255998, 1, 21, 12, 6.9),
    ('Verizon Communications Inc.', 'Telecommunications', 131.88, 132600, 0, 15, 6, 5.5),
    ('Company A', 'Retail', 235.4, 2000, 1, 18, 10, 5.8),
    ('Company B', 'Healthcare', 400.7, 2300, 1, 22, 13, 5.7),
    ('Company C', 'Manufacturing', 300.2, 2000, 1, 18, 10, 5.8),
    ('Company D', 'Healthcare', 150.5, 3500, 1, 20, 12, 6.5),
    ('Company E', 'Finance', 280.7, 1800, 0, 14, 8, 4.2),
    ('Company F', 'Technology', 420.1, 2500, 1, 22, 14, 7.1),
    ('Company G', 'Retail', 190.8, 1500, 1, 16, 9, 5.3),
    ('Company H', 'Energy', 280.5, 2200, 0, 15, 8, 6.8),
    ('Company I', 'Telecommunications', 110.3, 1800, 1, 19, 11, 4.9),
    ('Company J', 'Manufacturing', 390.6, 2700, 1, 21, 13, 6.2),
    ('Company K', 'Healthcare', 180.2, 3200, 1, 17, 9, 7.4),
    ('Company L', 'Finance', 230.4, 1900, 0, 13, 7, 5.6),
    ('Company M', 'Technology', 340.9, 2800, 1, 23, 15, 6.9),
    ('Company N', 'Retail', 200.6, 1600, 1, 15, 8, 4.7),
    ('Company O', 'Energy', 260.2, 2400, 0, 14, 7, 6.1),
    ('Company P', 'Telecommunications', 130.5, 2100, 1, 20, 12, 5.3),
    ('Company Q', 'Manufacturing', 360.0, 2900, 1, 22, 14, 7.8),
    ('Company R', 'Technology', 400.7, 2300, 1, 22, 13, 5.7),
    ('Company S', 'Retail', 210.8, 1600, 0, 16, 9, 4.9),
    ('Company T', 'Energy', 290.5, 2200, 1, 15, 8, 7.2),
    ('Company U', 'Telecommunications', 140.3, 1900, 1, 20, 12, 6.1),
    ('Company V', 'Manufacturing', 350.6, 2800, 1, 22, 14, 5.4),
    ('Company W', 'Healthcare', 160.2, 3300, 0, 18, 10, 4.8),
    ('Company X', 'Finance', 240.4, 2000, 1, 13, 7, 7.1),
    ('Company Y', 'Technology', 320.9, 2700, 1, 23, 15, 5.6),
    ('Company Z', 'Retail', 180.6, 1400, 0, 14, 8, 6.3),
    ('Company AA', 'Energy', 240.2, 2600, 1, 17, 9, 6.5),
    ('Company BB', 'Telecommunications', 120.5, 2100, 0, 19, 11, 4.5),
    ('Company CC', 'Manufacturing', 380.0, 3000, 1, 21, 13, 7.3),
    ('Company DD', 'Healthcare', 170.2, 3200, 1, 17, 9, 5.8),
    ('Company EE', 'Finance', 250.4, 1900, 0, 12, 6, 6.4),
    ('Company FF', 'Technology', 300.9, 2500, 1, 24, 16, 6.9),
    ('Company GG', 'Retail', 190.6, 1700, 0, 13, 7, 5.2),
    ('Company HH', 'Energy', 280.2, 2300, 1, 16, 9, 6.8),
    ('Company II', 'Telecommunications', 110.5, 2000, 1, 21, 12, 4.9),
    ('Company JJ', 'Manufacturing', 370.0, 3100, 1, 20, 12, 7.6),
    ('Company KK', 'Healthcare', 150.2, 3400, 0, 16, 8, 5.3);

SELECT * FROM fortune_companies;

/* Companies and Industries. */
-- How many Fortune 500 Companies are there in the database?
SELECT COUNT(*) AS Number_Of_Fortune_500_Companies
FROM fortune_companies;

-- How many industries are there?
SELECT DISTINCT COUNT(*) AS Number_Of_Industries
FROM (SELECT industry, COUNT(*) AS Number_Of_Companies FROM fortune_companies
GROUP BY industry ORDER BY Number_Of_Companies DESC);

-- How many companies does each industry has?
SELECT industry, COUNT(*) AS Number_Of_Companies FROM fortune_companies
GROUP BY industry ORDER BY Number_Of_Companies DESC;

-- How many companies are in the IT Field?
SELECT COUNT(*) AS Number_Of_Companies_In_The_IT_Field
FROM fortune_companies WHERE industry="Technology" OR industry="Telecommunications";

-- How many companies are not in the IT Field?
SELECT COUNT(*) AS Number_Of_Companies_Not_In_The_IT_Field FROM fortune_companies
WHERE industry<>"Technology" AND industry<>"Telecommunications";

-- What companies are from the IT Field?
SELECT company_name, industry FROM fortune_companies
WHERE industry IN("Technology","Telecommunications")
ORDER BY company_name ASC;

-- What companies are not from the IT Field?
SELECT company_name, industry FROM fortune_companies
WHERE industry NOT IN("Technology","Telecommunications")
ORDER BY company_name ASC;

/* Revenue. */
-- What is the revenue of the IT companies?
SELECT company_name, industry, revenue FROM fortune_companies
WHERE industry IN("Technology","Telecommunications")
ORDER BY revenue DESC;

-- What is the revenue of the Non IT companies?
SELECT company_name, industry, revenue FROM fortune_companies
WHERE industry NOT IN("Technology","Telecommunications")
ORDER BY revenue DESC;

-- What is the total revenue of the IT companies?
SELECT SUM(revenue) AS Total_Revenue_Of_IT_Companies FROM fortune_companies
WHERE industry IN("Technology","Telecommunications");

-- What is the total revenue of the Non IT companies?
SELECT SUM(revenue) AS Total_Revenue_Of_Non_IT_Companies FROM fortune_companies
WHERE industry NOT IN("Technology","Telecommunications");

-- What is the average revenue of the IT companies?
SELECT AVG(revenue) AS Average_Revenue_Of_IT_Companies FROM fortune_companies
WHERE industry IN("Technology","Telecommunications");

-- What is the average revenue of the Non IT companies?
SELECT AVG(revenue) AS Average_Revenue_Of_Non_IT_Companies FROM fortune_companies
WHERE industry NOT IN("Technology","Telecommunications");

-- Which company has the most revenue?
SELECT company_name AS Company_With_The_Most_Revenue, industry,
MAX(revenue) AS revenue FROM fortune_companies;

-- Which company has the least revenue?
SELECT company_name AS Company_With_The_Least_Revenue, industry,
MIN(revenue) AS revenue FROM fortune_companies;

-- What is the total revenue of each industry?
SELECT industry, SUM(revenue) AS Total_Revenue FROM fortune_companies
GROUP BY industry ORDER BY Total_Revenue DESC;

-- What is the average revenue of each industry?
SELECT industry, AVG(revenue) AS Average_Revenue FROM fortune_companies
GROUP BY industry ORDER BY Average_Revenue DESC;

/* Employees. */
-- What is the number of employees of each IT company?
SELECT company_name, industry, employees FROM fortune_companies
WHERE industry IN("Technology","Telecommunications")
ORDER BY employees DESC;

-- What is the number of employees of each Non IT company?
SELECT company_name, industry, employees FROM fortune_companies
WHERE industry NOT IN("Technology","Telecommunications")
ORDER BY employees DESC;

-- What is the total number of employees of the IT companies?
SELECT SUM(employees) AS Total_Number_Of_IT_Company_Employees
FROM fortune_companies WHERE industry IN("Technology","Telecommunications");

-- What is the total number of employees of the Non IT companies?
SELECT SUM(employees) AS Total_Number_Of_Non_IT_Company_Employees
FROM fortune_companies WHERE industry NOT IN("Technology","Telecommunications");

-- Which company has the most number of employees?
SELECT company_name AS Company_With_The_Most_Employees, industry,
MAX(employees) AS employees FROM fortune_companies;

-- Which company has the least number of employees?
SELECT company_name AS Company_With_The_Least_Employees, industry,
MIN(employees) AS employees FROM fortune_companies;

-- What is the total number of employees of each industry?
SELECT industry, SUM(employees) AS Total_Number_Of_Employees
FROM fortune_companies GROUP BY industry ORDER BY Total_Number_Of_Employees DESC;

-- What is the average number of employees of each industry?
SELECT industry, AVG(employees) AS Average_Number_Of_Employees
FROM fortune_companies GROUP BY industry ORDER BY Average_Number_Of_Employees DESC;

/* Healthcare. */
-- How many companies have healthcare benefits?
SELECT COUNT(*) AS Companies_With_Healthcare_Benefits
FROM fortune_companies WHERE healthcare_benefits = 1;

-- How many companies don't have healthcare benefits?
SELECT COUNT(*) AS Companies_Without_Healthcare_Benefits
FROM fortune_companies WHERE healthcare_benefits = 0;

-- How many companies from each industry have healthcare benefits?
SELECT industry, COUNT(*) AS Number_Of_Companies_With_Healthcare_Benefits
FROM fortune_companies WHERE healthcare_benefits = 1 GROUP BY industry
ORDER BY Number_Of_Companies_With_Healthcare_Benefits DESC;

-- How many companies from each industry don't have healthcare benefits?
SELECT industry, COUNT(*) AS Number_Of_Companies_Without_Healthcare_Benefits
FROM fortune_companies WHERE healthcare_benefits = 0 GROUP BY industry
ORDER BY Number_Of_Companies_Without_Healthcare_Benefits DESC;

-- What companies have healthcare benefits, and how many paid time off days and maternity leave weeks do they offer?
SELECT company_name AS Companies_With_Healthcare_Benefits, industry,
paid_time_off_days, maternity_leave_weeks FROM fortune_companies
WHERE healthcare_benefits = 1;

-- What companies don't have healthcare benefits, and how many paid time off days and maternity leave weeks do they offer?
SELECT company_name AS Companies_Without_Healthcare_Benefits, industry,
paid_time_off_days, maternity_leave_weeks FROM fortune_companies
WHERE healthcare_benefits = 0;

/* Paid Time Off Days. */
-- List the companies and their paid time off days from the company that offers the most days to the least.
SELECT company_name, industry, paid_time_off_days FROM fortune_companies
ORDER BY paid_time_off_days DESC;

-- How many companies offer 2 weeks or less, more than 2 weeks and less than 3 weeks, and 3 weeks or more of paid time off?
SELECT COUNT(*) AS Number_Of_Companies, CASE
WHEN paid_time_off_days <=14 THEN "2 Weeks Or Less"
WHEN paid_time_off_days >14 AND paid_time_off_days <21 THEN "More Than 2 & Less Than 3 Weeks"
ELSE "3 Weeks Or More"
END AS Paid_Time_Off_Weeks FROM fortune_companies GROUP BY Paid_Time_Off_Weeks;

-- Which companies offer 2 weeks or less of paid time off?
SELECT company_name, industry, paid_time_off_days FROM fortune_companies
GROUP BY company_id HAVING paid_time_off_days <=14 ORDER BY paid_time_off_days DESC;

-- Which companies offer more than 2 weeks and less than 3 weeks of paid time off?
SELECT company_name, industry, paid_time_off_days FROM fortune_companies
GROUP BY company_id HAVING paid_time_off_days >14 AND paid_time_off_days <21
ORDER BY paid_time_off_days DESC;

-- Which companies offer 3 weeks or more of paid time off?
SELECT company_name, industry, paid_time_off_days FROM fortune_companies
GROUP BY company_id HAVING paid_time_off_days >=21 ORDER BY paid_time_off_days DESC;

-- What company offers the most paid time off days?
SELECT company_name AS Company_With_The_Most_Paid_Time_Off_Days, industry,
MAX(paid_time_off_days) AS paid_time_off_days FROM fortune_companies;

-- What company offers the least paid time off days?
SELECT company_name AS Company_With_The_Least_Paid_Time_Off_Days, industry,
MIN(paid_time_off_days) AS paid_time_off_days FROM fortune_companies;

-- What is the average number of paid time off days offered by the companies?
SELECT AVG(paid_time_off_days) AS Average_Number_Of_Paid_Time_Off_Days
FROM fortune_companies;

-- What is the average number of paid time off days in each industry?
SELECT industry, AVG(paid_time_off_days) AS Average_Number_Of_Paid_Time_Off_Days
FROM fortune_companies GROUP BY industry ORDER BY Average_Number_Of_Paid_Time_Off_Days DESC;

/* Maternity Leave Weeks. */
-- List the companies and their maternity leave weeks from the company that offers the most weeks to the least.
SELECT company_name, industry, maternity_leave_weeks FROM fortune_companies
ORDER BY maternity_leave_weeks DESC;

-- What company offers the most maternity leave weeks?
SELECT company_name AS Company_With_The_Most_Maternity_Leave_Weeks, industry,
MAX(maternity_leave_weeks) AS maternity_leave_weeks FROM fortune_companies;

-- What company offers the least maternity leave weeks?
SELECT company_name AS Company_With_The_Least_Maternity_Leave_Weeks, industry,
MIN(maternity_leave_weeks) AS maternity_leave_weeks FROM fortune_companies;

-- What is the average number of maternity leave weeks offered by the companies?
SELECT AVG(maternity_leave_weeks) AS Average_Number_Of_Maternity_Leave_Weeks
FROM fortune_companies;

-- What is the average number of maternity leave weeks in each industry?
SELECT industry, AVG(maternity_leave_weeks) AS Average_Number_Of_Maternity_Leave_Weeks
FROM fortune_companies GROUP BY industry ORDER BY Average_Number_Of_Maternity_Leave_Weeks DESC;

/* Average Employee Tenure */
-- List the companies and their average employee tenure.
SELECT company_name, industry, avg_employee_tenure FROM fortune_companies
ORDER BY avg_employee_tenure DESC;

-- Which company has the highest average employee tenure?
SELECT company_name AS Company_With_The_Highest_Average_Employee_Tenure,
industry, MAX(avg_employee_tenure) AS avg_employee_tenure FROM fortune_companies;

-- Which company has the lowest average employee tenure?
SELECT company_name AS Company_With_The_Lowest_Average_Employee_Tenure,
industry, MIN(avg_employee_tenure) AS avg_employee_tenure FROM fortune_companies;

-- What is the average of the average employee tenure of the companies?
SELECT AVG(avg_employee_tenure) AS Average_Of_The_Average_Employee_Tenure
FROM fortune_companies;

-- What is the average employee tenure in each industry?
SELECT industry, AVG(avg_employee_tenure) AS Average_Employee_Tenure
FROM fortune_companies GROUP BY industry ORDER BY Average_Employee_Tenure DESC;

-- How many companies have an average employee tenure of 5 years or less, more than 5 and less than 7 years, and 7 years or more?
SELECT COUNT(*) Number_Of_Companies, CASE
WHEN avg_employee_tenure <=5 THEN "5 Years Or Less"
WHEN avg_employee_tenure >5 AND avg_employee_tenure <7 THEN "More Than 5 & Less Than 7 Years"
ELSE "7 Years Or More"
END AS Average_Employee_Tenure FROM fortune_companies GROUP BY Average_Employee_Tenure;
