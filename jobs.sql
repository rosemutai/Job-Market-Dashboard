CREATE SCHEMA tech_career_analysis;
SET search_path TO tech_career_analysis;

--create table jobs
CREATE TABLE jobs_staging(
	job_id SERIAL PRIMARY KEY,
	job_title TEXT,
	company_name TEXT,
	LOCATION TEXT, 
	hiring_status TEXT, 
	job_posted_date TEXT, 
	seniority_level TEXT, 
	job_function TEXT, 
	employment_type TEXT,
	industry TEXT
);

--verify data was imported
SELECT count(*) FROM jobs_staging;

--Change data types
--1. job_title
ALTER TABLE jobs_staging
ALTER COLUMN job_title TYPE varchar(255) USING job_title::varchar(255);


--2. company_name
ALTER TABLE JOBS_STAGING 
ALTER COLUMN company_name TYPE varchar(255) USING company_name::varchar(255);

--3. LOCATION
ALTER TABLE jobs_staging
RENAME COLUMN LOCATION11 TO location;

ALTER TABLE jobs_staging
ALTER COLUMN location TYPE varchar(100) USING location::varchar(100);

--4. hiring_status
ALTER TABLE jobs_staging
ALTER COLUMN hiring_status TYPE varchar(100) USING hiring_status::varchar(100);

--5. job_posted_date
ALTER TABLE jobs_staging
ALTER COLUMN job_posted_date TYPE DATE USING job_posted_date::DATE;

 
--6. seniority_level
ALTER TABLE jobs_staging
ALTER COLUMN seniority_level TYPE varchar(100) USING seniority_level::varchar(100);

--7. job_function
ALTER TABLE jobs_staging
ALTER COLUMN job_function TYPE varchar(255) USING job_function::varchar(255);

--8. employment_type
ALTER TABLE jobs_staging
ALTER COLUMN employment_type TYPE varchar(255) USING employment_type::varchar(100);
	
--9. industry
ALTER TABLE jobs_staging
ALTER COLUMN industry TYPE varchar(255) USING industry::varchar(255);

SELECT job_posted_date FROM jobs_staging LIMIT 4;
ALTER TABLE jobs_staging
RENAME COLUMN date TO job_posted_date;

--Find Missing Values
SELECT * FROM jobs_staging LIMIT 5;
SELECT * FROM jobs_staging
WHERE job_title IS NULL OR TRIM(job_title) = ''
	OR company_name IS NULL OR TRIM(company_name) = ''
	OR location IS NULL OR TRIM(location) = ''
	OR hiring_status IS NULL OR TRIM(hiring_status) = ''
	OR job_posted_date IS NULL OR TRIM(job_posted_date) = ''
	OR seniority_level IS NULL OR TRIM(seniority_level) = ''
	OR job_function IS NULL OR TRIM(job_function) = ''
	OR employment_type IS NULL OR TRIM(employment_type) = ''
	OR industry IS NULL OR TRIM(industry) = '';

SELECT
	job_id,
	company_name,
	location,
	hiring_status,
	job_posted_date,
	seniority_level,
	job_function,
	employment_type,
	industry
FROM jobs_staging
GROUP BY
	job_id,
	company_name,
	location,
	hiring_status,
	job_posted_date,
	seniority_level,
	job_function,
	employment_type,
	industry
HAVING COUNT(*) > 1;

-- Remove trailing spaces
UPDATE JOBS_STAGING JS 
SET job_title = BTRIM(REPLACE(REPLACE(job_title, E'\r', ''), E'\n', '')),
    company_name = BTRIM(REPLACE(REPLACE(company_name, E'\r', ''), E'\n', '')),
    hiring_status = BTRIM(REPLACE(REPLACE(hiring_status, E'\r', ''), E'\n', '')),
    seniority_level = BTRIM(REPLACE(REPLACE(seniority_level, E'\r', ''), E'\n', '')),
    job_function = BTRIM(REPLACE(REPLACE(job_function, E'\r', ''), E'\n', '')),
    employment_type = BTRIM(REPLACE(REPLACE(employment_type, E'\r', ''), E'\n', '')),
    industry = BTRIM(REPLACE(REPLACE(industry, E'\r', ''), E'\n', ''));


--Standardize case
UPDATE JOBS_STAGING JS 
SET company_name = INITCAP(LOWER(company_name)),
	job_title = INITCAP(LOWER(job_title)),
	location = INITCAP(LOWER(location)),
	hiring_status = INITCAP(LOWER(hiring_status)),
	seniority_level = INITCAP(LOWER(seniority_level)),
	job_function = INITCAP(LOWER(job_function)),
	employment_type = INITCAP(LOWER(employment_type)),
	industry = INITCAP(LOWER(industry));


ALTER TABLE JOBS_STAGING 
ADD COLUMN city varchar(100),
ADD COLUMN state varchar(100),
ADD COLUMN country varchar(100);


UPDATE JOBS_STAGING
SET
    city = TRIM(split_part(location, ',', 1)),
    state = TRIM(split_part(location, ',', 2)),
    country = NULLIF(TRIM(split_part(location, ',', 3)), '');


SELECT * FROM JOBS_STAGING LIMIT 1;
--remove TRAILING spaces in new columns
UPDATE JOBS_STAGING
SET
    city = BTRIM(REPLACE(REPLACE(city, E'\r', ''), E'\n', '')),
    state = BTRIM(REPLACE(REPLACE(state, E'\r', ''), E'\n', '')),
    country = BTRIM(REPLACE(REPLACE(country, E'\r', ''), E'\n', ''));

UPDATE JOBS_STAGING JS 
SET city = INITCAP(LOWER(city)),
	state = INITCAP(LOWER(state)),
	country = INITCAP(LOWER(country));

