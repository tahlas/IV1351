CREATE TABLE employee(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    employment_id VARCHAR(500) UNIQUE,
    salary INT,
    supervisor/manager VARCHAR(500),
    department_id INT GENERATED ALWAYS AS IDENTITY,
    person_id INT GENERATED ALWAYS AS IDENTITY,
    job_title_id INT GENERATED ALWAYS AS IDENTITY
);

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
    manager VARCHAR(500) UNIQUE, 
);

CREATE TABLE job_title(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    job_title VARCHAR(500) UNIQUE,
);

CREATE TABLE employee_skill(
    employee_id INTEGER NOT NULL,
    skill_id INTEGER NOT NULL,
    PRIMARY KEY (employee_id, skill_id),
    FOREIGN KEY (employee_id) REFERENCES employee(id),
    FOREIGN KEY (skill_id) REFERENCES skill(id)   
);

CREATE TABLE skill(
    id  INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    skill_name VARCHAR(500),
);

CREATE TABLE course_layout(
    id  INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    course_code VARCHAR(10) UNIQUE,
    course_name VARCHAR(500),
    min_students INT,
    max_students INT,
    hp FLOAT(5)
);

CREATE TABLE course_instance(
    instance_id VARCHAR(200) UNIQUE PRIMARY KEY,
    num_students INT,
    course_layout_id INT GENERATED ALWAYS AS IDENTITY Foreign Key () REFERENCES (),
    study_period VARCHAR(10),
    study_year TIMESTAMP(4),
);

CREATE TABLE planned_activity(
    /*Add foreign keys here!*/
    planned_hours INT
);

CREATE TABLE teaching_activity(
    id  INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    activity_name VARCHAR(500) UNIQUE,
    factor FLOAT(5)
);

CREATE TABLE employee_planed_activity(
    /*Add foreign keys here!*/
);


