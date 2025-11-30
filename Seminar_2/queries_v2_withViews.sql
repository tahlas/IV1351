-- VIEW FOR QUERY 1
DROP VIEW  v_course_hours;
CREATE VIEW v_course_hours AS
SELECT course_instance.instance_id, course_code, hp, study_period, num_students,study_year,
COALESCE(SUM(planned_hours * factor) FILTER (WHERE activity_name = 'Lecture' ), 0) as Lecture_Hours,
COALESCE(SUM(planned_hours * factor) FILTER (WHERE activity_name = 'Tutorial'), 0) as Tutorial_Hours,
COALESCE(SUM(planned_hours * factor) FILTER (WHERE activity_name = 'Lab'     ), 0) as Lab_Hours,
COALESCE(SUM(planned_hours * factor) FILTER (WHERE activity_name = 'Seminar' ), 0) as Seminar_Hours,
(32+0.725*num_students) AS exam,
(2*hp+28+0.2*num_students) AS admin,
COALESCE(SUM(planned_hours * factor) FILTER (WHERE activity_name NOT IN ('Lecture', 'Tutorial', 'Lab', 'Seminar')),0) as Other,
COALESCE(SUM(planned_hours * factor ) +(32+0.725*num_students) +  (2*hp+28+0.2*num_students)  ,0) as Total
FROM course_instance 
INNER JOIN course_layout ON course_instance.course_layout_id = course_layout.id 
INNER JOIN planned_activity ON planned_activity.instance_id = course_instance.instance_id 
INNER JOIN teaching_activity ON planned_activity.teaching_activity_id = teaching_activity.id
GROUP BY course_instance.instance_id,
 course_code, hp,
study_period, 
num_students;

-- QUERY 1
SELECT instance_id, course_code, hp, study_period, num_students, Lecture_Hours,Tutorial_Hours,Lab_Hours,Seminar_Hours, exam,admin, Other, Total
FROM v_course_hours
WHERE EXTRACT(YEAR FROM study_year) = EXTRACT(YEAR FROM CURRENT_DATE);

-- VIEW FOR QUERY 2 AND 3
DROP VIEW  v_teaching_hours;
CREATE VIEW v_teaching_hours AS
SELECT course_code, course_instance.instance_id, hp, study_period, first_name, last_name, job_title, study_year, 
COALESCE(SUM(planned_hours * factor) FILTER (WHERE activity_name = 'Lecture' ), 0) as Lecture_Hours,
COALESCE(SUM(planned_hours * factor) FILTER (WHERE activity_name = 'Tutorial'), 0) as Tutorial_Hours,
COALESCE(SUM(planned_hours * factor) FILTER (WHERE activity_name = 'Lab'     ), 0) as Lab_Hours,
COALESCE(SUM(planned_hours * factor) FILTER (WHERE activity_name = 'Seminar' ), 0) as Seminar_Hours,
COALESCE(SUM(planned_hours * factor) FILTER (WHERE activity_name = 'Exam'    ), 0) as Exam_Hours,
COALESCE(SUM(planned_hours * factor) FILTER (WHERE activity_name = 'Admin'   ), 0) as Admin_Hours,
COALESCE(SUM(planned_hours * factor) FILTER (WHERE activity_name NOT IN ('Lecture', 'Tutorial', 'Lab', 'Seminar', 'Exam', 'Admin')),0) as Other,
COALESCE(SUM(planned_hours * factor), 0 ) as Total
FROM course_instance 
INNER JOIN course_layout ON course_instance.course_layout_id = course_layout.id 
INNER JOIN planned_activity ON planned_activity.instance_id = course_instance.instance_id 
INNER JOIN teaching_activity ON planned_activity.teaching_activity_id = teaching_activity.id
INNER JOIN employee_planned_activity ON  employee_planned_activity.instance_id = course_instance.instance_id AND employee_planned_activity.teaching_activity_id = planned_activity.teaching_activity_id  /* Important to use the AND here, otherwise every employee gets connected to every activity for the course, instead of their assigned activities */
INNER JOIN employee ON employee_planned_activity.employee_id = employee.id 
INNER JOIN person ON employee.person_id = person.id 
INNER JOIN job_title ON employee.job_title_id = job_title.id 
GROUP BY 
course_code,
course_instance.instance_id,
hp,
study_period,
first_name,
last_name,
job_title;

-- QUERY 2
SELECT course_code, instance_id , hp, first_name, last_name, job_title, Lecture_Hours, Tutorial_Hours,Lab_Hours,Seminar_Hours,Exam_Hours,Admin_Hours, Other,Total
FROM v_teaching_hours
WHERE course_code = 'CS101' AND EXTRACT(YEAR FROM study_year) = EXTRACT(YEAR FROM CURRENT_DATE);

-- QUERY 3
SELECT course_code, instance_id , hp, study_period, first_name, last_name, job_title, Lecture_Hours, Tutorial_Hours,Lab_Hours,Seminar_Hours,Exam_Hours,Admin_Hours, Other,Total
FROM v_teaching_hours
WHERE EXTRACT(YEAR FROM study_year) = EXTRACT(YEAR FROM CURRENT_DATE) 
      AND CONCAT(first_name, ' ', last_name) = 'Bob Smith';

-- QUERY 4
SELECT employment_id, first_name, last_name, study_period,
COUNT (*) as allocations
FROM allocations INNER JOIN employee ON allocations.employee_id = employee.id
INNER JOIN person ON person.id = employee.person_id
INNER JOIN course_instance ON allocations.instance_id = course_instance.instance_id
WHERE EXTRACT(YEAR FROM course_instance.study_year) = EXTRACT(YEAR FROM CURRENT_DATE) 
AND course_instance.study_period ~ CAST(EXTRACT(QUARTER FROM CURRENT_DATE) AS VARCHAR)
GROUP BY 
employment_id, 
first_name,
last_name,
study_period;
HAVING COUNT(*) > 0; 