SELECT job_id, city, country FROM JOBS_STAGING WHERE city = 'United States';

UPDATE jOBS_STAGING
SET country = 'United States'
	WHERE city = 'United States';

UPDATE jOBS_STAGING
SET city = NULL
	WHERE city = 'United States';

SELECT job_title, seniority_level FROM jOBS_STAGING
WHERE job_title LIKE '%Software Engineer%';


SELECT job_title, cleaned_title FROM jobs_staging
WHERE job_title = '行政主管g04145';

UPDATE jobs_staging
SET job_title = 'Office Manager'
WHERE job_title = '行政主管g04145';

SELECT job_title FROM jobs_staging
WHERE job_title LIKE '%Backend%';

SELECT job_title FROM jobs_staging
WHERE job_title LIKE '%Blockchain%';

UPDATE JOBS_STAGING JS
SET job_title = 'Blockchain Engineer'
WHERE job_title LIKE '%Blockchain%';

SELECT job_title FROM jobs_staging
WHERE job_title LIKE '%Axel - Founding Backend + Api Engineer%';


SELECT job_title, seniority_level, country FROM jobs_staging
WHERE job_title = 'Software Engineer - Backend';

UPDATE JOBS_STAGING JS
SET job_title = 'Backend Developer',
	seniority_level = 'Senior'
WHERE job_title = 'Senior Backend Developer';


UPDATE JOBS_STAGING JS
SET job_title = 'Backend Developer'
WHERE job_title LIKE '%Backend%';

UPDATE JOBS_STAGING JS
SET job_title = 'Backend Developer'
WHERE job_title = 'Senior Backend Engineer';

UPDATE JOBS_STAGING JS
SET job_title = 'Backend Developer'
WHERE job_title = 'Software Engineer - Backend';

UPDATE JOBS_STAGING JS
SET job_title = 'Backend Developer'
WHERE job_title = 'Product Engineer I - Backend Developer';

UPDATE JOBS_STAGING JS
SET job_title = 'Backend Developer'
WHERE job_title = 'Software Developer Engineer - Backend';

UPDATE JOBS_STAGING JS
SET job_title = 'Backend Developer'
WHERE job_title = 'Software Developer Engineer - Backend';

SELECT * FROM JOBS_STAGING WHERE job_title LIKE '%Senior Backend Software Engineer%';

UPDATE JOBS_STAGING JS
SET job_title = 'Fullstack Developer',
	company_name = 'Metaverse Ventures Private Limited'
WHERE job_title = 'Full Stack Backend Development - Payment Rails, Invoicing And Money Movement Work From Home Job/Internship At Metaverse Ventures Private Limited';

UPDATE JOBS_STAGING JS
SET job_title = 'Backend Developer'
WHERE job_title = 'Lead/Senior Software Engineer - Backend (Remote)';

UPDATE JOBS_STAGING JS
SET job_title = 'Backend Developer'
WHERE job_title LIKE '%Axel - Founding Backend + Api Engineer%';


SELECT job_title, company_name FROM jobs_staging
WHERE job_title NOT IN ('Backend Developer', 'Blockchain Engineer');


DELETE FROM jobs_staging
WHERE job_title = 'Personal Assistant To Chief Executive Officer' AND
	job_id IN (7691, 14731, 16645, 20424);

DELETE FROM jobs_staging
WHERE job_title = 'Personal Assistant To Chief Executive Officer' AND 
	seniority_level = 'Full-Time';


SELECT * FROM jobs_staging;

UPDATE JOBS_STAGING JS
SET job_title = 'Full Stack Developer'
WHERE job_title LIKE '%Full Stack%';

UPDATE JOBS_STAGING JS
SET job_title = 'Data Scientist'
WHERE job_title LIKE '%Data Scientist%';

UPDATE JOBS_STAGING JS
SET job_title = 'Decision Scientist'
WHERE job_title LIKE '%Decision Scientist%';

UPDATE JOBS_STAGING JS
SET job_title = 'Software Developer'
WHERE job_title LIKE '%Software Developer%';

-- DMM: Digital Marketing Manager
UPDATE JOBS_STAGING JS
SET job_title = 'Digital Marketing Manager'
WHERE job_title = 'DMM';

UPDATE JOBS_STAGING JS
SET job_title = 'Marketing Manager'
WHERE job_title LIKE '%Marketing Manager%';

DELETE FROM JOBS_STAGING 
WHERE job_id IN(14314, 25374);

UPDATE JOBS_STAGING JS
SET job_title = 'Assistant Marketing Manager'
WHERE JOB_TITLE IN('Manager/ Assistant Manager Marketing', 'Vice President Marketing', 
		'Vice President (Vp) Of Marketing', 'Assistant Vice President Marketing'
		'Assistant Vice President Marketing', 'Assistant Manager Customer Marketing' 
		'Assistant Marketing Operations Manager, India', 'Marketing Assistant Part-Time - Hurstville', 
		'Assistant Manager- Customer Marketing', 'Asst. Manager - Marketing');


SELECT job_title, count(*) FROM jobs_staging
GROUP BY job_title;

UPDATE JOBS_STAGING JS
SET job_title = 'Marketing Manager'
WHERE JOB_TITLE LIKE '%Marketing%' AND job_title NOT IN
		('Digital Marketing Manager', 'Assistant Digital Marketing Manager')
		AND job_title NOT LIKE '%Assistant Marketing Manager%';


UPDATE JOBS_STAGING JS
SET job_title = 'Finance Officer'
WHERE job_title LIKE '%Finance%';

