---------1---------
--полный список фоновыъх процессов 
select name, description from v$bgprocess 
  order by 1;



---------2---------
--фонов процессы, которые запущены и работают в наст момент
select * from v$bgprocess 
  where paddr != '00';



---------3---------
--сколько процессов DBWn раб в наст момент
select count(*) from v$bgprocess 
  where paddr!= '00' 
   and 
    name like 'DBW%';

show parameter db_writer_processes;



---------4---------
--Тек соед с экземпляром
select * from v$instance;



---------5---------
--режимы этих соед(один польз процесс)
select username, status, server from v$session 
  where username is not null;



---------6---------
--сервисы (точки подключения экземпляра)
select * from v$services;



---------7---------
--параметры диспетчера и их значения
show parameter dispatcher;



---------8---------
--сервис, реализующий процесс LISTENER
select * from v$services;



---------9---------
--перечень текущих соединений с инстансом
select * from v$session 
  where username is not null;



---------10---------
--содержимое файла LISTENER.ORA
--D:\Games\Oracle\app\kohnyuk\product\12.1.0\dbhome_1\NETWORK\ADMIN\listener.ora



---------11---------
--Запустите утилиту lsnrctl и поясните ее основные команды
--start LSNRCTL.exe



---------12---------
--список служб инстанса, обслуживаемых процессом LISTENER
--services














