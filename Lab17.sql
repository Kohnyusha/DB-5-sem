create table WORKOFFERS
(
  workerid int primary key,
  fullname varchar2(255),
  offerdate date
);

create table WORKOFFERS_ARCH
(
  workerid int primary key,
  fullname varchar2(255),
  offerdate date
);

insert into WORKOFFERS values (1, 'Кoхнюк Александра Сегеевнва', '18.12.2022');
insert into WORKOFFERS values (2, 'Савенко Евгения Александровна', '10.12.2022');
insert into WORKOFFERS values (3, 'Кришталь Дарья Сергеевна', '01.11.2022');
insert into WORKOFFERS values (4, 'Кохнюк Юлия Анатольевна', '18.11.2022');
insert into WORKOFFERS values (5, 'Суд Павел Анатольевич', '14.10.2022');


create table JOBAUDIT 
(
  jobnumber number,
  last_date date,
  last_sec varchar2(8),
  runresult varchar2(15)
);

--копир в одну табл и удаление из другой табл
create or replace procedure ARCHOFFERS (startdate date, enddate date)
    is
    countdict int;
    begin
      insert into WORKOFFERS_ARCH select * from WORKOFFERS where offerdate between startdate and enddate;
      delete from WORKOFFERS where offerdate between startdate and enddate;
end ARCHOFFERS;


------------- пакет DBMS_JOB ------------

create or replace package LAB17_TASK01_PKG is
  procedure ARCHOFFERS (startdate date, enddate date);
  procedure CREATE_JOB (jobnumber number);
  procedure CHECK_JOB (jobnumber number);
  procedure IS_JOB_RUNNING (jobnumber number);
  procedure RETIME_JOB (jobnumber number);
  procedure SUSPEND_JOB (jobnumber number);
  procedure CANCEL_JOB (jobnumber number);
end LAB17_TASK01_PKG;

create or replace package body LAB17_TASK01_PKG is
    
    --1.копир в одну табл и уудаление из другой табл
    procedure ARCHOFFERS (startdate date, enddate date)
    is
    countdict int;
    begin
      insert into WORKOFFERS_ARCH select * from WORKOFFERS where offerdate between startdate and enddate;
      delete from WORKOFFERS where offerdate between startdate and enddate;
    end ARCHOFFERS;
    
    --2.создание задания с номером
    procedure CREATE_JOB (jobnumber number)
    is
        startdate DATE := to_date('01.12.2022','DD.MM.YYYY');
        enddate DATE := to_date('18.12.2022','DD.MM.YYYY');
        action varchar2(255) := 'begin ARCHOFFERS(''' 
                                || to_char(startdate, 'DD.MM.YYYY') 
                                || ''',''' 
                                || to_char(enddate,'DD.MM.YYYY') 
                                || '''); end;';
    begin
        dbms_job.isubmit(jobnumber, 
                       action, 
                       SYSDATE, 
                       --'SYSDATE + 60/86400' 
                       --'SYSDATE + interval ''7'' day' 
                       'SYSDATE + interval ''1'' minute'
                       );
        commit;
    end CREATE_JOB;
    
    --3.выполнено ли задание
    procedure CHECK_JOB (jobnumber number)
    is
      res number;
      resstatus varchar2(15);
    begin
        insert into JOBAUDIT (select JOB, LAST_DATE, LAST_SEC, case when FAILURES = 0 then 'SUCCESS' else 'FAILURE' end from user_jobs where JOB = jobnumber); 
        commit;
    end CHECK_JOB;
    
    --4. выполняется ли сейчас
    procedure IS_JOB_RUNNING (jobnumber number)
    is
        runningtime date;
    begin
        select THIS_DATE into runningtime from user_jobs where JOB = jobnumber;
        if runningtime is null then dbms_output.put_line('Задача не выполняется');
        else dbms_output.put_line('Задача выполняется');
        end if;
    end IS_JOB_RUNNING;
    
    --5. изм параметров задания
    procedure RETIME_JOB (jobnumber number)
    is
    begin
        dbms_job.change(jobnumber, null, null, 'SYSDATE + interval ''5'' minute');
    end RETIME_JOB;
    
    --6. изм времени выплнения
    procedure SUSPEND_JOB (jobnumber number)
    is
    begin
        dbms_job.next_date(jobnumber, SYSDATE + interval '10' minute);
    end SUSPEND_JOB;
    
    --7. разрушение задания
    procedure CANCEL_JOB (jobnumber number)
    is
    begin
        dbms_job.broken(jobnumber, true, null);
    end CANCEL_JOB;
    
end LAB17_TASK01_PKG;

--поменять номер
begin
  LAB17_TASK01_PKG.CREATE_JOB(97);
end;

begin
  LAB17_TASK01_PKG.CHECK_JOB(97);
end;

select * from JOBAUDIT;

--
begin
  LAB17_TASK01_PKG.IS_JOB_RUNNING(97);
end;

begin
  LAB17_TASK01_PKG.RETIME_JOB(97);
end;
select JOB, INTERVAL from user_jobs;

begin
  LAB17_TASK01_PKG.SUSPEND_JOB(97);
end;

begin
  LAB17_TASK01_PKG.CANCEL_JOB(97);
end;




drop table WORKOFFERS;
drop table WORKOFFERS_ARCH;
drop table JOBAUDIT;

drop package LAB17_TASK01_PKG;





