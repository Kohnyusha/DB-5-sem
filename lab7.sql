---------1---------
--������ ������ �������� ��������� 
select name, description from v$bgprocess 
  order by 1;



---------2---------
--����� ��������, ������� �������� � �������� � ���� ������
select * from v$bgprocess 
  where paddr != '00';



---------3---------
--������� ��������� DBWn ��� � ���� ������
select count(*) from v$bgprocess 
  where paddr!= '00' 
   and 
    name like 'DBW%';

show parameter db_writer_processes;



---------4---------
--��� ���� � �����������
select * from v$instance;



---------5---------
--������ ���� ����(���� ����� �������)
select username, status, server from v$session 
  where username is not null;



---------6---------
--������� (����� ����������� ����������)
select * from v$services;



---------7---------
--��������� ���������� � �� ��������
show parameter dispatcher;



---------8---------
--������, ����������� ������� LISTENER
select * from v$services;



---------9---------
--�������� ������� ���������� � ���������
select * from v$session 
  where username is not null;



---------10---------
--���������� ����� LISTENER.ORA
--D:\Games\Oracle\app\kohnyuk\product\12.1.0\dbhome_1\NETWORK\ADMIN\listener.ora



---------11---------
--��������� ������� lsnrctl � �������� �� �������� �������
--start LSNRCTL.exe



---------12---------
--������ ����� ��������, ������������� ��������� LISTENER
--services














