drop database project1;

create database project1;

use project1;

create EXTERNAL TABLE if not exists college(cname string,state string,enrollment int)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
Location '/user/cloudera/college';


create EXTERNAL TABLE if not exists student(sid string,sname string,gpa float)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
Location '/user/cloudera/student';

create EXTERNAL TABLE if not exists apply(sid string,cname string,major string,decision string)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
Location '/user/cloudera/apply';

create table ccname as select cname from apply where state = 'CA';

create table acname as select cname from apply where major = 'CS';


create table Stuid select DISTINCT apply.sid from apply,ccname,acname where ccname.cname = acname.cname AND ccname.cname = apply.cname;


create view GPA as select s.gpa from student s JOIN Stuid t ON (s.sid = t.sid);


create VIEW reject as select s.sid,s.sname,s.gpa from student s,apply a where a.decision = 'N' AND a.major = 'CS' AND s.sid = a.sid;


create VIEW accept as select s.sid,s.sname,s.gpa from student s, apply a where a.decision = 'Y' AND s.sid = a.sid;

