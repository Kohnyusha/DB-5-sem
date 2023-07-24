select * from trainings;

drop procedure addTraining;
drop procedure changeTrainByName;
drop procedure deleteTrainById;
drop procedure changeTrainByLessons;



----������� ��� ����������-----
create or replace procedure getAllTrainings
is
cursor curs is select trainings.nametrain from trainings;
    nametrain trainings.nametrain%type;
begin
  open curs;
    loop 
        fetch curs into nametrain;
        exit when curs%notfound;
        dbms_output.put_line(nametrain);
    end loop;
    close curs;
exception
when others
then SYS.dbms_output.put_line(sqlcode || sqlerrm);
end;

begin 
  getAllTrainings();
end;



----�������� ����������----
create or replace procedure addTraining (id_training trainings.id_train%type, nametrain trainings.nametrain%type, typetrain trainings.typetrain%type, lessons trainings.lessons%type, description trainings.description%type) 
is
begin
insert into trainings(id_train, nametrain, typetrain, lessons, description) values (id_training, nametrain, typetrain, lessons, description);
SYS.dbms_output.put_line('Training was inserted');
exception
when others
then SYS.dbms_output.put_line(sqlcode || sqlerrm);
end;

begin 
  addTraining(t_sequence_trainings.nextval, '����� ����������', '5-��������', 20, '�� ����� ����� �� ���������� � �����������.');
end;

select * from trainings;


----�������� �������� ���������� �� id----
create or replace procedure changeTrainById(nametraining trainings.nametrain%type, id trainings.id_train%type)
is
begin
update trainings SET nametrain = nametraining where id_train = id;
SYS.dbms_output.put_line('Training was udpdate');
exception
when others
then SYS.dbms_output.put_line(sqlcode || sqlerrm);
end;

begin 
  ChangeTrainById('UpdateName', 16);
end;

select * from trainings;

----�������� ���������� ���������� �� �������� ����������----
create or replace procedure changeTrainByName(lessonstrain trainings.lessons%type, nametraining trainings.nametrain%type)
is
begin
update trainings SET lessons = lessonstrain where nametrain = nametraining;
SYS.dbms_output.put_line('Training was udpdate');
exception
when others
then SYS.dbms_output.put_line(sqlcode || sqlerrm);
end;


begin 
  ChangeTrainByName(100, 'UpdateName');
end;

select * from trainings;

----������� ����������----
create or replace procedure deleteTrainById(id trainings.id_train%type)
is
begin
delete from trainings where trainings.id_train = id;
SYS.dbms_output.put_line('Training was deleted');
exception
when others
then SYS.dbms_output.put_line(sqlcode || sqlerrm);
end;

begin 
  deleteTrainById(16);
end;