UPDATE JOBS_STAGING JS
SET JOB_TITLE = 'Business Manager'
WHERE job_title IN ('Manager - Business Transformation', 'Manager - Business Transformation', 'Business Transformation Manager', 'Business Execution Manager',
			'Iris Business Services - Manager - Presales', 'Guitcom - Manager - Business Valuation', 'Business Optimization Manager', 
			'Business Development & Partnerships - Manager', 'Business Partnering Manager', 'Business Partnering Manager', 'Business Retail Manager - Perth',
			'Business Enablement Manager', 'Business Developmet Manager -Hospitality Industry', 'Frontline Motor Business Optimisation Manager (95369)',
			'Business Analysis - Senior Manager', 'Business Development Manager', 'Business Transformation Manager', 'Business Operations Manager',
			'Business Head', 'Business Analysis Manager - Cross Product Change Services');

UPDATE JOBS_STAGING JS
SET JOB_TITLE = 'Business Manager'
WHERE job_title 
IN('Manager, Business Operations', 'Business Operations & Service Manager For Exchange Business Platform',
			'Scm - Business Process And Compliance Manager', 'Business Advisory Manager', 'Manager - Emerging Business',
			'Business Development Manager (It Staffing)', 'Senior Business Development Manager', 'Business And Governance Manager',
			'Business Growth Manager - Rent Roll Aquisitions', 'Cfo Advisory Manager - Business Advisory', 'Retail Business Development Manager',
			'Business Operations & Service Manager For Exchange Business Platform', 'Team Assistant And Business Admin Manager',
			'Business Servcies Manager', 'Business Strategy Manager', 'Manager-Business Operations', 'Business Advisory Manager', 'Manager, Business Operations',
			'Business Development Manager, Business Solutions Group, Avp, Bangalore', 'Business And Governance Manager', 
			'Manager - Business Administration');

UPDATE JOBS_STAGING JS
SET JOB_TITLE = 'Business Analyst'
WHERE job_title IN('Business Information Analyst Ii', 'Business Doctors - Analyst', 'Business Systems Analyst',
			'Business Development Analyst (Graduate Role)', 'Edufic Digital - Analyst - Business Research/Market Research', 
			'Business Continuity And Operational Controls Analyst', 'Senior Business Process Analyst', 
			'Senior Business Systems Analyst', 'Junior Agile Business Systems Analyst', 'Analyst, Business Management');

DELETE FROM JOBS_STAGING
WHERE job_id IN(18150, 9349, 5141, 19250, 12079, 18897);

UPDATE JOBS_STAGING JS
SET JOB_TITLE = 'Virtual Assistant'
WHERE job_title IN('Virtual Assistant To Customer Success (B2b)', 'Virtual Assistant - Real Estate', 'General Virtual Assistant', 'General Virtual Assistant (Part-Time)',
'Remote Executive/Virtual Assistant.', 'Real Estate Virtual Assistant', 'Remote Executive/Virtual Assistant.');


DELETE FROM JOBS_STAGING
WHERE job_id IN(5578, 20294, 22669, 906, 23549, 5182, 9787);

DELETE FROM JOBS_STAGING
WHERE job_id IN(4210, 25377, 29065, 22713, 30086, 28569, 11480);


UPDATE JOBS_STAGING JS
SET job_title = 'Mobile App Developer'
WHERE job_title LIKE '%Native%';


CREATE TABLE backup_jobs_2 AS
SELECT * FROM jobs_staging;


UPDATE JOBS_STAGING JS
SET job_title = 'Digital Innovations Specialist'
WHERE job_title LIKE '%Digital Innovations%';


SELECT * FROM jobs_staging
WHERE job_title LIKE '%Specialist%';


SELECT * FROM jobs_staging
WHERE job_title LIKE '%Digital Innovations%';

SELECT * FROM jobs_staging
WHERE job_title LIKE 'Dev Ops%';

UPDATE JOBS_STAGING JS
SET job_title = 'Executive Assistant'
WHERE job_title LIKE '%Ea To Ceo & Cfo, Manchester%';
 


CREATE TABLE jobs_backup_3 AS 
SELECT * FROM jobs_staging;

DELETE FROM JOBS_STAGING
WHERE job_title IN('Not Applicable', 'Internship');

SELECT job_title, count(*) FROM jobs_staging
GROUP BY job_title
ORDER BY count(*) DESC;


DELETE FROM jobs_staging
WHERE job_title IN(
	SELECT job_title FROM jobs_staging
	GROUP BY job_title
	HAVING count(*) <= 4
);

DELETE FROM JOBS_STAGING
WHERE job_id IN(18107, 25951, 27328, 11798, 1138);

SELECT * FROM jobs_staging
WHERE job_title LIKE '%Office%' AND  job_title NOT IN ('Office Manager', 
		'Finance Officer', 'Office Assistant');



SELECT * FROM jobs_staging
WHERE job_title LIKE '%Business % Manager%' AND job_title NOT IN ('Business Analyst', 'Business Manager',
			'HR Business Partner', 'Business Consultant', 'Business Development');

DELETE FROM jobs_staging
WHERE job_id IN (21039, 6439, 27457, 27931, 8016, 31286, 10926, 23369);
UPDATE JOBS_STAGING JS
SET job_title = 'Content Developer'
WHERE JOB_TITLE LIKE '%Content%' AND job_title NOT IN('Content Editor', 'Content Writer');


UPDATE JOBS_STAGING JS
SET job_title = 'Sales Manager'
WHERE JOB_TITLE LIKE '%Sales%';


UPDATE jobs_staging
SET job_title = 'Director'
WHERE JOB_TITLE LIKE '%Director%';

UPDATE jobs_staging
SET job_title = ' Managing Director'
WHERE JOB_TITLE LIKE '% Managing Director%';


