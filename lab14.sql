---------1---------
grant create database link to C#KASCORE;
grant create public database link to C#KASCORE;




--создание приватной связи бд
create database link oralink 
   connect to BND_user
   identified by qwerty
   using 'nadezhda:1521/orcl.Nadezhda';
   
delete database link oralink;

create synonym A for A@oralink;

drop synonym A;

select * from A@oralink;

insert into A@oralink values (123, 'vgvgh');

update A@oralink set str = '111' where ID = 123;

delete from A@oralink where id = 123;






alter pluggable database KAS_PDB open;
select * from dba_pdbs;







--процедура
begin
  GET_TEACHERS@oralink('ЛХФ');
end;

--функция
select GET_NUM_TEACHERS@oralink('ИДиП') from dual;


create table KAStabl 
 (
  spec number(15) primary key,
  name varchar(10)
 );

---------3---------
create public database link oralinkPUBLIC 
   connect to BND_user
   identified by qwerty
   using 'nadezhda:1521/orcl.Nadezhda';
   
drop public database link oralinkPUBLIC;
   

create synonym A for A@oralinkPUBLIC;
select * from A;

insert into A values (123, 'vgvgh');

insert into A values (123, 'vgvgh');

update A set str = '111' where ID = 123;

delete from A where str = '111';


begin
  GET_TEACHERS('ЛХФ');
end;

--функция
select GET_NUM_TEACHERS('ИДиП') from dual;











