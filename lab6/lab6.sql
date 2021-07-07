create database MovieDB;
use MovieDB;

create table actor(act_id int, act_name varchar(30), act_gender enum('M','F'), primary key(act_id));
create table director(dir_id int, dir_name varchar(30), dir_phone varchar(10), primary key(dir_id));
create table movies(mov_id int, mov_title varchar(30), mov_year year, mov_lang varchar(10), dir_id int, primary key(mov_id), foreign key(dir_id) references director(dir_id) on delete cascade);
create table moviecast(act_id int, mov_id int, part varchar(20), primary key(act_id, mov_id), foreign key(act_id) references actor(act_id) on delete cascade, 
foreign key(mov_id) references movies(mov_id) on delete cascade);
create table rating(mov_id int, rev_stars float, primary key(mov_id, rev_stars), foreign key(mov_id) references movies(mov_id) on delete cascade);

show tables;

-- insertion

insert into actor values(100, "Leo DiCaprio", 'M');
insert into actor values(101, "Tom Hanks", 'M');
insert into actor values(102, "Tom Cruise", 'M');
insert into actor values(103, "Margot Robbie", 'F');
insert into actor values(104, "Jennifer Aniston", 'F');
insert into actor values(105, "Gal Gadot", 'F');

select * from actor;

insert into director values(200, 'Steven Spielberg', '1649503470');
insert into director values(201, 'Alfred Hitchcock', '7989467865');
insert into director values(202, 'James Cameron', '5218281077');
insert into director values(203, 'Kathryn Bigelow', '6157228013');
insert into director values(204, 'Niki Caro', '8976600547');
insert into director values(205, 'Sofia Coppola', '3949875040');

select * from director;

insert into movies values(300, 'Avatar', 2010, 'EN', 202);
insert into movies values(301, 'Dial M For Murder', 1990, 'EN', 201);
insert into movies values(302, 'Jurassic Park 1', 1999, 'EN', 200);
insert into movies values(303, 'Jurassic Park 2', 2017, 'EN', 200);
insert into movies values(304, 'Vertigo', 1986, 'EN', 201);
insert into movies values(305, 'Zero Dark Thirty', 2012, 'EN', 200);

select * from movies;

insert into moviecast values(101, 300, 'actor');
insert into moviecast values(105, 300, 'actress');
insert into moviecast values(102, 301, 'actor');
insert into moviecast values(103, 301, 'actress');
insert into moviecast values(100, 302, 'actor');
insert into moviecast values(104, 302, 'actress');
insert into moviecast values(100, 303, 'actor');
insert into moviecast values(104, 303, 'actress');
insert into moviecast values(102, 304, 'actor');
insert into moviecast values(105, 304, 'actress');
insert into moviecast values(103, 305, 'actress');

select * from moviecast;

insert into rating values(300, 4.5);
insert into rating values(301, 3);
insert into rating values(302, 4);
insert into rating values(303, 3.5);
insert into rating values(304, 5);
insert into rating values(305, 4);

select * from rating;

-- Queries

-- Q1
select m.mov_title from movies m, director d where m.dir_id=d.dir_id and d.dir_name='Alfred Hitchcock';

-- Q2
select m.mov_title from movies m, moviecast mc where m.mov_id=mc.mov_id and act_id in( select act_id from moviecast group by act_id having count(act_id) > 1) group by m.mov_title having count(*) >= 2;

-- Q3
select a.act_name, m.mov_title, m.mov_year from actor a, movies m, moviecast mc where a.act_id=mc.act_id and mc.mov_id=m.mov_id and m.mov_year not between 2000 and 2015;

-- Q4
select mov_title, max(rev_stars) from movies inner join rating using (mov_id) group by mov_title having max(rev_stars)>0 order by mov_title;

-- Q5
update rating set rev_stars = 5 where mov_id in (select mov_id from movies where dir_id in (select dir_id from director where dir_name='Steven Spielberg'));