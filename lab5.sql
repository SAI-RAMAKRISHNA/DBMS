create database StudentEnrollement;
use StudentEnrollement;



create table student(regno varchar(10), name varchar(30), major varchar(30), bdate date, primary key(regno));
create table course(course_no int, cname varchar(30), dept varchar(30), primary key(course_no));
create table enroll(regno varchar(10), course_no int, marks int, sem int, primary key(regno, course_no), foreign key(regno) references student(regno) on delete cascade,
foreign key(course_no) references course(course_no) on delete cascade);
create table txt(bookisbn int, book_title varchar(30), publisher varchar(30), author varchar(30), primary key(bookisbn));
create table book_adoption(course_no int, sem int, bookisbn int, primary key(course_no, bookisbn), foreign key(course_no) references course(course_no) on delete cascade,
foreign key(bookisbn) references txt(bookisbn) on delete cascade);

show tables;

-- inserting data


insert into student values("CS01", "RAM", "DS", "1986-03-12");
insert into student values("IS02", "SMITH", "USP", "1987-12-23");
insert into student values("EC03", "AHMED", "SNS", "1985-04-17");
insert into student values("CS03", "SNEHA", "DBMS", "1987-01-01");
insert into student values("TC05", "AKHILA", "EC", "1986-10-06");

select * from student;

insert into course values(11,"DS","CS");
insert into course values(22,"USP","IS");
insert into course values(33,"SNS","EC");
insert into course values(44,"DBMS","CS");
insert into course values(55,"EC","TC");

select * from course;

insert into enroll values("CS01", 11, 4, 85);
insert into enroll values("IS02", 22, 6, 80);
insert into enroll values("EC03", 33, 2, 80);
insert into enroll values("CS03", 44, 6, 75);
insert into enroll values("TC05", 11, 4, 85);

select * from enroll;

insert into txt values(1, "DS AND C", "PRINCETON","PADMA REDDY");
insert into txt values(2, "FUNDAMENTALS OF DS", "PRINCETON", "GODSE");
insert into txt values(3, "FUNDAMENTALS OF DBMS", "PRINCETON", "NAVATHE");
insert into txt values(4, "SQL", "PRINCETON", "FOLEY");
insert into txt values(5, "ELECTRONIC CIRCUITS", "TMH", "ELMASRI");
insert into txt values(6, "ADV UNIX PROG", "TMH", "STEVENS");

select * from txt;

insert into book_adoption values(11, 4 ,1);
insert into book_adoption values(11, 4 ,2);
insert into book_adoption values(44, 6 ,3);
insert into book_adoption values(44, 6 ,4);
insert into book_adoption values(55, 2 ,5);
insert into book_adoption values(22, 6 ,6);

select * from book_adoption;

-- Q1
insert into txt values(7, "TREES", "PRINCETON", "SADGE");
insert into book_adoption values(11, 4, 7);


-- Q2
select c.course_no,t.bookisbn,t.book_title
     from course c,book_adoption ba,txt t
     where c.course_no=ba.course_no
     and ba.bookisbn=t.bookisbn
     and c.dept='CS'
     and 2<(
     select COUNT(bookisbn)
     from book_adoption b
     where c.course_no=b.course_no)
     order by t.book_title;

-- Q3

select distinct c.dept
     from course c
     where c.dept in
     ( select c.dept
     FROM course c,book_adoption b,txt t
     where c.course_no=b.course_no
     and t.bookisbn=b.bookisbn
     and t.publisher='PRINCETON')
     