UPDATE JOBS_STAGING JS 
SET job_title = 'Project Manager'
WHERE job_title IN ('H)omes Project Manager', 'Construction Project Manager', 'Project Manager (Construction)', 'It Project Manager (F/M/D)',
			'Junior Project Manager', 'Communications Project Manager', 'Freelance Creative Project Manager', 'Alus Project Manager',
			'Creative Project Manager', 'Project Manager Ii', 'Marketing Project Manager', 'Project Manager 1', 'Operations Project Manager',
			'Traveling Project Manager', 'Project Manager, B2b', 'Solar Project Manager', 'Project Manager - Creative Services', 'Customer Care Project Manager',
			'Project Manager, Consultant', 'Project Manager - Data Center', 'Marketing Project Manager', 'Operations Project Manager', 'Project Manager/Construction Manager',
			'Infrastructure Project Manager', 'Entry Level - Project Manager (Remote)', 'Exhibition Project Manager', 'Executive Assistant Project Manager');

UPDATE JOBS_STAGING JS 
SET job_title = 'Project Manager'
WHERE job_title IN('Homes Project Manager', 'Project Manager, Partner Engagement', 'Associate Project Manager - Product Management (Mandarin)', 'Commercial Project Manager'
			'Project Manager - Construction', 'Commercial Project Manager', 'It Project Manager', 'Associate Project Manager', 'Project Manager - Localization',
			'Homes Project Manager', 'Smart Infrastructure Project Manager', 'Project Manager-Digital Services', 'Associate Project Manager',
			'Commercial Project Manager', 'Project Manager / Project Coordinator', 'Project Manager, Partner Engagement', 'Project Manager I',
			'It Project Manager', 'Homes Project Manager', 'Ao6 Business Improvement Project Manager', 'Associate Project Manager', 'Project Manager-Digital Services',
			'Project Manager / Project Coordinator');


UPDATE jobs_staging
SET job_title = 'Software Engineer'
WHERE job_title LIKE '%Software Engineer - Java/Node.Js%';

UPDATE JOBS_STAGING JS 
SET job_title = 'B2B Email Specialist'
WHERE job_title = 'B2b Email Specialist (Jb2947)';

UPDATE JOBS_STAGING JS 
SET job_title = 'HR Assistant Manager'
WHERE job_title = 'Assistant Hr Manager';

--Remove duplicates
DELETE FROM JOBS_STAGING 
WHERE job_id in(2138, 3140, 10024, 14921, 15419, 16889);

-- Clean HR Job Title
UPDATE jobs_staging
SET job_title = CASE
    WHEN LOWER(TRIM(job_title)) IN ('hrbp', 'hr business partner', 'people partner', 'hr manager hrbp',
                                    'business hr manager', 'business hr') THEN 'HR Business Partner'
    WHEN LOWER(TRIM(job_title)) IN ('hr generalist', 'human resources generalist') THEN 'HR Generalist'
    WHEN LOWER(TRIM(job_title)) IN ('hr recruiter', 'hr executive recruiter') THEN 'HR Recruiter'
    WHEN LOWER(TRIM(job_title)) IN ('hr manager', 'office / hr manager', 'country hr manager and hr support',
                                    'hr manager - people culture - employee engagement - fintech',
                                    'manufacturing hr manager') THEN 'HR Manager'
    ELSE INITCAP(LOWER(TRIM(job_title)))
END;

-- Clean HR Program Manager Job Title
UPDATE jobs_staging
SET job_title = CASE
    WHEN LOWER(TRIM(job_title)) IN ('technical program manager - editor') THEN 'Technical Program Manager'
    WHEN LOWER(TRIM(job_title)) IN ('product owner/program manager/scrum', 'program manager - hr', 
                                    'business program manager - consulting firm') THEN 'Program Manager'
    ELSE INITCAP(LOWER(TRIM(job_title)))
END;

-- Remove duplicate 'Software Engineer - Java/Node.Js' Job Title
DELETE FROM jobs_staging
WHERE job_id IN (3720, 4439, 8173, 10948, 12937, 15440, 26253);

-- Remove duplicate 'Associate/Sr Content Writer' Job Title
DELETE FROM jobs_staging
WHERE job_id IN (5801, 8425, 13611);


WITH ranked_rows AS (
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY company_name, location, hiring_status, seniority_level, employment_type, industry, job_posted_date
        ) AS rn
    from jobs_staging
)
SELECT *
FROM ranked_rows
WHERE rn > 1;

UPDATE JOBS_STAGING JS
SET job_title = 'Business Manager'
WHERE job_title LIKE '%Business Manager%';

UPDATE JOBS_STAGING JS 
SET company_name = 'Mnc Life Insurance'
WHERE job_title = 'Senior Business Manager In Mnc Life Insurance';

SELECT job_title, industry FROM JOBS_STAGING;

UPDATE JOBS_STAGING JS
SET job_title = 'Design Engineer'
WHERE job_title LIKE '%Design%' AND job_title NOT IN('Graphic Designer', 'Creative Designer', 'Web Designer', 'UI/UX Designer');

SELECT job_title, industry FROM JOBS_STAGING
WHERE job_title LIKE '%Machine Learning%' AND job_title NOT IN ('Machine Learning Engineer');

SELECT job_title, industry FROM JOBS_STAGING
WHERE job_title LIKE '%Data Scien%';


UPDATE JOBS_STAGING JS
SET job_title = 'Product Manager'
WHERE job_title LIKE '%Senior Product Manager, Machine Learning Risk%';

UPDATE JOBS_STAGING JS
SET job_title = 'Machine Learning Engineer'
WHERE job_title LIKE '%Machine Learning (Ml) Expert For Robotics & Autonomous Systems With Security Clearance%';

UPDATE JOBS_STAGING JS
SET job_title = 'Machine Learning Engineer'
WHERE job_title LIKE '%Machine Learning%';

