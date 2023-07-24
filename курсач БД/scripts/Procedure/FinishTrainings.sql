select * from finishtraining;
select * from trainings;

----вывести завершенные тренировки-----
create or replace procedure getAllFinishTrain
is
cursor curs is select finishtraining.id_type, finishtraining.typetrain from finishtraining;
    id_type finishtraining.id_type%type;
    typetrain finishtraining.typetrain%type;
begin
  open curs;
    loop
        fetch curs into id_type, typetrain;
        exit when curs%notfound;
        dbms_output.put_line(id_type ||' '|| typetrain);
    end loop;
    close curs;
exception
when others
then SYS.dbms_output.put_line(sqlcode || sqlerrm);
end;

begin 
  getAllFinishTrain();
end;



----вывести завершенные тренировки определенного пользователя-----
create or replace procedure getAllFinishTrainUser(id_u finishtraining.id_user%type)
is
cursor curs is select finishtraining.id_type, finishtraining.typetrain from finishtraining
    where id_user = id_u;
    id_type finishtraining.id_type%type;
    typetrain finishtraining.typetrain%type;
begin
  open curs;
    loop
        fetch curs into id_type, typetrain;
        exit when curs%notfound;
        dbms_output.put_line(id_type ||' '|| typetrain);
    end loop;
    close curs;
exception
when others
then SYS.dbms_output.put_line(sqlcode || sqlerrm);
end;

begin 
  getAllFinishTrainUser(9);
end;



----удалить тренировку из завершенных по id тренировки----
create or replace procedure deleteFinishTrainById(id finishtraining.id_train%type)
is
begin
delete from finishtraining where finishtraining.id_train = id;
SYS.dbms_output.put_line('Training was deleted from completed');
exception
when others
then SYS.dbms_output.put_line(sqlcode || sqlerrm);
end;

begin 
  deleteFinishTrainById(12);
end;



----удалить тренировку из завершенных по id юзера----
create or replace procedure deleteFinishTrainByIdUser(id finishtraining.id_user%type)
is
begin
delete from finishtraining where finishtraining.id_user = id;
SYS.dbms_output.put_line('Training was deleted from completed');
exception
when others
then SYS.dbms_output.put_line(sqlcode || sqlerrm);
end;

begin 
  deleteFinishTrainByIdUser(10);
end;

