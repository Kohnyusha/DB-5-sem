select * from likestrainings;


----вывести избранные тренировки-----
create or replace procedure getAllLikesTrains
is
cursor curs is select likestrainings.id_like, likestrainings.typelikes from likestrainings;
    id_like likestrainings.id_like%type;
    typelikes likestrainings.typelikes%type;
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
  getAllLikesTrains();
end;



----вывести избранные тренировки определенного пользователя-----
create or replace procedure getAllLikesTrainUser(id_u likestrainings.id_user%type)
is
cursor curs is select likestrainings.id_like, likestrainings.typelikes from likestrainings
    where id_user = id_u;
    id_like likestrainings.id_like%type;
    typelikes likestrainings.typelikes%type;
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
  getAllLikesTrainUser(5);
end;



----удалить тренировку из избранного по id тренировки----
create or replace procedure deleteLikesTrainById(ids likestrainings.id_train%type)
is
begin
delete from likestrainings where likestrainings.id_train = ids;
SYS.dbms_output.put_line('Training was deleted from favorites');
exception
when others
then SYS.dbms_output.put_line(sqlcode || sqlerrm);
end;

begin 
  deleteLikesTrainById(7);
end;



---------------------
create or replace procedure addLikesTraining
(
  id_user diets.id_diet%type, 
  id_train diets.namediet%type, 
  typelikes diets.typediet%type
) 
is
begin
insert into likestrainings(id_user, id_train, typelikes) values (id_user, id_train, typelikes);
SYS.dbms_output.put_line('LikesTraining was inserted');
exception
when others
then SYS.dbms_output.put_line(sqlcode || sqlerrm);
end;

begin 
  addLikesTraining(2, 9, '2-Упражнение');
end;