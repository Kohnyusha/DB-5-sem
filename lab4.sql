---------1---------
select name, open_mode from v$pdbs;


---------2---------
select instance_name from v$instance;


---------3---------
--перечень установленных компонентов СУБД Oracle 12c и их версии и статус
select * from product_component_version;


--4. создать pdb
--pdb_kas_admin
--Kohnyuk123


--убежд, что наше создалось
select name,open_mode from v$pdbs;


---------6---------
--подключ.с пом.Developer + создать инфраструкт.объеткы


create tablespace TS_KAS_PDB
  datafile 'D:\3\БД Блинова\lab4\TS_KAS.dbf'
  size 7m                       
  autoextend on next 5m         
  maxsize 20m;
  commit;
  
drop tablespace TS_KAS_PDB including contents and datafiles;

create temporary tablespace TS_KAS_TEMPPDB 
  tempfile 'D:\3\БД Блинова\lab4\TS_KAS_TEMP1.dbf'
  size 7m                       
  autoextend on next 5m         
  maxsize 15m;
  commit;  
  
drop temporary tablespace TS_KAS_TEMPPDB including contents and datafiles;  
  
create role C##RL_KAS_PDB;
commit;

drop role C##RL_KAS_PDB;

grant create session, 
      create table, 
      create view, 
      create procedure to C##RL_KASCORE_PDB;
      
grant drop any table, 
      drop any view, 
      drop any procedure to C##RL_KASCORE_PDB;
      
      
create profile C##PF_KAS_PDB limit
  password_life_time 180            
  sessions_per_user 3             
  failed_login_attempts 7         
  password_lock_time 1            
  password_reuse_time 10          
  password_grace_time default     
  connect_time 180                
  idle_time 30;       

drop profile C##PF_KAS_PDB;
      
create user C##U1_KAS_PDB identified by 123456
  default tablespace TS_KAS_PDB            
  temporary tablespace TS_KAS_TEMPPDB  
  profile C##PF_KAS_PDB                
  account unlock;                    
  
drop user C##U1_KAS_PDB;

grant C##RL_KAS_PDB to C##U1_KAS_PDB;
grant create session, 
      create table, 
      create view, 
      create procedure to C##RL_KAS_PDB;
      
grant drop any table, 
      drop any view, 
      drop any procedure to C##RL_KAS_PDB;
    
      
      
---------7---------
--Подключитесь к пользователю U1_XXX_PDB, с помощью SQL Developer
create table KAS_table
(
  x number(1) primary key, 
  s number(3)
)

drop table KAS_table;

insert into KAS_table(x, s)
   values (1, 201);
insert into KAS_table(x, s)
   values (2, 202);
insert into KAS_table(x, s)
   values (3, 203);
insert into KAS_table(x, s)
   values (4, 204);
      
      
select * from KAS_table;
select x, s from  KAS_table
  where s > 201;
  
  
---------8---------
select * from ALL_USERS; 
select * from DBA_TABLESPACES; 
select * from DBA_DATA_FILES;   --перман данные 
select * from DBA_TEMP_FILES;  --времен данные
select * from DBA_ROLES;
select GRANTEE, PRIVILEGE from DBA_SYS_PRIVS;
select * from DBA_PROFILES; 

      
      
