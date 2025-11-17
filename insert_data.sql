INSERT INTO department (department_name, manager)
VALUES
('Computer Science', 'mgr1'),
('Mathematics', 'mgr2'),
('Physics', 'mgr3');

INSERT INTO job_title (job_title)
VALUES ('Professor'), ('Lecturer'), ('Teaching Assistant');

INSERT INTO person (personal_number, first_name, last_name, phone_number, zip, street, city)
VALUES
('199001019999', 'Alice', 'Johnson', '0701234567', '12345', 'First Street 1', 'Uppsala'),
('198506209888', 'Bob', 'Smith', '0709876543', '54321', 'Second Street 5', 'Stockholm'),
('197712159777', 'Carol', 'Andersson', '0701112223', '11122', 'Third Street 9', 'Gothenburg');

INSERT INTO employee (employment_id, salary, manager, department_id, person_id, job_title_id)
VALUES
('E001', 45000, 'mgr1', 1, 1, 1),
('E002', 38000, 'mgr1', 1, 2, 2),
('E003', 30000, 'mgr2', 2, 3, 3);

INSERT INTO skill (skill_name)
VALUES ('Python'), ('Java'), ('Machine Learning');

INSERT INTO employee_skill (employee_id, skill_id)
VALUES
(1, 1),
(1, 3),
(2, 2);

INSERT INTO course_layout (course_code, course_name, min_students, max_students, hp, start_date)
VALUES
('CS101', 'Introduction to Programming', 10, 60, 7.5, '2024-01-15'),
('CS102', 'Data Structures',            10, 50, 7.5, '2024-02-01'),
('CS201', 'Algorithms',                  5, 40, 7.5, '2024-03-10'),
('CS202', 'Operating Systems',           5, 45, 7.5, '2024-04-05'),
('CS301', 'Database Systems',            5, 40, 7.5, '2024-05-20'),
('CS302', 'Computer Networks',           5, 40, 7.5, '2024-06-10'),
('CS303', 'Machine Learning',            5, 30, 10.0, '2024-07-01'),
('CS304', 'Software Engineering',       10, 60, 7.5, '2024-08-15');

INSERT INTO course_instance (instance_id, num_students, course_layout_id, study_period, study_year)
VALUES
('CS101-2024-P1', 45, 1, 'P1', '2024-01-01'),
('CS201-2024-P2', 30, 2, 'P2', '2024-01-01');

INSERT INTO teaching_activity (activity_name, factor)
VALUES
('Lecture', 1.0),
('Seminar', 0.5),
('Lab', 0.7);

INSERT INTO planned_activity (teaching_activity_id, instance_id, planned_hours)
VALUES
(1, 'CS101-2024-P1', 20),
(2, 'CS101-2024-P1', 10),
(3, 'CS201-2024-P2', 15);

INSERT INTO employee_planned_activity (employee_id, teaching_activity_id, instance_id)
VALUES
(1, 1, 'CS101-2024-P1'),
(2, 2, 'CS101-2024-P1'),
(3, 3, 'CS201-2024-P2');

INSERT INTO allocations (employee_id, instance_id, allocated_hours, max_num_allocations, num_allocations)
VALUES
(1, 'CS101-2024-P1', 10, 20, 1),
(2, 'CS101-2024-P1', 8,  15, 1),
(3, 'CS201-2024-P2', 12, 25, 2);
