 -- QUERY 1

DROP VIEW teacher_hours;
DROP VIEW course_information;
CREATE VIEW teacher_hours AS
SELECT instance_id, 
COALESCE(SUM(planned_hours * factor) FILTER (WHERE activity_name = 'Lecture'),0) as Lecture_Hours,
COALESCE(SUM(planned_hours * factor) FILTER (WHERE activity_name = 'Tutorial'),0) as Tutorial_Hours,
COALESCE(SUM(planned_hours * factor) FILTER (WHERE activity_name = 'Lab'),0) as Lab_Hours,
COALESCE(SUM(planned_hours * factor) FILTER (WHERE activity_name = 'Seminar'),0) as Seminar_Hours,
COALESCE(SUM(planned_hours * factor),0) as Total,
COALESCE(SUM(planned_hours * factor) FILTER (WHERE activity_name NOT IN ('Lecture', 'Tutorial', 'Lab', 'Seminar')),0) as Other
FROM planned_activity
FULL OUTER JOIN teaching_activity ON planned_activity.teaching_activity_id = teaching_activity.id
GROUP BY instance_id;

CREATE VIEW course_information AS SELECT instance_id, course_code, hp, study_period, num_students
, (32+0.725*num_students) AS exam, (2*hp+28+0.2*num_students) 
AS admin, (2*hp+28+0.2*num_students+32+0.725*num_students) AS totalAdminExam 
FROM course_layout RIGHT OUTER JOIN course_instance  ON course_layout.id = course_instance.course_layout_id 
WHERE EXTRACT(YEAR FROM course_instance.study_year) = EXTRACT(YEAR FROM CURRENT_DATE);

SELECT instance_id, course_code, hp, study_period, num_students, exam, admin, lecture_hours, tutorial_hours, lab_hours, seminar_hours,  (total + totalAdminExam) AS total, other
FROM course_information
LEFT OUTER JOIN teacher_hours USING(instance_id);
-- QUERY 2
SELECT course_code, course_instance.instance_id, hp, first_name, last_name, job_title,  (32+0.725*num_students) AS exam, (2*hp+28+0.2*num_students) 
AS admin,
 COALESCE(SUM(planned_hours  * factor)   FILTER (WHERE activity_name = 'Lecture'),0) as Lecture_Hours,
COALESCE(SUM(planned_hours * factor) FILTER (WHERE activity_name = 'Tutorial'),0) as Tutorial_Hours,
COALESCE(SUM(planned_hours * factor) FILTER (WHERE activity_name = 'Lab'),0) as Lab_Hours,
COALESCE(SUM(planned_hours * factor) FILTER (WHERE activity_name = 'Seminar'),0) as Seminar_Hours,
COALESCE(SUM(planned_hours  * factor)   FILTER (WHERE activity_name = 'Admin'),0) as Lecture_Hours,
COALESCE(SUM(planned_hours * factor) FILTER (WHERE activity_name = 'Exam'),0) as Tutorial_Hours,
COALESCE(SUM(planned_hours * factor),0) as Total,
COALESCE(SUM(planned_hours * factor) FILTER (WHERE activity_name NOT IN ('Lecture', 'Tutorial', 'Lab', 'Seminar')),0) as Other
FROM course_instance 
INNER JOIN course_layout ON course_instance.course_layout_id = course_layout.id 
INNER JOIN employee_planned_activity ON  employee_planned_activity.instance_id = course_instance.instance_id 
INNER JOIN planned_activity ON planned_activity.instance_id = course_instance.instance_id 
INNER JOIN teaching_activity ON employee_planned_activity.teaching_activity_id = teaching_activity.id
INNER JOIN employee ON employee_planned_activity.employee_id = employee.id 
INNER JOIN person ON employee.person_id = person.id 
INNER JOIN job_title ON employee.job_title_id = job_title.id 
WHERE EXTRACT(YEAR FROM course_instance.study_year) = EXTRACT(YEAR FROM CURRENT_DATE)
GROUP BY 
course_code,
course_instance.instance_id,
hp,
first_name,
last_name,
job_title;




SELECT course_code, course_instance.instance_id, hp, first_name, last_name, job_title,  (32+0.725*num_students) AS exam, (2*hp+28+0.2*num_students) 
AS admin,
 COALESCE(SUM(planned_hours  * factor)   FILTER (WHERE activity_name = 'Lecture'),0) as Lecture_Hours,
COALESCE(SUM(planned_hours * factor) FILTER (WHERE activity_name = 'Tutorial'),0) as Tutorial_Hours,
COALESCE(SUM(planned_hours * factor) FILTER (WHERE activity_name = 'Lab'),0) as Lab_Hours,
COALESCE(SUM(planned_hours * factor) FILTER (WHERE activity_name = 'Seminar'),0) as Seminar_Hours,
COALESCE(SUM(planned_hours  * factor)   FILTER (WHERE activity_name = 'Admin'),0) as Lecture_Hours,
COALESCE(SUM(planned_hours * factor) FILTER (WHERE activity_name = 'Exam'),0) as Tutorial_Hours,
(COALESCE(SUM(planned_hours * factor),0)  + (32+0.725*num_students) +  (2*hp+28+0.2*num_students) ) as Total,
COALESCE(SUM(planned_hours * factor) FILTER (WHERE activity_name NOT IN ('Lecture', 'Tutorial', 'Lab', 'Seminar')),0) as Other
FROM course_instance 
INNER JOIN course_layout ON course_instance.course_layout_id = course_layout.id 
INNER JOIN employee_planned_activity ON  employee_planned_activity.instance_id = course_instance.instance_id 
INNER JOIN planned_activity ON planned_activity.instance_id = course_instance.instance_id 
INNER JOIN teaching_activity ON employee_planned_activity.teaching_activity_id = teaching_activity.id
INNER JOIN employee ON employee_planned_activity.employee_id = employee.id 
INNER JOIN person ON employee.person_id = person.id 
INNER JOIN job_title ON employee.job_title_id = job_title.id 
WHERE EXTRACT(YEAR FROM course_instance.study_year) = EXTRACT(YEAR FROM CURRENT_DATE)
GROUP BY 
course_code,
course_instance.instance_id,
hp,
first_name,
last_name,
job_title;

