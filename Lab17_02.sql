drop procedure SCHEDULPROC;
drop package LAB17_TASK02_PKG;
drop table JOBAUDIT_SCHEDULED;

create or replace procedure SCHEDULPROC (startdate date, enddate date)
    is
    countdict int;
    begin
      insert into WORKOFFERS_ARCH select * from WORKOFFERS where offerdate between startdate and enddate;
      delete from WORKOFFERS where offerdate between startdate and enddate;
end SCHEDULPROC;

create or replace package LAB17_TASK02_PKG 
is
   procedure BUILD_JOB (jobname user_scheduler_jobs.job_name%type);
   procedure CHECK_JOB (jobname user_scheduler_jobs.job_name%type);
   procedure IS_JOB_RUNNING (jobname user_scheduler_jobs.job_name%type);
   procedure RETIME_JOB;
   procedure SUSPEND_JOB (jobname user_scheduler_jobs.job_name%type);
   procedure RESUME_JOB (jobname user_scheduler_jobs.job_name%type);
   procedure CANCEL_JOB (jobname user_scheduler_jobs.job_name%type);
end LAB17_TASK02_PKG;

create or replace package body LAB17_TASK02_PKG is  
    procedure BUILD_JOB (jobname user_scheduler_jobs.job_name%type)
    is
    begin  
    --расписание
    dbms_scheduler.create_schedule(
    schedule_name => 'Sch01',
    start_date => SYSTIMESTAMP,
    repeat_interval => 'FREQ=MINUTELY;INTERVAL=5;',
    comments => 'Sch01');
    
    --программа  
    dbms_scheduler.create_program(
    program_name => 'Pr01',
    program_type => 'STORED_PROCEDURE',
    program_action => 'SCHEDULPROC',
    number_of_arguments => 2,
    enabled => false,
    comments => 'SCHEDULPROC'); 

    dbms_scheduler.define_program_argument(
    program_name => 'Pr01', 
    argument_name => 'startdate', 
    argument_position => 1,  
    argument_type  => 'DATE', 
    default_value  => null);

    dbms_scheduler.define_program_argument(
    program_name => 'Pr01', 
    argument_name => 'enddate', 
    argument_position => 2,  
    argument_type  => 'DATE', 
    default_value  => null);

    dbms_scheduler.enable (name => 'Pr01');

    --плановая программа
    dbms_scheduler.create_job(
    job_name => jobname, 
    program_name => 'Pr01', 
    schedule_name => 'Sch01',
    enabled => true);
    
    dbms_scheduler.set_job_argument_value(job_name => jobname, argument_position => 1, argument_value => to_date('01.12.2022','DD.MM.YYYY'));
    dbms_scheduler.set_job_argument_value(job_name => jobname, argument_position => 2, argument_value => to_date('18.12.2022','DD.MM.YYYY'));

    commit;
    
    end BUILD_JOB;
    
--3.выполнено ли задание
   procedure CHECK_JOB (jobname user_scheduler_jobs.job_name%type)
    is
    begin
       delete from JOBAUDIT_SCHEDULED;
       insert into JOBAUDIT_SCHEDULED (select JOB_NAME, LOG_DATE, STATUS from user_scheduler_job_log where JOB_NAME = jobname); 
       commit;
    end CHECK_JOB;
    
--4.выполняется ли задание
    procedure IS_JOB_RUNNING (jobname user_scheduler_jobs.job_name%type)
    is
    ispresent int;
    begin
      select count(*) into ispresent from user_scheduler_running_jobs where JOB_NAME = jobname;
        if ispresent = 0 then dbms_output.put_line('Задача не выполняется');
        else dbms_output.put_line('Задача выполняется');
        end if;
    end IS_JOB_RUNNING;
 
  --5.в др время
    procedure RETIME_JOB
    is
    begin
        dbms_scheduler.set_attribute(name => 'SCH01', attribute => 'repeat_interval', value => 'FREQ=MINUTELY;INTERVAL=10;');
    end RETIME_JOB;
    
    --6.
    
     procedure SUSPEND_JOB (jobname user_scheduler_jobs.job_name%type)
     is
      begin
          dbms_scheduler.disable(jobname);
    end SUSPEND_JOB;
    
    --6.1 приостановить
    procedure RESUME_JOB (jobname user_scheduler_jobs.job_name%type)
     is
      begin
          dbms_scheduler.enable(jobname);
    end RESUME_JOB;
    
   --7.отменить
    procedure CANCEL_JOB (jobname user_scheduler_jobs.job_name%type)
    is
    begin
      dbms_scheduler.stop_job(job_name => jobname);
    end CANCEL_JOB;
    
end LAB17_TASK02_PKG;

create table JOBAUDIT_SCHEDULED
(
  jobname varchar2(261),
  logdate timestamp(6) with time zone,
  status varchar2(30)
);

begin
  LAB17_TASK02_PKG.BUILD_JOB('ARCH_WORKERS_JOB1');
end;

begin
  LAB17_TASK02_PKG.CHECK_JOB('ARCH_WORKERS_JOB1');
end;

begin
  LAB17_TASK02_PKG.IS_JOB_RUNNING('ARCH_WORKERS_JOB1');
end;

begin
  LAB17_TASK02_PKG.RETIME_JOB;
end;

begin
  LAB17_TASK02_PKG.SUSPEND_JOB('ARCH_WORKERS_JOB1');
end;

begin
  LAB17_TASK02_PKG.RESUME_JOB('ARCH_WORKERS_JOB1');
end;

begin
  LAB17_TASK02_PKG.CANCEL_JOB('ARCH_WORKERS_JOB1');
end;