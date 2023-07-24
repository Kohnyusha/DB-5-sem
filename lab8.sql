---------1---------
--Найдите на компьютере конфигурационные файлы SQLNET.ORA и TNSNAMES.ORA и ознакомьтесь с их содержимым.
--D:\Games\Oracle\app\kohnyuk\product\12.1.0\dbhome_1\NETWORK\ADMIN



---------2---------
--Соединитесь при помощи sqlplus с Oracle как пользователь SYSTEM, 
--получите перечень параметров экземпляра Oracle.
--connect system
--MANAGER (password)

--show parameter instance



---------3---------
--Соединитесь при помощи sqlplus с подключаемой базой данных как пользователь SYSTEM, 
--получите список табличных пространств, файлов табличных пространств, ролей и пользователей.

--connect system/MANAGER@localhost:1521/KAS_PDB

--select * from v$pdbs;
--select * from v$tablespace;
--select * from dba_data_files;
--select * from all_users;
--select * from dba_role_privs;



---------5---------
--Запустите утилиту Oracle Net Manager и подготовьте строку подключения 
--с именем имя_вашего_пользователя_SID, где SID – идентификатор подключаемой базы данных



---------6---------
--Подключитесь с помощью sqlplus под собственным пользователем и с применением подготовленной строки подключения. 

ALTER USER C##KAS IDENTIFIED BY 1234;


---------7---------
--select * from  KAS_table1

commit
grant select, insert, update, delete on KAS_table1 to C##KAS;

---------8---------
--Ознакомьтесь с командой HELP.Получите справку по команде TIMING. 
--Подсчитайте, сколько времени длится select к любой таблице.
--запис данные синхрониации

--help timing
--timing start first
--select * from KAS_table1;
--timing show
--timing stop



---------9---------
--Ознакомьтесь с командой DESCRIBE.Получите описание столбцов любой таблицы.

--help describe;
--describe KAS_table1;




---------10---------
--Получите перечень всех сегментов, владельцем которых является ваш пользователь.

--connect system/MANAGER
--select * from dba_segments where owner = 'C##KASCORE';





---------11---------
--Создайте представление, в котором получите количество всех сегментов, 
--количество экстентов, блоков памяти и размер в килобайтах, которые они занимают.

create view EXTENTS as select extents, blocks, bytes from dba_segments;

select * from EXTENTS;
