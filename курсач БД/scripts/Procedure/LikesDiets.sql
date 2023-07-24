select * from likesdiets;
select * from diets;

----вывести избранные диеты-----
create or replace procedure getAllLikesDiets
is
cursor curs is select likesdiets.id_like, likesdiets.typelikes from likesdiets;
    id_like likesdiets.id_like%type;
    typelikes likesdiets.typelikes%type;
begin
  open curs;
    loop
        fetch curs into id_like, typelikes;
        exit when curs%notfound;
        dbms_output.put_line(id_like ||' '|| typelikes);
    end loop;
    close curs;
exception
when others
then SYS.dbms_output.put_line(sqlcode || sqlerrm);
end;

begin 
  getAllLikesDiets();
end;



----вывести избранные диеты определенного пользователя-----
create or replace procedure getAllLikesDietUser(id_u likesdiets.id_user%type)
is
cursor curs is select likesdiets.id_like, likesdiets.typelikes from likesdiets
    where id_user = id_u;
    id_like likesdiets.id_like%type;
    typelikes likesdiets.typelikes%type;
begin
  open curs;
    loop
        fetch curs into id_like, typelikes;
        exit when curs%notfound;
        dbms_output.put_line(id_like ||' '|| typelikes);
    end loop;
    close curs;
exception
when others
then SYS.dbms_output.put_line(sqlcode || sqlerrm);
end;

begin 
  getAllLikesDietUser(3);
end;



----удалить диету из избранного по id диеты----
create or replace procedure deleteLikesDietById(ids likesdiets.id_diet%type)
is
begin
delete from likesdiets where likesdiets.id_diet = ids;
SYS.dbms_output.put_line('Diet was deleted from favorites');
exception
when others
then SYS.dbms_output.put_line(sqlcode || sqlerrm);
end;

begin 
  deleteLikesDietById(8);
end;



create or replace procedure addLikesDiet
(
  id_user diets.id_diet%type, 
  id_diet diets.namediet%type, 
  typelikes diets.typediet%type
) 
is
begin
insert into likesdiets(id_user, id_diet, typelikes) values (id_user, id_diet, typelikes);
SYS.dbms_output.put_line('LikesDiet was inserted');
exception
when others
then SYS.dbms_output.put_line(sqlcode || sqlerrm);
end;

begin 
  addLikesDiet(2, 6, '2-Обед');
end;


