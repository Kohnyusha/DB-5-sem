grant create trigger to C##KASCORE;
---------1---------
create table tabl
(
  a int primary key,
  b varchar(30) 
);

drop table tabl;

---------2---------
declare 
        i int :=0;
    begin
        while i<10
        loop
            insert into tabl(a,b) values (i,'a');
            i:= i+1;
        end loop;
    end;

select * from tabl;



---------3---------
--Создайте BEFORE – триггер уровня оператора на события INSERT, DELETE и UPDATE
create or replace trigger BeforeTriggerI
    before insert on tabl
    begin 
      dbms_output.put_line('Триггер уровня оператора INSERT'); 
    end;

insert into tabl values (31,'Mmm');
    
    
    
create or replace trigger BeforeTriggerD
    before delete on tabl
    begin 
      dbms_output.put_line('Триггер уровня оператора DELETE'); 
    end;

delete tabl where a=31;
    
   
    
create or replace trigger BeforeTriggerU
    before update on tabl
    begin 
      dbms_output.put_line('Триггер уровня оператора UPDATE'); 
    end;
    
update tabl set a=101 where a=3;


drop trigger BeforeTriggerI;
drop trigger BeforeTriggerD;
drop trigger BeforeTriggerU;

---------5---------
--Создайте BEFORE-триггер уровня строки на события INSERT, DELETE и UPDATE
create or replace trigger BeforeTriggerLineI
    before insert on tabl
    for each row
    begin 
      dbms_output.put_line('Триггер уровня строки INSERT'); 
    end;

insert into tabl values (11, 'Zzz');
insert into tabl values (12, 'Zzz');

insert into tabl values (13, 'Mmmmmm');
insert into tabl values (14, 'Mmmmmm');

create or replace trigger BeforeTriggerLineU
    before update on tabl
    for each row
    begin 
      dbms_output.put_line('Триггер уровня строки UPDATE'); 
    end;

update tabl set b='FFFFFFF' where b='Mmmmmm';


create or replace trigger BeforeTriggerLineD
    before delete on tabl
    for each row
    begin 
      dbms_output.put_line('Триггер уровня строки DELETE'); 
    end;

delete tabl where b='Zzz';


drop trigger BeforeTriggerLineI;
drop trigger BeforeTriggerLineD;
drop trigger BeforeTriggerLineU;



---------6---------
--применить предикаты
create or replace trigger TriggerBefore
    after insert or update or delete on tabl
    begin
    if INSERTING then
        dbms_output.put_line('Inserting after');
    elsif UPDATING then
        dbms_output.put_line('Updating after');
    elsif DELETING then
        dbms_output.put_line('Deleting after');
    end if;
    end;  


insert into tabl values (15, 'Mmmmmm');

delete tabl where a=17;

update tabl set b='FFFFFFF' where b='Mmmmmm';


drop trigger TriggerBefore;


---------7---------
--Разработайте AFTER-триггеры уровня строки на события INSERT, DELETE и UPDATE
create or replace trigger AfterTriggerI
    after insert on tabl
    begin 
      dbms_output.put_line('After-триггер уровня оператора INSERT'); 
    end;

insert into tabl values (45,'Mmm');
    
    
    
create or replace trigger AfterTriggerD
    after delete on tabl
    begin 
      dbms_output.put_line('After-триггер уровня оператора DELETE'); 
    end;

delete tabl where a=45;
    
   
    
create or replace trigger AfterTriggerU
    after update on tabl
    begin 
      dbms_output.put_line('After-триггер уровня оператора UPDATE'); 
    end;
    
update tabl set a=102 where a=4;


drop trigger AfterTriggerI;
drop trigger AfterTriggerD;
drop trigger AfterTriggerU;



---------8---------
--Разработайте AFTER-триггеры уровня строки на события INSERT, DELETE и UPDATE
create or replace trigger AfterTriggerLineI
    after insert on tabl
    for each row
    begin 
      dbms_output.put_line('Аfter-триггер уровня строки INSERT'); 
    end;

insert into tabl values (21, 'Zzz');
insert into tabl values (22, 'Zzz');

