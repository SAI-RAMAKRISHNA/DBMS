CREATE TABLE PERSON (DRIVER_ID VARCHAR(10),NAME VARCHAR(20),ADDRESS VARCHAR(15),PRIMARY KEY(DRIVER_ID));
create table car(regno varchar(10),Model varchar(20),Year date,Primary key(Regno));
create table Accident(report_no int,ADATE DATE,Location varchar(15),Primary key(report_no));
create table owns(driver_id varchar(10),regno varchar(10),primary key(driver_id,regno),foreign key(driver_id) references person(driver_id) on delete cascade,
foreign key(regno) references car(regno) on delete cascade);

CREATE TABLE PARTICIPATED(driver_id varchar(10),regno varchar(10),report_no int,
damage_amt float, foreign key (driver_id,regno) references OWNS(driver_id,regno)
ON DELETE CASCADE,
foreign key (REPORT_NO) references ACCIDENT(REPORT_NO) ON DELETE CASCADE);


insert into  PERSON values(1111,'RAMU', 'K.S.LAYOUT');
insert into  PERSON values(2222, 'JOHN', 'INDIRANAGAR');
insert into  PERSON values(3333,'PRIYA', 'JAYANAGAR');
insert into  PERSON values(4444, 'GOPAL', 'WHITEFIELD');
insert into  PERSON values(5555, 'LATHA', 'VIJAYANAGAR');
select * from PERSON;

insert into  car values('AP07Q2301', 'MARUTHI-DX' ,'2000-01-01');
insert into  car values('AP07P1000', 'FORDICON', '2000-02-23');
insert into car values('AP071234','ZEN-VXI', '1999-03-19');
insert into  car values('AP07L9999', 'MARUTH-DX', '2002-05-09');
insert into  car values('AP07P4020', 'INDICA-VX ', '2002-04-02');
select * from car;

show tables;

insert into Accident values(12, '01-06-02','M G ROAD');
insert into Accident values (200, '10-12-02', 'DOUBLEROAD');
insert into Accident values (300,'23-07-09', ' M G ROAD');
insert into Accident values (25000, '11-06-01', ' RESIDENCY ROAD'); 
insert into Accident values (26500, '16-09-01', ' RICHMOND ROAD');

insert into owns values(1111,'AP07Q2301');
insert into owns values(1111,'AP07P1000');
insert into owns values(2222,'AP07L1234');
insert into owns values(3333,'AP07L9999');
insert into owns values(4444,'AP07P4020');

insert into participated values(111, 'AP07Q2301' ,12 ,20000);
insert into participated values(2222, 'AP07L1234' ,200 ,500);
insert into participated values(3333, 'AP07L9999' ,300 ,10000);
insert into participated values(4444, 'AP07P4020' ,25000 ,2375);
insert into participated values(1111, 'AP07P1000' ,26500, 70000);

select * from participated;

/* Question 1 where damage amount is updated when given report number*/
update participated set damage_amt=25000 where report_no=12; 

/* Question 2 return count of accidents that occured in 2008*/
select count(report_no) from accident where YEAR(adate) = 2008;

/* Question 3 return the count of models that were in an accident given the model*/
select count(Model) from car where Model='Tata Safari';


