---------1---------
create tablespace TS_KAS
  datafile 'D:\3\БД Блинова\TS_KAS.dbf'
  size 7m                       
  autoextend on next 5m         
  maxsize 20m;


---------2---------
create temporary tablespace TS_KAS_TEMP
  tempfile 'D:\3\БД Блинова\TS_KAS_TEMP.dbf'
  size 7m                       
  autoextend on next 5m         
  maxsize 20m;


---------3---------
select TABLESPACE_NAME, contents logging from SYS.DBA_TABLESPACES;
select * from dictionary; --все файлы


---------4---------
create role C##RL_KASCORE;
commit;
grant create session, 
      create table, 
      create view, 
      create procedure to C##RL_KASCORE;
      
grant drop any table, 
      drop any view, 
      drop any procedure to C##RL_KASCORE;


---------5---------
select * from DBA_ROLES where role like 'C##RL%';
select * from DBA_SYS_PRIVS where grantee = 'C##RL_KASCORE';



---------6---------
create profile C##PF_KASCORE limit
  password_life_time 180            
  sessions_per_user 3             
  failed_login_attempts 7         
  password_lock_time 1            
  password_reuse_time 10          
  password_grace_time default     --кол-во дней предупреждений о смене пароля
  connect_time 180                
  idle_time 30;                   


---------7---------
select * from DBA_PROFILES;
select * from DBA_profiles where profile = 'C##PF_KASCORE';
select * from DBA_PROFILES where profile='DEFAULT';


---------8---------

create user C##KASCORE identified by 1234
  default tablespace TS_KAS            
  temporary tablespace TS_KAS_TEMP  
  profile C##PF_KASCORE                
  account unlock                    
  password expire; --истек пароль

grant C##RL_KAS to C##KAS;
grant create tablespace, 
      alter tablespace to C##KASCORE;
grant create table,
      alter table to C##KASCORE;
--пароль ползователя: 12345678


---------11---------


create tablespace KASQDATA offline
  datafile 'D:\3\БД Блинова\KAS_QDATA.dbf'
  size 10m                       
  autoextend on next 5m         
  maxsize 20m;

alter tablespace KASQDATA online;

alter user C##KASCORE quota 2M on KASQDATA;

create table KAS_t2 (c number);

insert into KAS_t2(c) values(3);
insert into KAS_t2(c) values(1);
insert into KAS_t2(c) values(2);

select * from KAS_t2;