insert into tabl values (23, 'Mmmmmm');
insert into tabl values (24, 'Mmmmmm');

create or replace trigger AfterTriggerLineU
    after update on tabl
    for each row
    begin 
      dbms_output.put_line('Аfter-триггер уровня строки UPDATE'); 
    end;

update tabl set b='FFFFFFF' where b='Mmmmmm';


create or replace trigger AfterTriggerLineD
    after delete on tabl
    for each row
    begin 
      dbms_output.put_line('Аfter-триггер уровня строки DELETE'); 
    end;


delete tabl where b='ввв';


drop trigger AfterTriggerLineI;
drop trigger AfterTriggerLineD;
drop trigger AfterTriggerLineU;



---------9---------
create table AUDITS
(
        OperationDate date,         
        OperationType varchar2(40), --тип операции
        TriggerName varchar2(40),
        Data varchar2(40)           --знач полей до и после операции
);

drop table AUDITS;



---------10---------
--Измените триггеры таким образом, чтобы они регистрировали все операции с исходной таблицей в таблице AUDIT.
create or replace trigger AUDITS_trigger_before
    before insert or update  or delete on tabl
    begin
        if inserting then
            dbms_output.put_line('before_insert_AUDITS');
            INSERT INTO AUDITS(OperationDate, OperationType, TriggerName, Data)
            SELECT sysdate,'Insert', 'AUDITS_trigger_before',concat(tabl.a ,tabl.b)
            FROM tabl;
        elsif updating then
            dbms_output.put_line('before_update_AUDITS');
            INSERT INTO AUDITS(OperationDate, OperationType, TriggerName, Data)
            SELECT sysdate,'Update', 'AUDITS_trigger_before',concat(tabl.a ,tabl.b)
            FROM tabl;
        elsif deleting then
            dbms_output.put_line('before_delete_AUDITS');
            INSERT INTO AUDITS(OperationDate, OperationType, TriggerName, Data)
            SELECT sysdate,'Delete', 'AUDITS_trigger_before',concat(a ,b)
            FROM tabl;
        end if;
    end;


create or replace trigger AUDITS_trigger_after
    after insert or update  or delete on tabl
    begin
        if inserting then
            dbms_output.put_line('after_insert_AUDITS');
            INSERT INTO AUDITS(OperationDate, OperationType, TriggerName, Data)
            SELECT sysdate,'Insert', 'AUDITS_trigger_after',concat(tabl.a ,tabl.b)
            FROM tabl;
        elsif updating then
            dbms_output.put_line('after_update_AUDITS');
            INSERT INTO AUDITS(OperationDate, OperationType, TriggerName, Data)
            SELECT sysdate,'Update', 'AUDITS_trigger_after',concat(tabl.a ,tabl.b)
            FROM tabl;
        elsif deleting then
            dbms_output.put_line('after_delete_AUDITS');
            INSERT INTO AUDITS(OperationDate, OperationType, TriggerName, Data)
            SELECT sysdate,'Delete', 'AUDITS_trigger_after',concat(a ,b)
            FROM tabl;
        end if;
    end;


select * from tabl;
select * from audits;
update tabl set b = 'Mmm';

insert into tabl values (55, 'HHHHH');
delete tabl where b='HHHHH';

drop trigger AUDITS_trigger_before;
drop trigger AUDITS_trigger_after;



---------11---------
--Выполните операцию, нарушающую целостность таблицы по первичному ключу. 
--Выясните, зарегистрировал ли триггер это событие. 
insert into tabl values (555, 44444);


---------12---------
--Удалите (drop) исходную таблицу. Объясните результат. Добавьте триггер, запрещающий удаление исходной таблицы

drop table tabl;
select * from USER_TRIGGERS; --триггеры также удаляются

create table ABSD
(
  a int primary key,
  b varchar(30) 
);

create or replace trigger CannotBeDeletedTabl
    before drop on schema
    begin
        if ORA_DICT_OBJ_NAME = 'ABSD'
            then RAISE_APPLICATION_ERROR(-20000, 'Таблицу ABSD ЗАПРЕЩЕНО удалять');
        end if;
    end;

