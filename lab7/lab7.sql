create database airlines;
use airlines;

drop database airlines;

create table flights(flno int, fl_from varchar(30), fl_to varchar(30), distance int, departs time, arrives time, price int, primary key(flno));

create table aircraft(aid int, aname varchar(30), cruisingrange int, primary key(aid));

create table employee(eid int, ename varchar(30), salary int, primary key(eid));

create table certified(eid int, aid int, primary key(eid ,aid), foreign key(eid) references employee(eid) on delete cascade, foreign key(aid) references aircraft(aid) on delete cascade);
show tables;

insert into flights (flno,fl_from,fl_to,distance,departs,arrives,price) values
            (1,'Bangalore','Mangalore',360,'10:45:00','12:00:00',10000),
            (2,'Bangalore','Delhi',5000,'12:15:00','16:30:00',25000),
            (3,'Bangalore','Mumbai',3500,'14:15:00','17:25:00',30000),
            (4,'Delhi','Mumbai',4500,'10:15:00','12:05:00',35000),
            (5,'Delhi','Frankfurt',18000,'07:15:00','05:30:00',90000),
            (6,'Bangalore','Frankfurt',19500,'10:00:00','07:45:00',95000),
            (7,'Bangalore','Frankfurt',17000,'12:00:00','06:30:00',99000),
            (8, 'Madison','New York', 10000, '12:00:00','18:00:00',75000);

select * from flights;

INSERT INTO aircraft (aid,aname,cruisingrange) values 
        (123,'Airbus',1000),
        (302,'Boeing',5000),
        (306,'Jet01',5000),
        (378,'Airbus380',8000),
        (456,'Aircraft',500),
        (789,'Aircraft02',800),
        (951,'Aircraft03',1000);

select * from aircraft;

INSERT INTO employee (eid,ename,salary) VALUES
        (1,'Ajay',30000),
        (2,'Ajith',85000),
        (3,'Arnab',50000),
        (4,'Harry',45000),
        (5,'Ron',90000),
        (6,'Josh',75000),
        (7,'Ram',100000);
        
insert into employee values(207, 'Ramesh', 100000);

select * from employee;
        
INSERT INTO certified (eid,aid) VALUES
        (1,123),
        (2,123),
        (1,302),
        (5,302),
        (7,302),
        (1,306),
        (2,306),
        (1,378),
        (2,378),
        (4,378),
        (6,456),
        (3,456),
        (5,789),
        (6,789),
        (3,951),
        (1,951),
        (1,789);        
        
select * from certified;
        
-- Q1        

select distinct a.aname from aircraft a, certified c, employee e
where a.aid=c.aid
and c.eid=e.eid
and not exists (select * from employee e2 where e2.eid=e.eid and e2.salary<80000);

-- Q2
select c.eid, max(cruisingrange) from certified c, aircraft a where c.aid = a.aid group by c.eid having count(*) > 3;

-- Q3 
select distinct e.ename from employee e where e.salary < (select min(f.price) from flights f where f.fl_from='Bangalore'and f.fl_to='Frankfurt');

-- Q4

select a.aid, a.aname, avg(e.salary) from aircraft a, certified c, employee e where a.aid=c.aid and c.eid=e.eid and a.cruisingrange>1000 group by a.aid, a.aname;

-- Q5

select distinct e.ename
	from employee e,aircraft a,certified c
	where e.eid=c.eid
	and c.aid=a.aid
	and a.aname='Boeing';

--  Q6

select a.aid
    from aircraft a
    where a.cruisingrange>
    (select MIN(f.distance)
    from flights f
    where f.fl_from='Bangalore'
    and f.fl_to='Delhi');
    
-- Q7

select f.departs from flights f where f.fl_to="New York" and arrives="18:00:00";

-- Q8

select e.ename, e.salary from employee e
where e.eid not in(select distinct c.eid from certified c) and e.salary>(select avg(e2.salary) from employee e2 where e2.eid in (select distinct c2.eid from certified c2));