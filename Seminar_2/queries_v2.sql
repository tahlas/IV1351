-- SELECT course_name, course_code, hp, study_period, num_students 
-- FROM course_layout 
-- JOIN course_instance ON course_layout.id = course_instance.course_layout_id
-- JOIN planned_activity ON course_instance.instance_id = planned_activity.instance_id
-- JOIN teaching_activity ON planned_activity.teaching_activity_id = teaching_activity.id
-- WHERE EXTRACT(YEAR FROM course_instance.study_year) = EXTRACT(YEAR FROM CURRENT_DATE)
-- GROUP BY course.course_code, course_instance.instance_id, 
-- course_layout.hp, course_instance.study_period, course_instance.num_students;

-- SELECT instance_id, SUM(planned_hours) FILTER (WHERE activity_name = 'Lecture') as Lecture_Hours,
-- SUM(planned_hours * factor) FILTER (WHERE activity_name = 'Tutorial') as Tutorial_Hours,
-- SUM(planned_hours * factor) FILTER (WHERE activity_name = 'Lab') as Lab_Hours,
-- SUM(planned_hours * factor) FILTER (WHERE activity_name = 'Seminar') as Seminar_Hours,
-- SUM(planned_hours * factor) FILTER (WHERE activity_name = 'Admin') as Admin,
-- SUM(planned_hours * factor) FILTER (WHERE activity_name = 'Exam') as Exam,
-- SUM(planned_hours * factor) as Total,
-- SUM(planned_hours * factor) FILTER (WHERE activity_name NOT IN ('Lecture', 'Tutorial', 'Lab', 'Seminar', 'Admin', 'Exam')) as Other
-- FROM planned_activity
-- FULL OUTER JOIN teaching_activity ON planned_activity.teaching_activity_id = teaching_activity.id
-- GROUP BY instance_id;

DROP VIEW teacher_hours;
DROP VIEW course_information;
CREATE VIEW teacher_hours AS
SELECT instance_id, COALESCE(SUM(planned_hours) FILTER (WHERE activity_name = 'Lecture'),0) as Lecture_Hours,
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
FROM course_layout RIGHT OUTER JOIN course_instance ON course_layout.id = course_instance.course_layout_id;


SELECT instance_id, course_code, hp, study_period, num_students, exam, admin, lecture_hours, tutorial_hours, lab_hours, seminar_hours,  (total + totalAdminExam) AS total, other
FROM course_information
FULL OUTER JOIN teacher_hours USING(instance_id);