drop table ABSD;
--FLASHBACK table tabl TO BEFORE DROP;

drop trigger CannotBeDeletedTabl;

---------13---------
--Удалите (drop) таблицу AUDIT. Просмотрите состояние триггеров с помощью SQL-DEVELOPER. Измените триггеры.
drop table AUDITS;

SELECT TRIGGER_NAME, STATUS FROM USER_TRIGGERS;


create or replace trigger AUDITS_trigger_before
    before insert or update  or delete on tabl
    begin
        if inserting then
            BEGIN
                DBMS_OUTPUT.PUT_LINE('Operation date: ' || SYSDATE);
                DBMS_OUTPUT.PUT_LINE('Operation type: INSERT');
                DBMS_OUTPUT.PUT_LINE('Trigger name: tabl');
            END;
        ELSIF DELETING THEN
            BEGIN
                DBMS_OUTPUT.PUT_LINE('Operation date: ' || SYSDATE);
                DBMS_OUTPUT.PUT_LINE('Operation type: DELETE');
                DBMS_OUTPUT.PUT_LINE('Trigger name: tabl');      
            END;
        ELSIF UPDATING THEN
            BEGIN
                DBMS_OUTPUT.PUT_LINE('Operation date: ' || SYSDATE);
                DBMS_OUTPUT.PUT_LINE('Operation type: UPDATE');
                DBMS_OUTPUT.PUT_LINE('Trigger name: tabl');
            END;
        end if;
    end;


create or replace trigger AUDITS_trigger_after
    after insert or update  or delete on tabl
    begin
        if inserting then
            BEGIN
                DBMS_OUTPUT.PUT_LINE('Operation date: ' || SYSDATE);
                DBMS_OUTPUT.PUT_LINE('Operation type: INSERT');
                DBMS_OUTPUT.PUT_LINE('Trigger name: tabl');
            END;
        ELSIF DELETING THEN
            BEGIN
                DBMS_OUTPUT.PUT_LINE('Operation date: ' || SYSDATE);
                DBMS_OUTPUT.PUT_LINE('Operation type: DELETE');
                DBMS_OUTPUT.PUT_LINE('Trigger name: tabl');      
            END;
        ELSIF UPDATING THEN
            BEGIN
                DBMS_OUTPUT.PUT_LINE('Operation date: ' || SYSDATE);
                DBMS_OUTPUT.PUT_LINE('Operation type: UPDATE');
                DBMS_OUTPUT.PUT_LINE('Trigger name: tabl');
            END;
        end if;
    end;
    
drop trigger AUDITS_trigger_before;
drop trigger AUDITS_trigger_after;
    
    
---------14---------
--Создайте представление над исходной таблицей. Разработайте INSTEADOF INSERT-триггер. 
--Триггер должен добавлять строку в таблицу.
create view tablview as SELECT * FROM tabl;

drop view tablview;

  
    CREATE OR REPLACE TRIGGER tabl_trigg
    instead of insert on tablview
    BEGIN
        if inserting then
            dbms_output.put_line('insert');
            insert into tabl VALUES (110, 'bye');
        end if;
    END tabl_trigg;
 
drop TRIGGER tabl_trigg;
 
    
    INSERT INTO tablview (a,b) values(103,'ccc');
    SELECT * FROM tablview;

select * from tabl;

---------15---------
--Продемонстрируйте, в каком порядке выполняются триггеры.

create table ABCD (x number (5));

create trigger ABCDb
    before insert on ABCD
    begin
        DBMS_OUTPUT.PUT_LINE('BEFORE');
    end;

create trigger ABCDbeforeFOREACHROW
    before insert on ABCD
    for each row
    begin
        DBMS_OUTPUT.PUT_LINE('BEFORE FOR EACH ROW');
    end;

create trigger ABCDa
    after insert on ABCD
    begin
        DBMS_OUTPUT.PUT_LINE('AFTER');
    end;

create trigger ABCDafterFOREACHROW
    after insert on ABCD
    for each row
    begin
        DBMS_OUTPUT.PUT_LINE('AFTER FOR EACH ROW');
    end;

insert into ABCD values(1);

drop table ABCD;









