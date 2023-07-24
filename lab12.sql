---------1---------
select * from teacher;    

--2 и 7 задание
---------2---------
--вывести Фамилия И.О.
select regexp_substr(teacher_name,'(\S+)',1, 1)||' '||
      substr(regexp_substr(teacher_name,'(\S+)',1, 2),1, 1)||'. '||
      substr(regexp_substr(teacher_name,'(\S+)',1, 3),1, 1)||'. ' Фамилия_И_О
    from teacher;



---------3---------
--список преподавателей, родившихся в понедельник
select teacher_name from teacher
    where TO_CHAR((birthday), 'd') = 2;



---------4---------
--представление со списком преподавателей, родившихся в след месяце
create view NextMonthBirth as
    select * from teacher
     where to_char(birthday, 'mm') = to_char(add_months(sysdate, 1), 'mm');
    
select * from NextMonthBirth;

drop view NextMonthBirth;



---------5---------
--представление с кол-вом преподавателей, родившихся в каждом месяце
create view NumberOfMonths as
     select to_char(birthday, 'Month') Месяц,
            count(*) Количество
            from teacher
            group by to_char(birthday, 'Month')
            order by to_char(birthday, 'Month');
     
select * from NumberOfMonths;

drop view NumberOfMonths;


---------6---------
--преподаватели, у которых в след году юбелей
cursor TeacherBirtday(teacher%rowtype) 
        return teacher%rowtype is
        select teacher_name, birthday from teacher
        where MOD((TO_CHAR(sysdate,'yyyy') - TO_CHAR(birthday, 'yyyy')+1), 5)=0;


---------7---------
--среднюю заработную плату по кафедрам с округлением вниз до целых
cursor AvgSalary(teacher.salary%type,teacher.pulpit%type) 
      return teacher.salary%type,teacher.pulpit%type  is
        select floor(avg(salary)), pulpit
        from teacher
        group by pulpit;


--вывести средние итоговые значения для каждого факультета
cursor AvgSalaryFaculty(teacher.salary%type,pulpit.faculty%type)
return teacher.salary%type,pulpit.faculty%type  is
select round(AVG(T.salary),3)Среднее,P.faculty
    from teacher T
    inner join pulpit P
    on T.pulpit = P.pulpit
    group by P.faculty
    union
      select floor(avg(salary)), teacher.pulpit
        from teacher
        group by teacher.pulpit
    order by faculty;


--для всех факультетов в целом
cursor AvgSalaryUniver(teacher.salary%type)
return teacher.salary%type  is
select round(avg(salary),3) Среднее 
  from teacher;



---------8---------
--Создайте собственный тип PL/SQL-записи (record) и продемонстрируйте работу с ним. 
--Продемонстрируйте работу с вложенными записями. 
--Продемонстрируйте и объясните операцию присвоения
declare
        type ADDRESS is record
        (
          town nvarchar2(20),
          country nvarchar2(20)
        );
        type PERSON is record
        (
          name teacher.teacher_name%type,
          pulp teacher.pulpit%type,
          homeAddress ADDRESS
        );
      per1 PERSON;
      per2 PERSON;
    begin
      select teacher_name, pulpit into per1.name, per1.PULP
      from teacher
      where teacher='СМЛВ';
      per1.homeAddress.town := 'Минск';
      per1.homeAddress.country := 'Беларусь';
      per2 := per1;
      dbms_output.put_line( per2.name||' '|| per2.pulp||' из '||
                            per2.homeAddress.town||', '|| per2.homeAddress.country);
    end;


