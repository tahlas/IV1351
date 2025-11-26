SELECT course_name, course_code, hp, study_period, num_students FROM course_layout 
JOIN course_instance ON course_layout.id = course_instance.course_layout_id
JOIN planned_activity ON course_instance.instance_id = planned_activity.instance_id
JOIN teaching_activity ON planned_activity.teaching_activity_id = teaching_activity.id;
