create database college;
create table STUDENT(USN varchar(10), SName varchar(20), Address varchar(20), Phone int, Gender varchar(10),primary key(USN)); 
CREATE TABLE SEMSEC ( 
SSID VARCHAR (5), 
SEM INT, 
SEC CHAR (1),
PRIMARY KEY (SSID)); 

CREATE TABLE CLASS ( 
USN VARCHAR (10), 
SSID VARCHAR (5), 
PRIMARY KEY (USN, SSID), 
FOREIGN KEY (USN) REFERENCES STUDENT (USN), 
FOREIGN KEY (SSID) REFERENCES SEMSEC (SSID));

CREATE TABLE SUBJECT ( 
SUBCODE VARCHAR (8), 
TITLE VARCHAR (20), 
SEM INT, 
CREDITS INT, 
PRIMARY KEY (SUBCODE)); 

CREATE TABLE IAMARKS ( 
USN VARCHAR (10), 
SUBCODE VARCHAR (8), 
SSID VARCHAR (5), 
TEST1 INT, 
TEST2 INT, 
TEST3 INT, 
FINALIA INT, 
PRIMARY KEY (USN, SUBCODE, SSID), 
FOREIGN KEY (USN) REFERENCES STUDENT (USN), 
FOREIGN KEY (SUBCODE) REFERENCES SUBJECT (SUBCODE), 
FOREIGN KEY (SSID) REFERENCES SEMSEC (SSID));

show tables;

INSERT INTO STUDENT VALUES ('1RN13CS020','AKSHAY','BELAGAVI', 887788112,'M'); 
INSERT INTO STUDENT VALUES ('1RN13CS062','SANDHYA','BENGALURU', 772282991,'F'); 
INSERT INTO STUDENT VALUES ('1RN13CS091','TEESHA','BENGALURU', 771231231,'F'); 
INSERT INTO STUDENT VALUES ('1RN13CS066','SUPRIYA','MANGALURU', 887788112,'F'); 
INSERT INTO STUDENT VALUES ('1RN14CS010','ABHAY','BENGALURU', 990021120,'M'); 
INSERT INTO STUDENT VALUES ('1RN14CS032','BHASKAR','BENGALURU', 992321109,'M'); 

select * from STUDENT;

INSERT INTO SEMSEC VALUES ('CSE8A', 8,'A'); 
INSERT INTO SEMSEC VALUES ('CSE8B', 8,'B'); 
INSERT INTO SEMSEC VALUES ('CSE8C', 8,'C'); 
INSERT INTO SEMSEC VALUES ('CSE7A', 7,'A'); 
INSERT INTO SEMSEC VALUES ('CSE7B', 7,'B');

select * from SEMSEC; 

INSERT INTO CLASS VALUES ('1RN13CS020','CSE8A'); 
INSERT INTO CLASS VALUES ('1RN13CS062','CSE8A'); 
INSERT INTO CLASS VALUES ('1RN13CS066','CSE8B'); 
INSERT INTO CLASS VALUES ('1RN13CS091','CSE8C'); 
INSERT INTO CLASS VALUES ('1RN14CS010','CSE7A'); 
INSERT INTO CLASS VALUES ('1RN14CS032','CSE7B');

select * from CLASS; 

INSERT INTO SUBJECT VALUES ('10CS81','ACA', 8, 4); 
INSERT INTO SUBJECT VALUES ('10CS82','SSM', 8, 4); 
INSERT INTO SUBJECT VALUES ('10CS71','OOAD', 7, 4); 
INSERT INTO SUBJECT VALUES ('10CS72','ECS', 7, 4); 
INSERT INTO SUBJECT VALUES ('10CS73','PTW', 7, 4);

select * from SUBJECT; 


INSERT INTO IAMARKS (USN, SUBCODE, SSID, TEST1, TEST2, TEST3) VALUES ('1RN13CS091','10CS81','CSE8C', 15, 16, 18); 
INSERT INTO IAMARKS (USN, SUBCODE, SSID, TEST1, TEST2, TEST3) VALUES ('1RN13CS091','10CS82','CSE8C', 12, 19, 14); 
INSERT INTO IAMARKS (USN, SUBCODE, SSID, TEST1, TEST2, TEST3) VALUES ('1RN14CS010','10CS71','CSE7A', 20, 16, 19); 
INSERT INTO IAMARKS (USN, SUBCODE, SSID, TEST1, TEST2, TEST3) VALUES ('1RN14CS032','10CS73','CSE7B', 15, 15, 12);
select * from IAMARKS;

/*1. List all the student details studying in 8th semester ‘C’ section. */

SELECT S.*, SS.SEM, SS.SEC 
FROM STUDENT S, SEMSEC SS, CLASS C 
WHERE S.USN = C.USN AND 
SS.SSID = C.SSID AND 
SS.SEM = 8 AND SS.SEC='C';

/*2. Compute the total number of male and female students in each semester and in each section. */
SELECT SS.SEM, SS.SEC, S.GENDER, COUNT(S.GENDER) AS COUNT 
FROM STUDENT S, SEMSEC SS, CLASS C 
WHERE S.USN = C.USN AND 
SS.SSID = C.SSID 
GROUP BY SS.SEM, SS.SEC, S.GENDER 
ORDER BY SEM;

/*3. Create a view of Test1 marks of student USN ‘1BI15CS101’ in all subjects. */
CREATE VIEW STU_TEST1_MARKS_VIEW 
AS 
SELECT TEST1, SUBCODE 
FROM IAMARKS 
WHERE USN = '1RN13CS091';

select * from STU_TEST1_MARKS_VIEW ;

/*5. Categorize students based on the following criterion: 
If FinalIA = 17 to 20 then CAT = ‘Outstanding’ 
If FinalIA = 12 to 16 then CAT = ‘Average’ 
If FinalIA< 12 then CAT = ‘Weak’ 
Give these details only for 8th semester A, B, and C section students. */
SELECT S.USN,S.SNAME,S.ADDRESS,S.PHONE,S.GENDER, 
(CASE 
WHEN IA.FINALIA BETWEEN 17 AND 20 THEN 'OUTSTANDING' 
WHEN IA.FINALIA BETWEEN 12 AND 16 THEN 'AVERAGE' 
ELSE 'WEAK' 
END) AS CAT 
FROM STUDENT S, SEMSEC SS, IAMARKS IA, SUBJECT SUB 
WHERE S.USN = IA.USN AND 
SS.SSID = IA.SSID AND 
SUB.SUBCODE = IA.SUBCODE AND 
SUB.SEM = 8;