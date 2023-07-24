--as sysdba
---------1---------
select tablespace_name, contents from DBA_TABLESPACES;



---------2---------
create tablespace KAS_QDATA offline
  datafile 'D:\3\БД Блинова\KAS_QDATA1.dbf'
  size 10m                       
  autoextend on next 5m         
  maxsize 20m;

alter tablespace KAS_QDATA online;

--создадим нового пользователя и необх для него
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

--Выделите пользователю XXX квоту 2m в пространстве XXX_QDATA
alter user C##KAS quota 2M on KAS_QDATA;


--авторизоваться под созд юзером и создать табличку (СОЗДАТЬ)
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
--список сегментов пространства
--обл
select segment_name, segment_type 
   from DBA_SEGMENTS where tablespace_name='KAS_QDATA';



---------4---------
drop table KAS_table1; 

--Изменяется имя сегмента, и информация об удалении записывается в словарь бд. 
select segment_name, segment_type 
   from DBA_SEGMENTS where tablespace_name='KAS_QDATA';


--инфа о корзине, принадлежащей текущему пользователю
select * from user_recyclebin;



---------5---------
--восстанавливаем таблицу
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
--сколько экстентов в сегметне
select extent_id, blocks, bytes from DBA_EXTENTS where SEGMENT_NAME='KAS_table1';



---------8---------
drop tablespace KAS_QDATA including contents and datafiles;



---------9---------
--Получите перечень всех групп журналов повтора.
--дисковые ресурсы, в которых фиксируются изменения вносимых пользователями в базу данных
--минимум 2
select group#, sequence#, bytes, members, status, first_change# from V$LOG;



---------10---------
--перечень файлов всех журналов повтора инстанса
select * from V$LOGFILE;



---------11---------
--11. EX. С помощью переключения журналов повтора пройдите полный цикл переключений. 
--Запишите серверное время в момент вашего первого переключения (оно понадобится для выполнения следующих заданий). 
alter system switch logfile; 
 
--12. EX. Создайте дополнительную группу журналов повтора с тремя файлами журнала. Убедитесь в наличии группы и файлов, 
--а также в работоспособности группы (переключением). Проследите последовательность SCN

 
alter database add logfile group 4 'D:\3\БД Блинова\BDK_LOG.log' 
size 50m blocksize 512; 

alter database add logfile member 'D:\3\БД Блинова\BDK1_LOG.log' to group 4;
alter database add logfile member 'D:\3\БД Блинова\BDK2_LOG.log' to group 4;
alter database add logfile member 'D:\3\БД Блинова\BDK3_LOG.log' to group 4;

select group#, sequence#, bytes, members, status, first_change# from V$LOG;
select * from V$LOGFILE;

--13. EX. Удалите созданную группу журналов повтора. Удалите созданные вами файлы журналов на сервере. 
alter database drop logfile group 4; 
 
--14. Определите, выполняется или нет архивирование журналов повтора (архивирование должно быть отключено, 
--иначе дождитесь, пока другой студент выполнит задание и отключит). 
select * from v$DATABASE; 

select * from SYS.v$instance;
 
--15. Определите номер последнего архива. 
select * from SYS.v$archived_log; 
 
--16. EX.  Включите архивирование. 

--ЧЕРЕЗ SQLPLUS
-- /as sysdba

--SHUTDOWN IMMEDIATE;--завершение
--STARTUP MOUNT;
--ALTER DATABASE ARCHIVELOG;
--ALTER DATABASE OPEN;
--archive log list;
select * from v$DATABASE; 

--17. EX. Принудительно создайте архивный файл. Определите его номер. Определите его местоположение и убедитесь в его наличии. 
--Проследите последовательность SCN в архивах и журналах повтора.  
 
-- shutdown immediate; 
-- startup mount; 
-- alter database archivelog; 
-- alter database open; 

select * from v$DATABASE; 


alter system set log_archive_dest_1='LOCATION=D:\3\БД Блинова\archive.arc';
alter system switch logfile;

select * from SYS.v$archived_log;




--18. EX. Отключите архивирование. Убедитесь, что архивирование отключено. 
-- shutdown immediate; 
--startup mount; 
--alter database noarchivelog; 
--alter database open;
--select name, log_mode from v$database;
--archive log list;
 
--19. Получите список управляющих файлов. 
--select * from v$controlfile; 
 
--20. Получите и исследуйте содержимое управляющего файла. 
--Управляющие файлы cодержат данные о физической структуре базы данных. 
show parameter control;  
 
--Определите местоположение файла параметров инстанса. 
--для хранения параметров экземпляра 
show parameter spfile;


--22. Сформируйте PFILE с именем XXX_PFILE.ORA. 
--Исследуйте его содержимое. Поясните известные вам параметры в файле. 
 
create pfile = 'KAS_PFILE.ora' from spfile;
--D:\Games\Oracle\app\kohnyuk\product\12.1.0\dbhome_1\database
 
--23. Определите местоположение файла паролей инстанса. 
--для аутентификации администраторов базы данных в задачах создания базы данных или запуска и остановки сервера 
--SQLPLUS
SHOW PARAMETER CONTROL;
select * from v$pwfile_users;
--D:\Games\Oracle\app\kohnyuk\product\12.1.0\dbhome_1\database
 
--24. Получите перечень директориев для файлов сообщений и диагностики. 
select * From v$diag_info;












