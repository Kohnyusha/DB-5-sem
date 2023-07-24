 

--sqlldr XXXCORE1/1234 CONTROL=control.ctl

--from_file
sqlldr bnd_user/qwerty@nadezhda CONTROL=my_control_options.ctl

--to_file
spool E:\3c\Oracle\file1.txt;
  SELECT  TEACHER_NAME || ',' || PULPIT || ',' || BIRTHDAY || ',' || SALARY   FROM teacher;
spool off;

select * from teacher;

drop table TEACHER_LOAD;
select * from TEACHER_LOAD ;
delete from TEACHER_LOAD;
CREATE TABLE TEACHER_LOAD
 ( 
  TEACHER       CHAR(10),
  TEACHER_NAME  VARCHAR2(50), 
  SALARY        decimal, 
  BIRHTDAY      date
 ) ;
 
 
 commit;