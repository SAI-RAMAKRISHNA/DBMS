create database bank;
use bank;


-- Creating Tables

create table branch(branch_name varchar(30), branch_city varchar(30), assets real, primary key(branch_name));
create table accounts(accno int, branch_name varchar(30), balance real, primary key(accno), foreign key(branch_name) 
references branch(branch_name) on delete cascade);
create table customer(customer_name varchar(20), customer_street varchar(20), city varchar(20), primary key(customer_name));
create table depositor(customer_name varchar(20), accno int, primary key(customer_name, accno), 
foreign key(customer_name) references customer(customer_name) on update cascade, foreign key(accno) references accounts(accno) on delete cascade);
create table loan(loan_number int, branch_name varchar(30), amount real, primary key(loan_number), 
foreign key(branch_name) references branch(branch_name) on delete cascade);
create table borrower(customer_name varchar(20), loan_number int, primary key(customer_name, loan_number),
foreign key(customer_name) references customer(customer_name) on update cascade, foreign key(loan_number) references loan(loan_number) on delete cascade);

-- Insertions

insert into branch values("SBI PD NAGAR", "BANGALORE", 200000);
insert into branch values("SBI RAJAJI NAGAR", "BANGALORE", 500000);
insert into branch values("SBI JAYANAGAR", "BANGALORE", 660000);
insert into branch values("SBI VIJAY NAGAR", "BANGALORE", 870000);
insert into branch values("SBI HOSAKEREHALLI", "BANGALORE", 550000);

select * from branch;

insert into accounts values(1234602, "SBI HOSAKEREHALLI", 5000);
insert into accounts values(1234603, "SBI VIJAY NAGAR", 5000);
insert into accounts values(1234604, "SBI JAYANAGAR", 5000);
insert into accounts values(1234605, "SBI RAJAJI NAGAR", 10000);
insert into accounts values(1234503, "SBI VIJAY NAGAR", 40000);
insert into accounts values(1234504, "SBI PD NAGAR", 4000);

select * from accounts;

insert into customer values("KEZAR", "M G ROAD", "BANGALORE");
insert into customer values("LAL KRISHNA", "ST MKS ROAD", "BANGALORE");
insert into customer values("RAHUL", "AUGSTEN ROAD", "BANGALORE");
insert into customer values("LALLU", "V S ROAD", "BANGALORE");
insert into customer values("FAIZAL", "RESIDENCY ROAD", "BANGALORE");
insert into customer values("RAJEEV", "DICKNSN ROAD", "BANGALORE");

select * from customer;

insert into loan values(10011, "SBI JAYANAGAR", 10000);
insert into loan values(10012, "SBI VIJAY NAGAR", 5000);
insert into loan values(10013, "SBI HOSAKEREHALLI", 20000);
insert into loan values(10014, "SBI PD NAGAR", 15000);
insert into loan values(10015, "SBI RAJAJI NAGAR", 25000);

select * from loan;

insert into borrower values("KEZAR", 10011);
insert into borrower values("LAL KRISHNA", 10012);
insert into borrower values("RAHUL", 10013);
insert into borrower values("LALLU", 10014);
insert into borrower values("LAL KRISHNA", 10015);

select * from borrower;

insert into depositor values("LAL KRISHNA", 1234603);
insert into depositor values("LAL KRISHNA", 1234503);
insert into depositor values("KEZAR", 1234604);
insert into depositor values("RAHUL", 1234602);
insert into depositor values("LALLU", 1234504);

select * from depositor;

-- Question 1

select customer_name from depositor d, accounts a where d.accno=a.accno and a.branch_name="SBI VIJAY NAGAR" group by d.customer_name having count(d.customer_name) >= 2;

-- Question 2

select d.customer_name from accounts a, branch b, depositor d where b.branch_name=a.branch_name and a.accno=d.accno and b.branch_city="BANGALORE" 
group by d.customer_name having count(distinct b.branch_name)=(select count(branch_name) from branch where branch_city="BANGALORE");

-- Question 3

delete from accounts where branch_name in(select branch_name from branch where branch_city="BANGALORE");

commit;
 
