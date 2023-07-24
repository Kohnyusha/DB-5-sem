------------ USERS ------------
create tablespace TS
  datafile 'D:\3\6семестр\курсач БД\tablespace\TS.dbf'
  size 7m                       
  autoextend on next 5m         
  maxsize 50m;

create temporary tablespace TS_TEMP
  tempfile 'D:\3\6семестр\курсач БД\tablespace\TS_TEMP.dbf'
  size 7m                       
  autoextend on next 5m         
  maxsize 50m;

select TABLESPACE_NAME, contents logging from SYS.DBA_TABLESPACES;

--создадим нового пользователя и необх для него
create role C##RL_KAS;

grant create session,
      create table, 
      create view, 
      create procedure,
      drop any table,
      drop any view,
      drop any procedure to C##RL_KAS;  
      
grant alter any table to C##RL_KAS;  
grant create sequence to C##RL_KAS;  
      

create profile C##PF_KAS limit
  password_life_time 180            
  sessions_per_user 3             
  failed_login_attempts 7         
  password_lock_time 1            
  password_reuse_time 10          
  password_grace_time default     
  connect_time 180                
  idle_time 30;                   


create user C##KAS identified by 1111
  default tablespace TS 
  temporary tablespace TS_TEMP 
  profile C##PF_KAS              
  account unlock;                    

grant C##RL_KAS to C##KAS;

grant create tablespace, 
      alter tablespace 
      UNLIMITED TABLESPACE to C##KAS;
      
grant unlimited tablespace to C##KAS;

create tablespace KASQDATA offline
  datafile 'D:\3\6семестр\курсач БД\tablespace\KAS_QDATA.dbf'
  size 10m                       
  autoextend on next 5m         
  maxsize 20m;

alter tablespace KASQDATA online;

alter user C##KAS quota 2M on KASQDATA;


GRANT EXECUTE ON getAllTrainings TO C##KAS;
GRANT EXECUTE ON getAllDiets TO C##KAS;
GRANT EXECUTE ON getAllLikesTrainUser TO C##KAS;
GRANT EXECUTE ON getAllLikesDietUser TO C##KAS;
GRANT EXECUTE ON getAllLikesDiets TO C##KAS;
GRANT EXECUTE ON getAllLikesTrains TO C##KAS;
GRANT EXECUTE ON getAllFinishTrain TO C##KAS;
GRANT EXECUTE ON getAllLikesDietUser TO C##KAS;

GRANT EXECUTE ON addLikesTraining TO C##KAS;
GRANT EXECUTE ON addLikesDiet TO C##KAS;
GRANT EXECUTE ON deleteLikesTrainById TO C##KAS;
GRANT EXECUTE ON deleteLikesDietById TO C##KAS;
GRANT EXECUTE ON getAllFinishTrainUser TO C##KAS;


GRANT SELECT ON trainings TO C##KAS;
GRANT SELECT ON diets TO C##KAS;
GRANT SELECT ON likestrainings TO C##KAS;
GRANT SELECT ON likesdiets TO C##KAS;
GRANT SELECT ON FinishTraining TO C##KAS;

GRANT insert ON likestrainings TO C##KAS;
GRANT insert ON likesdiets TO C##KAS;

GRANT delete ON likestrainings TO C##KAS;
GRANT delete ON likesdiets TO C##KAS;