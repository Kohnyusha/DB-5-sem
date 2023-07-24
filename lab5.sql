--as sysdba
---------1---------
select tablespace_name, contents from DBA_TABLESPACES;



---------2---------
create tablespace KAS_QDATA offline
  datafile 'D:\3\�� �������\KAS_QDATA1.dbf'
  size 10m                       
  autoextend on next 5m         
  maxsize 20m;

alter tablespace KAS_QDATA online;

--�������� ������ ������������ � ����� ��� ����
create role C##RL_KAS;
commit;

grant create session,
      create table, 
      create view, 
      create procedure,
      drop any table,
      drop any view,
      drop any procedure to C##RL_KAS;    
grant create session to C##RL_KAS;
commit;

create profile C##PF_KAS limit
  password_life_time 180            
  sessions_per_user 3             
  failed_login_attempts 7         
  password_lock_time 1            
  password_reuse_time 10          
  password_grace_time default     
  connect_time 180                
  idle_time 30;                   


--alter user C##U1_KAS_PDB identified by Kohnyuk1;
create user C##KAS identified by 1111
  default tablespace KAS_QDATA             
  profile C##PF_KAS              
  account unlock                    

grant C##RL_KAS to C##KAS;

--�������� ������������ XXX ����� 2m � ������������ XXX_QDATA
alter user C##KAS quota 2M on KAS_QDATA;


--�������������� ��� ���� ������ � ������� �������� (�������)
--U1
create table KAS_table1 
 (
  spec number(15) primary key,
  name varchar(10)
 )tablespace KAS_QDATA;

insert into KAS_table1(spec, name) values(1, 'ISiT');
insert into KAS_table1(spec, name) values(2, 'POIT');
insert into KAS_table1(spec, name) values(3, 'DEVI');

select * from KAS_table1;

drop table KAS_table1;

---------3---------
--������ ��������� ������������
--���
select segment_name, segment_type 
   from DBA_SEGMENTS where tablespace_name='KAS_QDATA';



---------4---------
drop table KAS_table1; 

--���������� ��� ��������, � ���������� �� �������� ������������ � ������� ��. 
select segment_name, segment_type 
   from DBA_SEGMENTS where tablespace_name='KAS_QDATA';


--���� � �������, ������������� �������� ������������
select * from user_recyclebin;



---------5---------
--��������������� �������
flashback table KAS_table1 to before drop;



---------6--------- 
BEGIN
  FOR k IN 4..10004
  LOOP
    insert into KAS_table1 values(k, 'A');
  END LOOP;
  COMMIT;
END;


select * from KAS_table1;



---------7---------
--������� ��������� � ��������
select extent_id, blocks, bytes from DBA_EXTENTS where SEGMENT_NAME='KAS_table1';



---------8---------
drop tablespace KAS_QDATA including contents and datafiles;



---------9---------
--�������� �������� ���� ����� �������� �������.
--�������� �������, � ������� ����������� ��������� �������� �������������� � ���� ������
--������� 2
select group#, sequence#, bytes, members, status, first_change# from V$LOG;



---------10---------
--�������� ������ ���� �������� ������� ��������
select * from V$LOGFILE;



---------11---------
--11. EX. � ������� ������������ �������� ������� �������� ������ ���� ������������. 
--�������� ��������� ����� � ������ ������ ������� ������������ (��� ����������� ��� ���������� ��������� �������). 
alter system switch logfile; 
 
--12. EX. �������� �������������� ������ �������� ������� � ����� ������� �������. ��������� � ������� ������ � ������, 
--� ����� � ����������������� ������ (�������������). ���������� ������������������ SCN

 
alter database add logfile group 4 'D:\3\�� �������\BDK_LOG.log' 
size 50m blocksize 512; 

alter database add logfile member 'D:\3\�� �������\BDK1_LOG.log' to group 4;
alter database add logfile member 'D:\3\�� �������\BDK2_LOG.log' to group 4;
alter database add logfile member 'D:\3\�� �������\BDK3_LOG.log' to group 4;

select group#, sequence#, bytes, members, status, first_change# from V$LOG;
select * from V$LOGFILE;

--13. EX. ������� ��������� ������ �������� �������. ������� ��������� ���� ����� �������� �� �������. 
alter database drop logfile group 4; 
 
--14. ����������, ����������� ��� ��� ������������� �������� ������� (������������� ������ ���� ���������, 
--����� ���������, ���� ������ ������� �������� ������� � ��������). 
select * from v$DATABASE; 

select * from SYS.v$instance;
 
--15. ���������� ����� ���������� ������. 
select * from SYS.v$archived_log; 
 
--16. EX.  �������� �������������. 

--����� SQLPLUS
-- /as sysdba

--SHUTDOWN IMMEDIATE;--����������
--STARTUP MOUNT;
--ALTER DATABASE ARCHIVELOG;
--ALTER DATABASE OPEN;
--archive log list;
select * from v$DATABASE; 

--17. EX. ������������� �������� �������� ����. ���������� ��� �����. ���������� ��� �������������� � ��������� � ��� �������. 
--���������� ������������������ SCN � ������� � �������� �������.  
 
-- shutdown immediate; 
-- startup mount; 
-- alter database archivelog; 
-- alter database open; 

select * from v$DATABASE; 


alter system set log_archive_dest_1='LOCATION=D:\3\�� �������\archive.arc';
alter system switch logfile;

select * from SYS.v$archived_log;




--18. EX. ��������� �������������. ���������, ��� ������������� ���������. 
-- shutdown immediate; 
--startup mount; 
--alter database noarchivelog; 
--alter database open;
--select name, log_mode from v$database;
--archive log list;
 
--19. �������� ������ ����������� ������. 
--select * from v$controlfile; 
 
--20. �������� � ���������� ���������� ������������ �����. 
--����������� ����� c������� ������ � ���������� ��������� ���� ������. 
show parameter control;  
 
--���������� �������������� ����� ���������� ��������. 
--��� �������� ���������� ���������� 
show parameter spfile;


--22. ����������� PFILE � ������ XXX_PFILE.ORA. 
--���������� ��� ����������. �������� ��������� ��� ��������� � �����. 
 
create pfile = 'KAS_PFILE.ora' from spfile;
--D:\Games\Oracle\app\kohnyuk\product\12.1.0\dbhome_1\database
 
--23. ���������� �������������� ����� ������� ��������. 
--��� �������������� ��������������� ���� ������ � ������� �������� ���� ������ ��� ������� � ��������� ������� 
--SQLPLUS
SHOW PARAMETER CONTROL;
select * from v$pwfile_users;
--D:\Games\Oracle\app\kohnyuk\product\12.1.0\dbhome_1\database
 
--24. �������� �������� ����������� ��� ������ ��������� � �����������. 
select * From v$diag_info;












