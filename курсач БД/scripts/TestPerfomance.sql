create table TestPerf
(
    id int,
    a varchar(10) not null, 
    b varchar(10) not null
);

drop table TestPerf;

create sequence t_sequence_test
start with 1
increment by 1;      

insert into TestPerf 
select t_sequence_test.nextval, 
       dbms_random.string('x',8), 
       dbms_random.string('x',10)
from dual 
connect by level <= 100000;    

select count(*) from TestPerf;


declare
  t1 number:= dbms_utility.get_time();
begin
  for r in (select * from TestPerf where id > 50000 and id < 100000) loop null; end loop;
  dbms_output.put_line('query elapsed: '|| (dbms_utility.get_time() - t1)/100);
end;

-------------------------------------------
EXPLAIN PLAN FOR select * from TestPerf;
select plan_table_output from table(dbms_xplan.display());