DELETE FROM jobs_staging
WHERE job_id IN (490, 6544, 6918, 7426, 10676, 15236, 16996, 21467);


UPDATE JOBS_STAGING JS
SET job_title = 'Python Developer'
WHERE job_title LIKE '%Python Developer%';

UPDATE JOBS_STAGING JS
SET job_title = 'Software Engineer'
WHERE job_title LIKE '%Software Engineer%';

SELECT job_title, industry FROM JOBS_STAGING
WHERE job_title LIKE '%Digital Marketing%' AND job_title NOT IN ('Digital Marketing Manager', 
	'Assistant Digital Marketing Manager', 'Digital Marketing Specialist');

UPDATE jobs_staging
SET job_title = CASE 
    WHEN LOWER(TRIM(job_title)) IN ('digital marketing manager', 'consultant digital marketing & kommunikation 100%', 
                                    'senior manager digital marketing', 'senior manager-digital marketing', 'strategy manager - digital marketing',
                                    'manager, digital marketing', 'manager-digital marketing || dehradun', 
                                    'digital marketing & social media executive', 'manager - digital marketing', 
                                    'digital marketing and content coordinator', 'senior manager – digital marketing',
                                    'vice president - digital marketing', 'art director (m/w/d) at yes! creative digital marketing'
        )
                                    THEN 'Digital Marketing Manager'
    WHEN LOWER(TRIM(job_title)) IN ('communications/digital marketing specialist', '') THEN 'Digital Marketing Specialist'
    WHEN LOWER(TRIM(job_title)) IN ('assistant manager - digital marketing', 'assistant manager - paid digital marketing') THEN 'Assistant Digital Marketing Manager'
    ELSE INITCAP(LOWER(TRIM(job_title)))
END;


UPDATE JOBS_STAGING JS
SET job_title = 'Site Reliability Engineer'
WHERE job_title LIKE '%Site Reliability Engineer%';

UPDATE JOBS_STAGING JS
SET job_title = 'Creative Designer'
WHERE job_title LIKE '%Creative Designer%';

UPDATE JOBS_STAGING JS
SET job_title = 'Cloud Engineer'
WHERE job_title LIKE 'Azure Cloud Engineer_Deepanshi_Ttp';


UPDATE JOBS_STAGING JS
SET job_title = 'Research Associate'
WHERE job_title LIKE '%Research Associate%';


UPDATE JOBS_STAGING JS
SET job_title = 'UI/UX Designer'
WHERE job_title LIKE '%Ui/Ux Designer%';


UPDATE JOBS_STAGING JS
SET job_title = 'Graphic Designer'

SELECT * FROM JOBS_STAGING JS

UPDATE jobs_staging
SET job_title = 'Project Manager'
WHERE job_title LIKE '%Project Manager/Director%';

DELETE FROM jobs_staging
WHERE job_id IN (3870, 24213);

UPDATE jobs_staging
SET job_title = CASE
    WHEN LOWER(TRIM(job_title)) IN ('web designer:in / grafiker:in 50%', 'stagiaire designer web', 
                                    'webdesigner & webentwickler (m/w/d)', 'designer web (m/w/d)',
                                    'designer web (h/f)', 'web designer/in') THEN 'Web Designer'
    ELSE INITCAP(LOWER(TRIM(job_title)))
END;


select * FROM jobs_staging WHERE job_title = 'Project Accountant';



UPDATE JOBS_STAGING JS 
SET job_title = 'Project Accountant'
WHERE job_title = '项目会计（驻外）';

UPDATE JOBS_STAGING JS 
SET company_name = 'Zhongru Construction Engineering Group Co., Ltd'
WHERE company_name = '中如建工集团有限公司';


UPDATE JOBS_STAGING JS 
SET job_title = 'Personal Assistant'
WHERE job_title LIKE '%Personal Secretary%';

UPDATE JOBS_STAGING JS 
SET job_title = 'General Manager'
WHERE job_title LIKE '%Hr Process - Dgm / Sm%' AND job_title NOT IN ('General Manager', 'Assistant General Manager');

SELECT* FROM JOBS_STAGING JS 
WHERE job_title LIKE '%General Manager%' AND job_title NOT IN ('General Manager', 'Assistant General Manager');

SELECT * FROM jobs_staging 
WHERE job_title LIKE '%General Manager%' AND job_title NOT IN ('General Manager', 'Assistant General Manager');


UPDATE jobs_staging 
SET job_title = 'Brand Manager'
WHERE job_title LIKE '%Brand Manager%' AND job_title NOT IN ('Brand Manager', 'Assistant Brand Manager');

UPDATE jobs_staging 
SET job_title = 'Assistant Brand Manager'
WHERE job_title LIKE '%Assistant Brand Manager - F&S%';

UPDATE jobs_staging 
SET job_title = 'Assistant Brand Manager'
WHERE job_title LIKE '%Brand Manager%' AND 
	job_title LIKE '%Assistant%' AND 
	job_title NOT IN ('Assistant Brand Manager');

UPDATE jobs_staging 
SET job_title = 'Assistant General Manager'
WHERE job_title LIKE '%Deputy General Manager%';


SELECT job_title, count(*) FROM JOBS_STAGING
GROUP BY job_title;


UPDATE jobs_staging 
SET job_title = 'Risk, Analytics & Reporting, Vice President'
WHERE job_title = 'Risk, Analytics & Reporting, Vice President, London';


UPDATE JOBS_STAGING JS 
SET job_title = 'Test Engineer'
WHERE job_title LIKE '%Test Engineer%';


UPDATE JOBS_STAGING JS 
SET job_title = 'Devops Engineer'
WHERE job_title LIKE '%Devops%';

