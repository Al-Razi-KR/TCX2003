-- =============================================================
-- L1 Practice Schema — Create SQL Table
-- Concepts: data types, constraints, PRIMARY KEY, FOREIGN KEY
-- =============================================================

-- Drop tables in reverse dependency order for clean re-runs
DROP TABLE IF EXISTS enrollment;
DROP TABLE IF EXISTS course;
DROP TABLE IF EXISTS student;
DROP TABLE IF EXISTS department;

-- ------------------------------------------------------------
-- 1. department
--    Demonstrates: PRIMARY KEY, NOT NULL, UNIQUE
-- ------------------------------------------------------------
CREATE TABLE department (
    dept_id     SERIAL          PRIMARY KEY,
    dept_name   VARCHAR(100)    NOT NULL UNIQUE,
    building    VARCHAR(50),
    budget      NUMERIC(12, 2)  DEFAULT 0.00
);

-- ------------------------------------------------------------
-- 2. student
--    Demonstrates: FOREIGN KEY, CHECK, DEFAULT, DATE
-- ------------------------------------------------------------
CREATE TABLE student (
    student_id  CHAR(8)         PRIMARY KEY,          -- e.g. 'A1234567'
    full_name   VARCHAR(100)    NOT NULL,
    email       VARCHAR(150)    NOT NULL UNIQUE,
    gender      CHAR(1)         CHECK (gender IN ('M', 'F', 'O')),
    dob         DATE,
    gpa         NUMERIC(3, 2)   CHECK (gpa >= 0.00 AND gpa <= 4.00),
    dept_id     INT             REFERENCES department(dept_id)
                                ON DELETE SET NULL
);

-- ------------------------------------------------------------
-- 3. course
--    Demonstrates: composite key via UNIQUE, CHECK on credits
-- ------------------------------------------------------------
CREATE TABLE course (
    course_id   VARCHAR(10)     PRIMARY KEY,          -- e.g. 'TCX2003'
    title       VARCHAR(150)    NOT NULL,
    credits     SMALLINT        NOT NULL CHECK (credits BETWEEN 1 AND 6),
    dept_id     INT             REFERENCES department(dept_id)
                                ON DELETE SET NULL
);

-- ------------------------------------------------------------
-- 4. enrollment
--    Demonstrates: composite PRIMARY KEY, FOREIGN KEYs, ENUM-like CHECK
-- ------------------------------------------------------------
CREATE TABLE enrollment (
    student_id  CHAR(8)         REFERENCES student(student_id),
    course_id   VARCHAR(10)     REFERENCES course(course_id),
    semester    VARCHAR(6)      NOT NULL,             -- e.g. '2530'
    grade       CHAR(2)         CHECK (grade IN ('A+','A','A-','B+','B','B-','C+','C','D+','D','F','S','U')),
    enrolled_on DATE            DEFAULT CURRENT_DATE,
    PRIMARY KEY (student_id, course_id, semester)
);

-- =============================================================
-- Seed data
-- =============================================================

INSERT INTO department (dept_name, building, budget) VALUES
    ('Computer Science',   'COM1', 500000.00),
    ('Mathematics',        'S17',  300000.00),
    ('Information Systems','COM2', 250000.00);

INSERT INTO student (student_id, full_name, email, gender, dob, gpa, dept_id) VALUES
    ('A1000001', 'Alice Tan',    'alice@u.nus.edu',  'F', '2003-04-12', 3.85, 1),
    ('A1000002', 'Bob Lim',      'bob@u.nus.edu',    'M', '2002-11-05', 3.20, 1),
    ('A1000003', 'Carol Ng',     'carol@u.nus.edu',  'F', '2003-07-30', 3.60, 3),
    ('A1000004', 'David Ong',    'david@u.nus.edu',  'M', '2001-09-18', 2.95, 2),
    ('A1000005', 'Eve Rahman',   'eve@u.nus.edu',    'F', '2004-01-22', 3.75, 1);

INSERT INTO course (course_id, title, credits, dept_id) VALUES
    ('TCX2003', 'Database Systems and Management', 4, 1),
    ('CS2030S', 'Programming Methodology II',      4, 1),
    ('MA1521',  'Calculus for Computing',          4, 2),
    ('IS1103',  'IS and Society',                  4, 3);

INSERT INTO enrollment (student_id, course_id, semester, grade) VALUES
    ('A1000001', 'TCX2003', '2530', 'A'),
    ('A1000001', 'CS2030S', '2520', 'A+'),
    ('A1000002', 'TCX2003', '2530', 'B+'),
    ('A1000002', 'MA1521',  '2520', 'B'),
    ('A1000003', 'TCX2003', '2530', NULL),  -- grade not released yet
    ('A1000003', 'IS1103',  '2520', 'A-'),
    ('A1000004', 'MA1521',  '2530', 'C+'),
    ('A1000005', 'TCX2003', '2530', NULL);
