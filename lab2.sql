create database bookDealer;
use bookDealer;


create table author(AuthorID int, a_name varchar(30), city varchar(20), country varchar(20), primary key(AuthorID));
create table publisher(publisherID int, p_name varchar(30), city varchar(20), country varchar(20), primary key(publisherID));
create table category(categoryID int, description varchar(50), primary key(categoryID)); 
create table catalog(bookID int, title varchar(30), AuthorID int, publisherID int, categoryID int, year int, price int, 
foreign key(publisherID) references publisher(publisherID) on delete cascade, foreign key(categoryID) references category(categoryID) on delete cascade, 
primary key(bookID));
create table order_details(orderNo int, bookID int, quantity int, primary key(orderNo), foreign key(bookID) references catalog(bookID) on delete cascade);

show tables;

insert into author values(1001, "Teras Chan", "CA", "USA");
insert into author values(1002, "Stevens", "ZOMBI", "UGANDA");
insert into author values(1003, "M Mano", "CA", "USA");
insert into author values(1004, "Karthik B.P.", "CA", "USA");
insert into author values(1005, "William Stallings", "CA", "USA");

select * from author;

insert into publisher values(1, "Pearson", "NEW YORK", "USA");
insert into publisher values(2, "EEE", "NEW SOUTH WALES", "USA");
insert into publisher values(3, "PHI", "DELHI", "INDIA");
insert into publisher values(4, "Willey", "BERLIN", "GERMANY");
insert into publisher values(5, "MGH", "NEW YORK", "USA");

select * from publisher;

insert into category values(1001, "COMPUTER SCIENCE");
insert into category values(1002, "ALGORITHM DESIGN");
insert into category values(1003, "ELECTRONICS");
insert into category values(1004, "PROGRAMMING");
insert into category values(1005, "OPERATING SYSTEMS");

select * from category;

insert into catalog values(11, "Unix System Programming", 1001, 1, 1001, 2000, 251);
insert into catalog values(12, "Digital Signals", 1002, 2, 1003, 2001, 425);
insert into catalog values(13, "Logic Design", 1003, 3, 1002, 1999, 225);
insert into catalog values(14, "Server Programming", 1004, 4, 1004, 2001, 333);
insert into catalog values(15, "Linux OS", 1005, 5, 1005, 2003, 326);
insert into catalog values(16, "C++ Bible", 1005, 5, 1001, 2000, 526);
insert into catalog values(17, "COBOL Handbook", 1004, 4, 1001, 2000, 658);

select * from catalog;

insert into order_details values(1, 11, 5);
insert into order_details values(2, 12, 8);
insert into order_details values(3, 13, 15);
insert into order_details values(4, 14, 22);
insert into order_details values(5, 15, 3);
insert into order_details values(6, 17, 10);

select * from order_details;      

commit;

/* Question 1 */

select * from author right join catalog on author.AuthorID=catalog.AuthorID where year > 2000;

/* Question 2 */

select a_name from author inner join catalog on author.AuthorID=catalog.AuthorID and bookID in (select bookID from order_details where quantity = (select max(quantity) from order_details));

/* Question 3 */

update catalog set price=1.1*price where publisherID in (select publisherID from publisher where p_name="EEE");