UPDATE JOBS_STAGING JS 
SET job_title = 'Cybersecurity Engineer'
WHERE job_title LIKE '%Cybersecurity%';


UPDATE jobs_staging 
SET job_title = 'Firmware Developer'
WHERE job_title LIKE '%Firmware%';

UPDATE jobs_staging 
SET job_title = 'Civil Engineer'
WHERE job_title LIKE '%Civil Engineer%';

UPDATE jobs_staging 
SET job_title = 'Research Analyst'
WHERE job_title LIKE '%Analyst, Research%';

UPDATE jobs_staging 
SET job_title = 'Data Analyst'
WHERE job_title LIKE '%Digital Marketing Analyst%';

UPDATE jobs_staging 
SET job_title = 'Business Analyst'
WHERE job_title LIKE '%Business Analyst%';

UPDATE jobs_staging 
SET job_title = 'HR Generalist'
WHERE job_title LIKE '%Human Resources%';

UPDATE JOBS_STAGING JS 
SET job_title = 'Embedded Engineer'
WHERE job_title LIKE '%Embedded Engineer%';

SELECT * FROM JOBS_STAGING JS 
WHERE job_title LIKE '%Marketing%' AND job_title NOT IN ('Digital Marketing Manager', 'Marketing Manager',
	'Marketing Director','Head of Marketing', 'Assistant Marketing Manager', 'Digital Marketing Specialist');

UPDATE JOBS_STAGING JS
SET job_title = 'Assistant Marketing Manager'
WHERE job_title LIKE '%Assistant Manager - Marketing%' AND job_title NOT IN ('Digital Marketing Manager', 'Head of Marketing');

UPDATE JOBS_STAGING JS
SET job_title = 'Marketing Manager'
WHERE job_title = 'Sr. Manager/Manager-Marketing';

UPDATE JOBS_STAGING JS
SET job_title = 'Marketing Director'
WHERE job_title LIKE '%Marketing Director%' AND job_title NOT IN ('Digital Marketing Manager', 'Head of Marketing');


UPDATE jobs_staging
SET job_title = CASE
    WHEN LOWER(TRIM(job_title)) IN ('people partner (hrbp)', 'pharmeasy - hr business partner', 'sr manager, hr business partner')
                                THEN 'HR Business Partner'
    WHEN LOWER(TRIM(job_title)) IN ('senior executive - hr (shared services)', 'hiring For hr generalist'
                                    'hr consultant |employment conditions', 'hr generalist - newark',
                                    'hr (employment lawyer) | 6 to 10 years | mumbai',
                                    'vice president hr technology & digital transformation',
                                    'corporate hr (remote)', 'staff hr service specialist',
                                    'hr generalist - miami', 'hr coordinator', 'hr generalist - philadelphia',
                                    'human resources generalist (hr generalist)') THEN 'HR Generalist'
    ELSE INITCAP(LOWER(TRIM(job_title)))

END;


UPDATE JOBS_STAGING JS 
SET job_title = 'HR Business Partner'
WHERE job_title LIKE '%Hrbp%';

UPDATE JOBS_STAGING JS 
SET job_title = 'HR Recruiter'
WHERE job_title LIKE '%Recruitment Officer (Hr Officer)%';

UPDATE JOBS_STAGING JS 
SET job_title = 'HR Manager'
WHERE job_title LIKE '%Hr Head/Manager%';
--WHERE job_title LIKE '%Manager Hr%';


SELECT * FROM jobs_staging 
WHERE job_title LIKE 'Hr Generalist%' AND job_title NOT IN ('HR Generalist');

UPDATE JOBS_STAGING JS 
SET job_title = 'HR Generalist'
WHERE job_title LIKE '%Hr % Training%';
--WHERE job_title LIKE 'Hr Generalist%' AND job_title NOT  IN ('HR Generalist');

UPDATE JOBS_STAGING JS 
SET job_title = 'HR Generalist'
WHERE job_title LIKE '%Hiring For Hr Generalist%';

UPDATE JOBS_STAGING JS 
SET job_title = 'HR Consultant'
WHERE job_title LIKE '%Hr Functional Consultant%';

UPDATE JOBS_STAGING JS 
SET job_title = 'HR Manager'
WHERE job_title LIKE '%Hr %' AND job_title LIKE '%Manager %';

SELECT * FROM JOBS_STAGING JS
WHERE job_title LIKE '%Hr %';

UPDATE JOBS_STAGING JS 
SET job_title = 'HR Generalist'
WHERE job_title LIKE '%Hr %';

UPDATE JOBS_STAGING JS 
SET job_title = 'Assistant HR'
WHERE job_title = 'Senior Executive / Assistant Manager – Hr Bp';

SELECT * FROM JOBS_STAGING JS
WHERE job_title LIKE '%Research%';

UPDATE JOBS_STAGING JS 
SET job_title = 'Frontend Developer'
WHERE job_title LIKE '%Frontend Developer%';

UPDATE JOBS_STAGING JS 
SET job_title = 'Typescript Developer'
WHERE job_title LIKE '%Typescript%';


UPDATE JOBS_STAGING JS 
SET job_title = 'Backend Developer'
WHERE job_title LIKE '%Developer - Back End%';

UPDATE JOBS_STAGING JS 
SET job_title = 'Project Engineer'
WHERE job_title LIKE '%Project Engineer%';

UPDATE JOBS_STAGING JS 
SET job_title = 'Researcher'
WHERE job_title LIKE '%Researcher%';


DELETE FROM jobs_staging
WHERE job_title = '?????????????(????)';
--WHERE job_id IN (7343, 28688, 14890, 11527, 29473);

UPDATE JOBS_STAGING JS 
SET job_title = 'Copywriter'
WHERE job_title LIKE '%Copywriter%';


