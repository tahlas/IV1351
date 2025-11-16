DROP TABLE IF EXISTS employee_planned_activity;
DROP TABLE IF EXISTS planned_activity;
DROP TABLE IF EXISTS employee_skill;
DROP TABLE IF EXISTS skill;
DROP TABLE IF EXISTS employee;
DROP TABLE IF EXISTS job_title;
DROP TABLE IF EXISTS department;
DROP TABLE IF EXISTS person;
DROP TABLE IF EXISTS course_instance;
DROP TABLE IF EXISTS course_layout;
DROP TABLE IF EXISTS teaching_activity;

CREATE TABLE person(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    personal_number VARCHAR(12) UNIQUE,
    first_name VARCHAR(500),
    last_name VARCHAR(500),
    phone_number VARCHAR(500),
    zip VARCHAR(500),
    street VARCHAR(500),
    city VARCHAR(500)
);

CREATE TABLE department(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    department_name VARCHAR(500),
    manager VARCHAR(500) UNIQUE
);

CREATE TABLE job_title(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    job_title VARCHAR(500) UNIQUE
);

CREATE TABLE employee(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    employment_id VARCHAR(500) UNIQUE,
    salary INT,
    manager VARCHAR(500),

    department_id INT,
    person_id INT,
    job_title_id INT,

    FOREIGN KEY (department_id) REFERENCES department(id),
    FOREIGN KEY (person_id) REFERENCES person(id),
    FOREIGN KEY (job_title_id) REFERENCES job_title(id)
);

CREATE TABLE skill(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    skill_name VARCHAR(500)
);

CREATE TABLE employee_skill(
    employee_id INT,
    skill_id INT,
    PRIMARY KEY (employee_id, skill_id),
    FOREIGN KEY (employee_id) REFERENCES employee(id),
    FOREIGN KEY (skill_id) REFERENCES skill(id)   
);

CREATE TABLE course_layout(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    course_code VARCHAR(10) UNIQUE,
    course_name VARCHAR(500),
    min_students INT,
    max_students INT,
    hp FLOAT(5)
);

CREATE TABLE course_instance(
    instance_id VARCHAR(200) UNIQUE PRIMARY KEY,
    num_students INT,
    course_layout_id INT,
    Foreign Key (course_layout_id) REFERENCES course_layout(id),
    study_period VARCHAR(10),
    study_year TIMESTAMP(4),
);

CREATE TABLE planned_activity(
    teaching_activity_id INT,
    instance_id VARCHAR(200),

    planned_hours INT,
    PRIMARY KEY(teaching_activity_id, instance_id)
);

CREATE TABLE teaching_activity(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    activity_name VARCHAR(500) UNIQUE,
    factor FLOAT(5)
);

CREATE TABLE employee_planned_activity(
    PRIMARY KEY (employee_id, teaching_activity_id, instance_id),

    employee_id INT,
    teaching_activity_id INT,
    instance_id VARCHAR(200),

    FOREIGN KEY (employee_id) REFERENCES employee(id),
    FOREIGN KEY (teaching_activity_id) REFERENCES teaching_activity(id),
    FOREIGN KEY (instance_id) REFERENCES course_instance(instance_id)
);


