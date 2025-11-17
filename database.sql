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

    personal_number VARCHAR(12) UNIQUE NOT NULL,
    first_name VARCHAR(500) NOT NULL,
    last_name VARCHAR(500) NOT NULL,
    phone_number VARCHAR(500),
    zip VARCHAR(500) NOT NULL,
    street VARCHAR(500) NOT NULL,
    city VARCHAR(500) NOT NULL
);

CREATE TABLE department(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    department_name VARCHAR(500) UNIQUE NOT NULL,
    manager VARCHAR(500) NOT NULL
);

CREATE TABLE job_title(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    job_title VARCHAR(500) UNIQUE NOT NULL
);

CREATE TABLE employee(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    employment_id VARCHAR(500) UNIQUE NOT NULL,
    salary INT NOT NULL,
    manager VARCHAR(500),

    /* Primary keys are already unique*/
    department_id INT NOT NULL,
    person_id INT NOT NULL,
    job_title_id INT NOT NULL,

    FOREIGN KEY (department_id) REFERENCES department(id) ON DELETE CASCADE,
    FOREIGN KEY (person_id) REFERENCES person(id) ON DELETE CASCADE,
    FOREIGN KEY (job_title_id) REFERENCES job_title(id) ON DELETE CASCADE
);

CREATE TABLE skill(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    skill_name VARCHAR(500) NOT NULL
);

CREATE TABLE employee_skill(
    employee_id INT NOT NULL,
    skill_id INT NOT NULL,
    PRIMARY KEY (employee_id, skill_id),
    FOREIGN KEY (employee_id) REFERENCES employee(id) ON DELETE CASCADE,
    FOREIGN KEY (skill_id) REFERENCES skill(id) ON DELETE CASCADE   
);

CREATE TABLE course_layout(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    course_code VARCHAR(10) UNIQUE NOT NULL,
    course_name VARCHAR(500) NOT NULL,
    min_students INT,
    max_students INT,
    hp FLOAT(5) NOT NULL
);

CREATE TABLE course_instance(
    instance_id VARCHAR(200) UNIQUE PRIMARY KEY,
    num_students INT NOT NULL,
    course_layout_id INT NOT NULL,
    FOREIGN KEY (course_layout_id) REFERENCES course_layout(id) ON DELETE CASCADE,
    study_period VARCHAR(10) NOT NULL,
    study_year TIMESTAMP(4) NOT NULL
);

CREATE TABLE teaching_activity(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    activity_name VARCHAR(500) UNIQUE NOT NULL,
    factor FLOAT(5)
);

CREATE TABLE planned_activity(
    teaching_activity_id INT NOT NULL,
    instance_id VARCHAR(200) NOT NULL,

    planned_hours INT NOT NULL,
    PRIMARY KEY (teaching_activity_id, instance_id),
    FOREIGN KEY (teaching_activity_id) REFERENCES teaching_activity(id) ON DELETE CASCADE,
    FOREIGN KEY (instance_id) REFERENCES course_instance(instance_id) ON DELETE CASCADE
);

CREATE TABLE employee_planned_activity(
    employee_id INT NOT NULL,
    teaching_activity_id INT NOT NULL,
    instance_id VARCHAR(200) NOT NULL,

    PRIMARY KEY (employee_id, teaching_activity_id, instance_id),
    FOREIGN KEY (employee_id) REFERENCES employee(id) ON DELETE CASCADE,
    FOREIGN KEY (teaching_activity_id) REFERENCES teaching_activity(id) ON DELETE CASCADE,
    FOREIGN KEY (instance_id) REFERENCES course_instance(instance_id) ON DELETE CASCADE
);