UPDATE JOBS_STAGING JS 
SET job_title = 'Social Media Manager'
WHERE job_title LIKE '%Social Media%';


UPDATE JOBS_STAGING JS 
SET job_title = 'R&D Engineer'
WHERE job_title LIKE '%R&D Engineer%';


SELECT * FROM jobs_staging
WHERE job_title LIKE '%Senior/ Principal Ai Research Scientist%';


UPDATE JOBS_STAGING JS 
SET job_title = 'AI Research Scientist'
WHERE job_title LIKE '%Ai Research Scientist%';

SELECT * FROM JOBS_STAGING 
WHERE job_title LIKE '%Ai/Ml Engineer%';

UPDATE JOBS_STAGING JS
SET job_title = 'Machine Learning Engineer'
WHERE job_title LIKE '%Ai/Ml Engineer%';

SELECT * FROM jobs_staging
WHERE job_title LIKE '%It Ops Engineer%';

DELETE FROM jobs_staging
WHERE job_id IN(9877, 10578, 827, 28863, 21133, 30321, 17128);

UPDATE JOBS_STAGING JS
SET job_title = 'Machine Learning Engineer'
WHERE job_title LIKE '%Ml Ops Engineer%';

UPDATE JOBS_STAGING JS
SET job_title = 'Devops Engineer'
WHERE job_title LIKE '%Jr. Dev Ops Engineer%';

UPDATE JOBS_STAGING JS
SET job_title = 'Machine Learning Engineer'
WHERE job_title LIKE '%Ai/Ml Engineer%';


SELECT * FROM jobs_staging
WHERE job_title LIKE '%Marketing%' AND job_title NOT IN ('Digital Marketing Manager', 'Marketing Manager',
				'Assistant Marketing Manager');

SELECT job_title, count(*) FROM jobs_staging
GROUP BY job_title;

SELECT job_title FROM JOBS_STAGING
WHERE job_title LIKE '%aws%';


SELECT job_title FROM JOBS_STAGING JS
WHERE job_title LIKE '%Engineer%' AND job_title NOT IN ('Cloud Engineer', 'Cloud Engineer', 'Civil Engineer');


UPDATE JOBS_STAGING JS
SET job_title = 'Front End Developer'
WHERE job_title LIKE '%Front%' AND job_title LIKE '%End%' AND job_title NOT IN ('Front End Developer');

UPDATE JOBS_STAGING JS
SET job_title = 'Frontend Developer'
WHERE job_title = 'Front End Developer';

SELECT job_title FROM JOBS_STAGING JS
WHERE job_title LIKE '%Frontend%';


SELECT job_title FROM JOBS_STAGING JS
WHERE job_title LIKE '%Front%' AND job_title LIKE '%End%' AND job_title NOT IN ('Front End Developer');

CREATE TABLE backup_jobs_1 AS
SELECT * FROM jobs_staging;

CREATE TABLE backup_jobs_2 AS
SELECT * FROM jobs_staging;

UPDATE JOBS_STAGING JS
SET job_title = 'Accounts Manager'
WHERE job_title LIKE '%Account%';

UPDATE JOBS_STAGING JS
SET job_title = 'Chemical Engineer'
WHERE job_title LIKE '%Chemical%';


UPDATE JOBS_STAGING JS
SET job_title = 'Content Editor'
WHERE job_title LIKE '%Editor%';


UPDATE JOBS_STAGING JS
SET job_title = 'Digital Marketing Manager'
WHERE job_title = 'Digital Marketing Specialist';


UPDATE JOBS_STAGING JS
SET job_title = 'Marketing Manager'
WHERE job_title = ;


UPDATE JOBS_STAGING JS
SET job_title = 'Marketing Manager'
WHERE job_title IN ('Marketing Executive', 'Manager, F&B Marketing, India', 'Marketing Coordinator',
				'Marketing Director', 'Email Marketing Specialist', 'Marketing Communications Manager');	



SELECT company_name FROM jobs_staging;


SELECT company_name, COUNT(*) FROM jobs_staging
GROUP BY company_name
ORDER BY COUNT(*) DESC;

SELECT job_title, company_name FROM jobs_staging

WHERE company_name IS NULL OR company_name = '';

UPDATE JOBS_STAGING JS
SET company_name = 'Unknown'
WHERE company_name IS NULL OR company_name = '';

SELECT company_name FROM jobs_staging
WHERE seniority_level  IS NULL OR seniority_level  = '';

UPDATE JOBS_STAGING JS
SET seniority_level = 'Not Specified'
WHERE seniority_level IS NULL OR seniority_level  = '';

UPDATE JOBS_STAGING JS
SET seniority_level = 'Intern'
WHERE seniority_level = 'Internship';

UPDATE JOBS_STAGING JS
SET seniority_level = 'Unknown'
WHERE seniority_level IN ('Full-Time', 'Contract', 'Part-Time', 'Volunteer');

SELECT seniority_level, count(*) FROM JOBS_STAGING JS 
GROUP BY seniority_level
ORDER BY count(*) DESC ;

SELECT job_function, count(*) FROM JOBS_STAGING JS 
GROUP BY job_function
ORDER BY count(*) DESC ;

UPDATE JOBS_STAGING JS 
SET job_function = 'Not Stated'
WHERE job_function = 'Other';


UPDATE JOBS_STAGING JS 
SET hiring_status = initcap(LOWER(TRIM(hiring_status)));

SELECT hiring_status FROM JOBS_STAGING JS 
WHERE hiring_status LIKE 'Actively Hiring %';

UPDATE JOBS_STAGING JS 
SET hiring_status = 'Actively Hiring'
WHERE hiring_status LIKE 'Actively Hiring %';

