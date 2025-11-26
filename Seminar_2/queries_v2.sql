SELECT course_name, course_code, hp, study_period, num_students 
FROM course_layout 
JOIN course_instance ON course_layout.id = course_instance.course_layout_id
JOIN planned_activity ON course_instance.instance_id = planned_activity.instance_id
JOIN teaching_activity ON planned_activity.teaching_activity_id = teaching_activity.id
WHERE EXTRACT(YEAR FROM course_instance.study_year) = EXTRACT(YEAR FROM CURRENT_DATE)
GROUP BY course.course_code, course_instance.instance_id, 
course_layout.hp, course_instance.study_period, course_instance.num_students;