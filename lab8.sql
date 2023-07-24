---------1---------
--������� �� ���������� ���������������� ����� SQLNET.ORA � TNSNAMES.ORA � ������������ � �� ����������.
--D:\Games\Oracle\app\kohnyuk\product\12.1.0\dbhome_1\NETWORK\ADMIN



---------2---------
--����������� ��� ������ sqlplus � Oracle ��� ������������ SYSTEM, 
--�������� �������� ���������� ���������� Oracle.
--connect system
--MANAGER (password)

--show parameter instance



---------3---------
--����������� ��� ������ sqlplus � ������������ ����� ������ ��� ������������ SYSTEM, 
--�������� ������ ��������� �����������, ������ ��������� �����������, ����� � �������������.

--connect system/MANAGER@localhost:1521/KAS_PDB

--select * from v$pdbs;
--select * from v$tablespace;
--select * from dba_data_files;
--select * from all_users;
--select * from dba_role_privs;



---------5---------
--��������� ������� Oracle Net Manager � ����������� ������ ����������� 
--� ������ ���_������_������������_SID, ��� SID � ������������� ������������ ���� ������



---------6---------
--������������ � ������� sqlplus ��� ����������� ������������� � � ����������� �������������� ������ �����������. 

ALTER USER C##KAS IDENTIFIED BY 1234;


---------7---------
--select * from  KAS_table1

commit
grant select, insert, update, delete on KAS_table1 to C##KAS;

---------8---------
--������������ � �������� HELP.�������� ������� �� ������� TIMING. 
--�����������, ������� ������� ������ select � ����� �������.
--����� ������ ������������

--help timing
--timing start first
--select * from KAS_table1;
--timing show
--timing stop



---------9---------
--������������ � �������� DESCRIBE.�������� �������� �������� ����� �������.

--help describe;
--describe KAS_table1;




---------10---------
--�������� �������� ���� ���������, ���������� ������� �������� ��� ������������.

--connect system/MANAGER
--select * from dba_segments where owner = 'C##KASCORE';





---------11---------
--�������� �������������, � ������� �������� ���������� ���� ���������, 
--���������� ���������, ������ ������ � ������ � ����������, ������� ��� ��������.

create view EXTENTS as select extents, blocks, bytes from dba_segments;

select * from EXTENTS;