UPDATE JOBS_STAGING JS 
SET hiring_status = 'Actively Hiring'
WHERE hiring_status = 'Actively Hiring           +4�Benefits';

UPDATE JOBS_STAGING JS 
SET hiring_status = 'Unknown'
WHERE hiring_status LIKE 'Medical Insurance %';

UPDATE JOBS_STAGING JS 
SET hiring_status = 'Unknown'
WHERE hiring_status LIKE 'Be An Early Applicant %' OR hiring_status = 'Be An Early Applicant';

SELECT employment_type, count(*) FROM JOBS_STAGING JS 
GROUP BY  employment_type
ORDER BY count(*) DESC ;

SELECT employment_type FROM JOBS_STAGING JS 
WHERE employment_type = '';


UPDATE JOBS_STAGING JS 
SET employment_type = 'Unknown'
WHERE employment_type = '';


UPDATE JOBS_STAGING JS 
SET employment_type = 'Full-Time'
WHERE employment_type LIKE 'Employment Type % Full-Time';

UPDATE JOBS_STAGING JS 
SET employment_type = 'Internship'
WHERE employment_type LIKE 'Employment Type % Internship';


UPDATE JOBS_STAGING JS 
SET employment_type = 'Part-Time'
WHERE employment_type LIKE 'Employment Type % Part-Time';

SELECT city, count(*) FROM JOBS_STAGING JS 
GROUP BY city
ORDER BY count(*) DESC ;

SELECT city FROM JOBS_STAGING JS 
WHERE city = '';

UPDATE JOBS_STAGING JS 
SET city = 'Munster'
WHERE location LIKE '%M%Nster, North Rhine-Westphalia, Germany%';


SELECT state, count(*) FROM JOBS_STAGING JS 
GROUP BY state
ORDER BY count(*) DESC ;

UPDATE JOBS_STAGING JS 
SET city=  initcap(LOWER(TRIM(city))),
	state =  initcap(LOWER(TRIM(state))),
	country=  initcap(LOWER(TRIM(country)));


SELECT city, state, country FROM JOBS_STAGING JS 
WHERE LOWER(TRIM(city)) IN ('ny', 'new york');

SELECT LOCATION, city, state, country FROM JOBS_STAGING JS
WHERE state NOT IN('Texas', 'California', 'Indiana', 'New York', 'Illinois', 'Tennessee',
		'Massachusetts', 'Ohio', 'West Bengal', 'New Jersey', 'Maryland', 'Indiana',
		'Colorado', 'Pennsylvania', 'Arkansas', 'Nebraska', 'Nevada');

SELECT LOCATION, city, state, country FROM JOBS_STAGING JS
WHERE country NOT IN('USA');

SELECT LOCATION, city, state, country FROM JOBS_STAGING JS
WHERE location = 'Cambridge, Ma';

UPDATE JOBS_STAGING JS 
SET	country = 'Switzerland',
	state = NULL
WHERE state = 'Switzerland' AND country ='Swland';

UPDATE JOBS_STAGING JS 
SET city = 'San Francisco Bay Area',
	state = NULL,
	country = 'USA'
WHERE location = 'San Francisco Bay Area';


UPDATE JOBS_STAGING JS 
SET state = NULL,
	city = 'Washington DC',
	country = 'USA'
WHERE location LIKE '%Washington%';



UPDATE JOBS_STAGING JS 
SET country = 'Unknown'
WHERE country IS NULL;


SELECT city, count(*) FROM  JOBS_STAGING JS 
GROUP BY city
ORDER BY count(*) DEsc;

SELECT state, count(*) FROM  JOBS_STAGING JS 
GROUP BY state
ORDER BY count(*) DEsc;

SELECT country, count(*) FROM  JOBS_STAGING JS 
GROUP BY country
ORDER BY count(*) DEsc;



SELECT LOCATION, city, state, country FROM JOBS_STAGING JS 
WHERE LOCATION LIKE ('%Location%');

SELECT * FROM JOBS_STAGING JS 
LIMIT 3;

CREATE TABLE jobs_final_backup AS
SELECT * FROM JOBS_STAGING;

SELECT * FROM JOBS_STAGING JS 
LIMIT 3;


ALTER TABLE JOBS_STAGING
DROP COLUMN location;


SELECT company_name, count(*) FROM JOBS_STAGING JS 
GROUP BY COMPANY_NAME 
ORDER BY count(*) DESC;

--Tech Jobs 
SELECT industry FROM JOBS_STAGING JS 
WHERE industry LIKE '%Technology%' OR industry LIKE '%Software%';
GROUP BY industry;


SELECT industry, country FROM JOBS_STAGING
	WHERE industry IN (
		SELECT industry FROM JOBS_STAGING JS 
		WHERE industry LIKE '%Technology%' OR industry LIKE '%Software%' OR industry LIKE '%It Services%'
		OR industry LIKE '%Computer%' OR industry LIKE '%Graphic%'
		GROUP BY industry
	)
GROUP BY INDUSTRY ;



SELECT industry, country, COUNT(*) FROM JOBS_STAGING JS 
	WHERE industry LIKE '%Technology%' OR industry LIKE '%Software%' OR industry LIKE '%It Services%'
	OR industry LIKE '%Computer%' OR industry LIKE '%Graphic%'
	GROUP BY industry, country
	ORDER BY COUNT(*) DESC;

SET search_path TO tech_career_analysis;

SELECT * FROM removed_duplicates_jobs LIMIT 3;


-- Active Jobs
SELECT count(*) FROM removed_duplicates_jobs
WHERE hiring_status = 'Actively Hiring';

--Top Hiring Industry
SELECT industry COUNT(*) FROM removed_duplicates_jobs
GROUP BY industry
ORDER BY COUNT(*) DESC;
