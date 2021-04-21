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

insert into  car values('KA04Q2301', 'MARUTHI-DX' ,'2000-01-01');
insert into  car values('KA05P1000', 'FORDICON', '2000-02-23');
insert into car values('KA03L1234','ZEN-VXI', '1999-03-19');
insert into  car values('KA03L9999', 'MARUTH-DX', '2002-05-09');
insert into  car values('KA01P4020', 'INDICA-VX ', '2002-04-02');
select * from car;

show tables;

insert into Accident values(12, '01-06-02','M G ROAD');
insert into Accident values (200, '10-12-02', 'DOUBLEROAD');
insert into Accident values (300,'23-07-09', ' M G ROAD');
insert into Accident values (25000, '11-06-01', ' RESIDENCY ROAD'); 
insert into Accident values (26500, '16-09-01', ' RICHMOND ROAD');

insert into owns values(1111,'KA04Q2301');
insert into owns values(1111,'KA05P1000');
insert into owns values(2222,'KA03L1234');
insert into owns values(3333,'KA03L9999');
insert into owns values(4444,'KA01P4020');

insert into participated values(1111, 'KA04Q2301' ,12 ,20000);
insert into participated values(2222, 'KA03L1234' ,200 ,500);
insert into participated values(3333, 'KA03L9999' ,300 ,10000);
insert into participated values(4444, 'KA01P4020' ,25000 ,2375);
insert into participated values(1111, 'KA05P1000' ,26500, 70000);

UPDATE PARTICIPATED
SET DAMAGE_AMT=25000
WHERE REPORT_NO =12 AND REGNO="KA04Q2301";

SELECT COUNT(*) FROM ACCIDENT
WHERE ADATE LIKE "2001-06-02";


SELECT count(A.REPORT_NO)
FROM ACCIDENT A, PARTICIPATED P, CAR C
WHERE A.REPORT_NO=P.REPORT_NO
AND
P.REGNO=C.REGNO
AND
C.MODEL="MARUTHI-DX";

commit;
