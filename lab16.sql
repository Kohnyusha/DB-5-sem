--KASCORE
--1111

GRANT CREATE TABLESPACE TO C##KASCORE;

CREATE TABLESPACE t1 DATAFILE 'D:\3\БД Блинова\lab16\t1.DAT'
  SIZE 10M REUSE AUTOEXTEND ON NEXT 2M MAXSIZE 20M;
CREATE TABLESPACE t2 DATAFILE 'D:\3\БД Блинова\lab16\t2.DAT'
  SIZE 10M REUSE AUTOEXTEND ON NEXT 2M MAXSIZE 20M;  
CREATE TABLESPACE t3 DATAFILE 'D:\3\БД Блинова\lab16\t3.DAT'
  SIZE 10M REUSE AUTOEXTEND ON NEXT 2M MAXSIZE 20M;  
CREATE TABLESPACE t4 DATAFILE 'D:\3\БД Блинова\lab16\t4.DAT'
  SIZE 10M REUSE AUTOEXTEND ON NEXT 2M MAXSIZE 20M;
CREATE TABLESPACE t5 DATAFILE 'D:\3\БД Блинова\lab16\t5.DAT' 
  SIZE 10M REUSE AUTOEXTEND ON NEXT 2M MAXSIZE 20M;  
  
CREATE TABLESPACE t6 DATAFILE 'D:\3\БД Блинова\lab16\t6.DAT'
  SIZE 10M REUSE AUTOEXTEND ON NEXT 2M MAXSIZE 20M;  
  
CREATE TABLESPACE t7 DATAFILE 'D:\3\БД Блинова\lab16\t7.DAT'
  SIZE 10M REUSE AUTOEXTEND ON NEXT 2M MAXSIZE 20M; 
CREATE TABLESPACE t8 DATAFILE 'D:\3\БД Блинова\lab16\t8.DAT'
  SIZE 10M REUSE AUTOEXTEND ON NEXT 2M MAXSIZE 20M;   
  
  
ALTER USER C##KASCORE QUOTA UNLIMITED ON t1;
ALTER USER C##KASCORE QUOTA UNLIMITED ON t2;
ALTER USER C##KASCORE QUOTA UNLIMITED ON t3;
ALTER USER C##KASCORE QUOTA UNLIMITED ON t4;
ALTER USER C##KASCORE QUOTA UNLIMITED ON t5;

---------1---------
--таблицa T_RANGE c диапазонным секционированием. Используйте ключ секционирования типа NUMBER
create table T_RANGE
(
    Num NUMERIC(3, 0)
)
partition by range (Num)
(
    Partition p1 values less than (100) tablespace t6,
    Partition p2 values less than (200) tablespace t5,
    Partition p3 values less than (maxvalue) tablespace t5
)
enable row movement;--для измненения ключа секционирования(переход строки из секции в секци)

insert into T_RANGE values (90);
insert into T_RANGE values (120);
insert into T_RANGE values (360);


select * from T_RANGE partition (p1);
select * from T_RANGE partition (p2);
select * from T_RANGE partition (p3);





---------2---------
--таблица T_INTERVAL c интервальным секционированием. Используйте ключ секционирования типа DATE
create table T_INTERVAL
(
    IntervalDate date
)
partition by range (IntervalDate)
interval (interval '1' month)
(
    partition p1 values less than (to_date('01-01-2022','dd-mm-yyyy')) tablespace t6,
    partition p2 values less than (to_date('01-02-2022','dd-mm-yyyy')) tablespace t1,
    partition p3 values less than (to_date('01-03-2022','dd-mm-yyyy')) tablespace t1
)enable row movement;


insert into T_INTERVAL values(TO_DATE('01-01-2021','dd-mm-yyyy'));
insert into T_INTERVAL values(TO_DATE('01-01-2022','dd-mm-yyyy'));
insert into T_INTERVAL values(TO_DATE('06-02-2022','dd-mm-yyyy'));

select * from T_INTERVAL partition (p1);
select * from T_INTERVAL partition (p2);
select * from T_INTERVAL partition (p3);





---------3---------
--таблица T_HASH c хэш-секционированием. Используйте ключ секционирования типа VARCHAR2
create table T_HASH
(
  cityid number,
  word varchar2(255)
)
partition by hash (word)
partitions 4
store in (t7, t8)
enable row movement;

insert into T_HASH values (1, 'Минск');
insert into T_HASH values (2, 'Пинск');
insert into T_HASH values (3, 'Гомель');
insert into T_HASH values (4, 'Гродно');

insert into T_HASH values (5, 'Мопс'); commit;

select TABLE_NAME, PARTITION_NAME, HIGH_VALUE from USER_TAB_PARTITIONS where TABLE_NAME = 'T_HASH';

--изменить SYS_P3805
select * from T_HASH partition (SYS_P3848);
select * from T_HASH partition (SYS_P3849);
select * from T_HASH partition (SYS_P3850);
select * from T_HASH partition (SYS_P3851);




---------4---------
--таблица T_LIST со списочным секционированием. Используйте ключ секционирования типа CHAR
create table T_LIST
(
    CharList char
)
partition by list (CharList)
(
    partition p1 values ('A', 'B', 'C') tablespace t3,
    partition p2 values (default) tablespace t4
)
enable row movement;

insert into T_LIST values('A');
insert into T_LIST values('K');
insert into T_LIST values('C');

select * from T_LIST partition (p1);
select * from T_LIST partition (p2);




---------6---------
--Продемонстрируйте для всех таблиц процесс перемещения строк между секциями, при изменении (оператор UPDATE) ключа секционирования
update T_RANGE set NUM = 300 where NUM = 120;

update T_INTERVAL set IntervalDate = '01-02-2022' where IntervalDate = '01-01-2022';

update T_HASH partition(SYS_P3806) set word = 'Столица Беларуси' where WORD = 'Минск';

update T_LIST set CharList = 'P' where CharList = 'A';



---------7---------
--Для одной из таблиц продемонстрируйте действие оператора ALTER TABLE MERGE.
alter table T_RANGE merge partitions
    p1, p2 into partition p4 tablespace t3;

select * from USER_TAB_PARTITIONS where TABLE_NAME = 'T_RANGE';



---------8---------
--Для одной из таблиц продемонстрируйте действие оператора ALTER TABLE SPLIT
--секция р3 разделяется на две
----------------------------
alter table T_RANGE split partition p3 into
    (
        partition a1 values less than (750),
        partition a2 
    );
    
select * from USER_TAB_PARTITIONS where TABLE_NAME = 'T_RANGE';



---------9---------
--Для одной из таблиц продемонстрируйте действие оператора ALTER TABLE EXCHANGE (обмен)
create table T_LIST1(obj char);
insert into T_LIST1 values('M');

alter table T_LIST exchange partition  p2 with T_LIST1;

select * from  T_LIST partition (p2);
select * from  T_LIST1;



drop table T_RANGE;
drop table T_INTERVAL;
drop table T_HASH;
drop table T_LIST;
drop table T_LIST1;

