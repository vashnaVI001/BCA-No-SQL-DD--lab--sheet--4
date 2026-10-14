-- Q11: CollegeDB keyspace and five student records
CREATE KEYSPACE IF NOT EXISTS CollegeDB
WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 1};

USE CollegeDB;

CREATE TABLE IF NOT EXISTS Students (
    student_id text PRIMARY KEY,
    name text,
    course text,
    year int,
    city text
);

INSERT INTO Students (student_id, name, course, year, city)
VALUES ('S101', 'Aarav Sharma', 'BCA', 3, 'Shamli');
INSERT INTO Students (student_id, name, course, year, city)
VALUES ('S102', 'Priya Verma', 'BCA', 2, 'Dehradun');
INSERT INTO Students (student_id, name, course, year, city)
VALUES ('S103', 'Rahul Singh', 'BSc', 1, 'Roorkee');
INSERT INTO Students (student_id, name, course, year, city)
VALUES ('S104', 'Neha Gupta', 'BCom', 3, 'Haridwar');
INSERT INTO Students (student_id, name, course, year, city)
VALUES ('S105', 'Kabir Malik', 'BCA', 1, 'Meerut');

SELECT * FROM Students;
