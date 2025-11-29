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

INSERT INTO course_layout (
    course_code, course_name,
    min_students, max_students, hp,
    start_date, end_date
)
VALUES
('CS101', 'Intro to Programming', 10, 60, 7.5, '2024-01-10', '2024-03-10'),
('CS201', 'Algorithms',            5, 40, 7.5, '2024-02-10', '2024-04-10'),
('CS301', 'Databases',             5, 45, 7.5, '2024-03-10', '2024-05-10'),
('CS401', 'Machine Learning',      5, 35, 7.5, '2024-04-10', '2024-06-10'),
('MATH101', 'Calculus I',         10, 50, 7.5, '2024-01-15', '2024-03-15');

INSERT INTO course_instance (instance_id, num_students, course_layout_id, study_period, study_year)
VALUES
('CS101-2025-P1', 45, 1, 'P1', '2025-01-01'),
('CS201-2025-P2', 30, 2, 'P2', '2025-01-01'),
('CS301-2025-P3', 38, 3, 'P3', '2025-01-01'),
('CS401-2025-P4', 25, 4, 'P4', '2025-01-01'),
('MATH101-2025-P1', 52, 5, 'P1', '2025-01-01'),
('CS201-2024-P2', 30, 2, 'P2', '2024-01-01');

INSERT INTO teaching_activity (activity_name, factor)
VALUES
('Lecture', 1.0),
('Seminar', 2.0),
('Lab', 3.0),
('Exam', 1.0),
('Admin', 1.0);

INSERT INTO planned_activity (
    teaching_activity_id, instance_id,
    planned_hours
)
VALUES 
(1, 'CS101-2025-P1', 20),
(2, 'CS101-2025-P1', 10),
(3, 'CS101-2025-P1', 15),
(4, 'CS101-2025-P1', 64.625),
(5, 'CS101-2025-P1', 52),
(1, 'CS201-2025-P2', 24),
(3, 'CS201-2025-P2', 18),
(4, 'CS201-2025-P2', 53.75),
(5, 'CS201-2025-P2', 49),
(1, 'CS301-2025-P3', 20),
(2, 'CS301-2025-P3', 12),
(3, 'CS301-2025-P3', 20),
(4, 'CS301-2025-P3', 59.55),
(5, 'CS301-2025-P3', 50.6),
(1, 'CS401-2025-P4', 18),
(3, 'CS401-2025-P4', 25),
(4, 'CS401-2025-P4', 50.125),
(5, 'CS401-2025-P4', 48),
(1, 'MATH101-2025-P1', 30),
(2, 'MATH101-2025-P1', 15),
(4, 'MATH101-2025-P1', 69.7),
(5, 'MATH101-2025-P1', 53.4),
(3, 'CS201-2024-P2', 12),
(4, 'CS201-2024-P2', 53.75),
(5, 'CS201-2024-P2', 49);

INSERT INTO employee_planned_activity (employee_id, teaching_activity_id, instance_id)
VALUES
(1, 1, 'CS101-2025-P1'),
(2, 2, 'CS101-2025-P1'),
(3, 3, 'CS101-2025-P1'),
(1, 4, 'CS101-2025-P1'),
(1, 5, 'CS101-2025-P1'),
(1, 1, 'CS201-2025-P2'),
(2, 3, 'CS201-2025-P2'),
(1, 4, 'CS201-2025-P2'),
(2, 5, 'CS201-2025-P2'),
(2, 1, 'CS301-2025-P3'),
(3, 2, 'CS301-2025-P3'),
(3, 3, 'CS301-2025-P3'),
(2, 4, 'CS301-2025-P3'),
(3, 5, 'CS301-2025-P3'),
(1, 1, 'CS401-2025-P4'),
(1, 4, 'CS401-2025-P4'),
(1, 5, 'CS401-2025-P4'),
(1, 1, 'MATH101-2025-P1'),
(3, 2, 'MATH101-2025-P1'),
(1, 4, 'MATH101-2025-P1'),
(3, 5, 'MATH101-2025-P1'),
(3, 3, 'CS201-2024-P2'),
(3, 4, 'CS201-2024-P2'),
(3, 5, 'CS201-2024-P2');

INSERT INTO allocations (employee_id, instance_id, allocated_hours, max_num_allocations, num_allocations)
VALUES
(1, 'CS101-2025-P1', 20, 30, 1),
(1, 'CS201-2025-P2', 24, 30, 1),
(1, 'CS401-2025-P4', 18, 30, 1),
(1, 'MATH101-2025-P1', 30, 30, 1),
(2, 'CS101-2025-P1', 10, 25, 1),
(2, 'CS201-2025-P2', 18, 25, 1),
(2, 'CS301-2025-P3', 20, 25, 1),
(3, 'CS101-2025-P1', 15, 20, 1),
(3, 'CS301-2025-P3', 32, 20, 2),
(3, 'CS201-2024-P2', 12, 20, 1),
(3, 'MATH101-2025-P1', 15, 20, 1);

INSERT INTO salary (employee_id, salary, start_date, end_date)
VALUES
(1, 45000, '2022-01-01', '2023-01-01'),
(1, 47000, '2023-01-02', '2024-01-01'),
(1, 50000, '2024-01-02', '2025-01-01'),
(2, 38000, '2022-01-01', '2023-01-01'),
(2, 40000, '2023-01-02', '2024-01-01'),
(2, 42000, '2024-01-02', '2025-01-01'),
(3, 30000, '2022-01-01', '2023-01-01'),
(3, 32000, '2023-01-02', '2024-01-01'),
(3, 35000, '2024-01-02', '2025-01-01');