select * from Diets;

drop procedure getAllDiets;
drop procedure addDiet;
drop procedure changeDietByType;
drop procedure changeDietByName;
drop procedure deleteDietById;


----вывести все диеты-----
create or replace procedure getAllDiets
is
cursor curs is select diets.namediet from diets;
    namediet diets.namediet%type;
begin
  open curs;
    loop 
        fetch curs into namediet;
        exit when curs%notfound;
        dbms_output.put_line(namediet);
    end loop;
    close curs;
exception
when others
then SYS.dbms_output.put_line(sqlcode || sqlerrm);
end;

begin 
  getAllDiets();
end;


----добавить диету ----
create or replace procedure addDiet
(
  id_diet diets.id_diet%type, 
  namediet diets.namediet%type, 
  typediet diets.typediet%type, 
  dayamount diets.dayamount%type, 
  description diets.description%type
) 
is
begin
insert into diets(id_diet, namediet, typediet, DayAmount, description) values (id_diet, namediet, typediet, DayAmount, description);
SYS.dbms_output.put_line('Diet was inserted');
exception
when others
then SYS.dbms_output.put_line(sqlcode || sqlerrm);
end;

begin 
  addDiet(t_sequence_diets.nextval, 'Новая', '8-Ужин', 7, 'Результат уже через неделею!');
end;


select * from diets;

----изменить тип диеты по id диеты----
create or replace procedure changeDietById(typed diets.typediet%type, id diets.id_diet%type)
is
begin
update diets SET typediet = typed where id_diet = id;
SYS.dbms_output.put_line('Diet was udpdate');
exception
when others
then SYS.dbms_output.put_line(sqlcode || sqlerrm);
end;

begin 
  ChangeDietById('10-Ужин', 13);
end;


----изменить описание диеты по названию диеты----
create or replace procedure changeDietByName(namedi diets.namediet%type, descr diets.description%type)
is
begin
update diets SET description = descr where namediet = namedi;
SYS.dbms_output.put_line('Diet was udpdate');
exception
when others
then SYS.dbms_output.put_line(sqlcode || sqlerrm);
end;

begin 
  changeDietByName('Куриное филе и овощи', 'Новое описание, Новое описание, Новое описание');
end;



----удалить диету----
create or replace procedure deleteDietById(id diets.id_diet%type)
is
begin
delete from diets where diets.id_diet = id;
SYS.dbms_output.put_line('Diet was deleted');
exception
when others
then SYS.dbms_output.put_line(sqlcode || sqlerrm);
end;

begin 
  deleteDietById(13);
end;


