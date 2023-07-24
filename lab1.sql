create table KAS_t
( 
  x number(3) primary key, 
  s number(4)
);


insert into kas_t(x, s)
   values (101, 2001);
insert into kas_t(x, s)
   values (102, 2002);
insert into kas_t(x, s)
   values (103, 2003);
commit work;   

---------------------------

update KAS_t set x = 201 
  where s = 2001;
update KAS_t set x = 202 
  where s = 2002;
commit work;   

----------------------------

select * from KAS_t;

select count(*)Количество from KAS_t
  where x like '20%';
  
select x, s from KAS_t
  where x < 200;

---------------------------

delete from KAS_t where x = 201;
commit work;   

---------------------------
create table KAS_t1
(
  x1 number(3), 
  s1 number(5),
  foreign key (x1) references KAS_t(x)
);

insert into kas_t1(x1, s1)
   values (202, 51234);
insert into kas_t1(x1, s1)
   values (103, 95678);
commit work;

---------------------------

select x, s, x1, s1
  from kas_t left outer join kas_t1
    on x = x1;
    
select x, s, x1, s1
  from kas_t right outer join kas_t1
    on x = x1;

select x, s, x1, s1
  from kas_t full outer join kas_t1
    on x = x1;
---------------------------

drop table KAS_t;
drop table KAS_t1;