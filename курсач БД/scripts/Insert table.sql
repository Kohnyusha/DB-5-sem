select * from Users;
select * from Trainings;
select * from Diets;
select * from LikesTrainings;
select * from LikesDiets;
select * from FinishTraining;

------------ TABLE USERS ------------
create sequence t_sequence_users
start with 2
increment by 1;      

drop sequence t_sequence_users;

insert into Users (Id_User, Login, UserPassword, Email, RegisterDate, IsAdmin)
       values (1, 'Admin', 'Admin123', 'kohnyukaleksandra@gmail.com', CURRENT_TIMESTAMP, 1);
   
insert into Users 
select t_sequence_users.nextval, 
       'NewUser' || dbms_random.string('x',3), 
       dbms_random.string('x',8), 
       dbms_random.string('x',12) || '@gmail.com', 
       to_date(to_char(round(dbms_random.value(1,28))) ||'.04.2023'), 0
from dual 
connect by level <= 10;    

select count(*) from users;


------------ TABLE TRAININGS ------------
create sequence t_sequence_trainings
start with 1
increment by 1; 

drop sequence t_sequence_trainings;

insert into Trainings (Id_Train, NameTrain, TypeTrain, Lessons, Description)
       values (t_sequence_trainings.nextval, '�� �����!', '1-��������', 15, '�� ����� ����� �� ���������� � �����������. �������� �������� ����������, ������� ���� ����� � �������� ����������� �� ������ ���./1. 50� ������� ���������� /2. ��������� �������� �� 50 ������ /3. ���������� �� 10 ������� /4. 10 ������ ����� /5. ������� ������ �� 10 ������� /6. ��������� ����� 30 ������');
insert into Trainings (Id_Train, NameTrain, TypeTrain, Lessons, Description)         
       values (t_sequence_trainings.nextval,'��������� ���� �������', '2-��������', 10, '�� ����� ����� �� ���������� � �����������. �������� �������� ����������, ������� ���� ����� � �������� ����������� �� ������ ���/1. 50� ������� ���������� /2. ��������� �������� �� 50 ������/3. 20 ����� ��������� /4. ������ 10p �� ����� �� ������ /5. 10 ������ ��������� ������� ������� ������ ����� /6. ������� ������ ������� 10 � ������������ ������');
insert into Trainings (Id_Train, NameTrain, TypeTrain, Lessons, Description)           
       values (t_sequence_trainings.nextval,'�������� ��� ��������� ������', '3-��������', 5, '�� ����� ����� �� ���������� � �����������. �������� �������� ����������, ������� ���� ����� � �������� ����������� �� ������ ���./1. 50� ������� ���������� /2. ��������� �������� �� 50 ������ /3. 10 ������ ����� /4. ������ 10p �� ����� �� ������ ');
insert into Trainings (Id_Train, NameTrain, TypeTrain, Lessons, Description)
       values (t_sequence_trainings.nextval,'�������� ����� � ���', '1-���������', 8, '�������� ���������� ���������� ���������� ������������ � ����������� �� ������ ���������� � ������, �� � �������� �������������� ����� ���� � �����./ 1. �������� ���� 20p /2. 10-�������� ����� ��� ����� /3. 5-�������� ����� /4. 10 ������ �����-������ /5. �������� ��������� /6. �������� ����� 10p');
insert into Trainings (Id_Train, NameTrain, TypeTrain, Lessons, Description)          
       values (t_sequence_trainings.nextval,'���������� ��������', '2-���������', 8, '�������� ���������� ���������� ���������� ������������ � ����������� �� ������ ���������� � ������, �� � �������� �������������� ����� ���� � �����./1. �������� ���� 20p /2. 10-�������� ����� ��� ����� /3. 5-�������� ����� /4. 10 ������ �����-������ /5. �������� ��������� 6. �������� ����� 10p');
insert into Trainings (Id_Train, NameTrain, TypeTrain, Lessons, Description)           
       values (t_sequence_trainings.nextval,'������������ ���� ����', '3-���������', 12, '�������� ���������� ���������� ���������� ������������ � ����������� �� ������ ���������� � ������, �� � �������� �������������� ����� ���� � �����./1. �������� ���� 20p /2. 10-�������� ����� ��� ����� /3. 5-�������� ����� /4. 10 ������ �����-������ /5. �������� ��������� 6. �������� ����� 10p');
insert into Trainings (Id_Train, NameTrain, TypeTrain, Lessons, Description)          
       values (t_sequence_trainings.nextval, '�� ������ ����', '4-���������', 7, '�������� ���������� ���������� ���������� ������������ � ����������� �� ������ ���������� � ������, �� � �������� �������������� ����� ���� � �����./1. �������� ���� 20p /2. 10-�������� ����� ��� ����� /3. 5-�������� ����� /4. 10 ������ �����-������ /5. �������� ��������� 6. �������� ����� 10p');		       
insert into Trainings (Id_Train, NameTrain, TypeTrain, Lessons, Description)             
       values (t_sequence_trainings.nextval, '��������', '1-����������', 3, '������� ������ ����c� ����. �������� ���� 20p. 10-�������� ����� ��� �����. 5-�������� �����. 10 ������ �����-������. �������� ���������. �������� ����� 10p');
insert into Trainings (Id_Train, NameTrain, TypeTrain, Lessons, Description)           
       values (t_sequence_trainings.nextval,'�������', '2-����������', 22, '���������� � ��������� � �������� ������ ������������ ���� � ������. ��� �������� ����� ���� �����������, ������������� ���, �������� ��������������, ������� �������� ����� ��� ��������� ������������/1. 40-� ���� ������� ����� /2. �������� �������� 40-� ����� /3. ���� ����������� 40-� ����� /4. 40-��������� ������ � ��������� /5. ��������� �������������� 40-� �����');
insert into Trainings (Id_Train, NameTrain, TypeTrain, Lessons, Description)           
       values (t_sequence_trainings.nextval,'���������� �����', '3-����������', 3, '�������� ������ �������� ��� ����������� ����./1. �������� ���� 20p /2. 10-�������� ����� ��� ����� /3. 5-�������� ����� /4. 10 ������ �����-������ /5. �������� ��������� 6. �������� ����� 10p');
insert into Trainings (Id_Train, NameTrain, TypeTrain, Lessons, Description)           
       values (t_sequence_trainings.nextval,'����� ��� �������', '4-����������', 5, '�������� ������ �������� ��� ����������� ����./1. �������� ���� 20p /2. 10-�������� ����� ��� ����� /3. 5-�������� ����� /4. 10 ������ �����-������ /5. �������� ��������� 6. �������� ����� 10p');
insert into Trainings (Id_Train, NameTrain, TypeTrain, Lessons, Description)          
       values (t_sequence_trainings.nextval,'���������� �����', '1-����������', 4, '�������� ���� � ������������ ���� ���, ������, ����� � ����./1. �������� ���� 20p /2. 10-�������� ����� ��� ����� /3. 5-�������� ����� /4. 10 ������ �����-������ /5. �������� ��������� 6. �������� ����� 10p');
insert into Trainings (Id_Train, NameTrain, TypeTrain, Lessons, Description)          
       values (t_sequence_trainings.nextval,'��������� �����', '2-����������', 8, '�������� ���� � ������������ ���� ���, ������, ����� � ����./1. �������� ���� 20p /2. 10-�������� ����� ��� ����� /3. 5-�������� ����� /4. 10 ������ �����-������ /5. �������� ��������� 6. �������� ����� 10p');
insert into Trainings (Id_Train, NameTrain, TypeTrain, Lessons, Description)        
       values (t_sequence_trainings.nextval,'������������� ����������', '3-����������', 6, '�������� ���� � ������������ ���� ���, ������, ����� � ����./1. �������� ���� 20p /2. 10-�������� ����� ��� ����� /3. 5-�������� ����� /4. 10 ������ �����-������ /5. �������� ��������� 6. �������� ����� 10p');
insert into Trainings (Id_Train, NameTrain, TypeTrain, Lessons, Description)            
       values (t_sequence_trainings.nextval,'������� �������� � ���������', '4-����������', 5, '�������� ���� � ������������ ���� ���, ������, ����� � ����./1. �������� ���� 20p /2. 10-�������� ����� ��� ����� /3. 5-�������� ����� /4. 10 ������ �����-������ /5. �������� ��������� 6. �������� ����� 10p');


------------ TABLE DIETS ------------
create sequence t_sequence_diets
start with 1
increment by 1; 

drop sequence t_sequence_diets;

insert into Diets (Id_Diet, NameDiet, TypeDiet, DayAmount, Description)
     values (t_sequence_diets.nextval,'������������ ���','1-�������', 3, '����������� ������������ ����� ������������ ������ ���� ������ ���� ������. ��� ������, ��� ������� ����� �������� ���������� ����������. � ������ ������ ������������ 6 ��������� ������������ ����.');
insert into Diets (Id_Diet, NameDiet, TypeDiet, DayAmount, Description)
     values (t_sequence_diets.nextval,'������������ ����', '2-�������', 7, '��������� ��� ����� �������! ����������� -3 ��');
insert into Diets (Id_Diet, NameDiet, TypeDiet, DayAmount, Description)
     values (t_sequence_diets.nextval,'����� � ������', '3-�������', 5, '��������� ��� ����� 5 ���! ����������� -4 ��');
insert into Diets (Id_Diet, NameDiet, TypeDiet, DayAmount, Description)
     values (t_sequence_diets.nextval,'�����', '4-�������', 8, '��������� ��� ����� �������! ����������� -2 ��');
insert into Diets (Id_Diet, NameDiet, TypeDiet, DayAmount, Description)
     values (t_sequence_diets.nextval,'���� � ���', '1-����', 9, '��������� ��� ����� �������! ����������� -4 ��');
insert into Diets (Id_Diet, NameDiet, TypeDiet, DayAmount, Description)
     values (t_sequence_diets.nextval,'������ � �����', '2-����', 12, '��������� ��� ����� �������! ����������� -4 ��');
insert into Diets (Id_Diet, NameDiet, TypeDiet, DayAmount, Description)
     values (t_sequence_diets.nextval,'�������', '3-����', 7, '��������� ��� ����� �������! ����������� -4 ��');
insert into Diets (Id_Diet, NameDiet, TypeDiet, DayAmount, Description)
     values (t_sequence_diets.nextval,'�������', '4-����', 11, '������� ����� � �������� ������� ��� ��� �����, ������� �� ����� ��������� ���� ���������� �� ������ ����. ������� ����� ��������� � ������������');
insert into Diets (Id_Diet, NameDiet, TypeDiet, DayAmount, Description)
     values (t_sequence_diets.nextval,'����� ������', '1-����', 13, '��������� ��� ����� �������! ����������� -4 ��');
insert into Diets (Id_Diet, NameDiet, TypeDiet, DayAmount, Description)
     values (t_sequence_diets.nextval,'�������� � ����', '2-����', 14, '��������� ��� ����� �������! ����������� -4 ��');
insert into Diets (Id_Diet, NameDiet, TypeDiet, DayAmount, Description)
     values (t_sequence_diets.nextval,'������� ���� � �����', '3-����', 8, '��������� ��� ����� �������! ����������� -4 ��');
insert into Diets (Id_Diet, NameDiet, TypeDiet, DayAmount, Description)
     values (t_sequence_diets.nextval,'������ ����� � ���', '4-����', 10, '��������� ��� ����� �������! ����������� -4 ��');



------------ TABLE LikesTrainings ------------
insert into LikesTrainings (Id_User, Id_Train, TypeLikes)
     values (2, 1, '1-��������');
insert into LikesTrainings (Id_User, Id_Train, TypeLikes)
     values (2, 3, '3-��������');
insert into LikesTrainings (Id_User, Id_Train, TypeLikes)
     values (2, 8, '1-����������'); 
insert into LikesTrainings (Id_User, Id_Train, TypeLikes)
     values (5, 6, '3-���������');
insert into LikesTrainings (Id_User, Id_Train, TypeLikes)
     values (5, 9, '2-����������');
insert into LikesTrainings (Id_User, Id_Train, TypeLikes)
     values (8, 9, '2-����������');
     
     
     
------------ TABLE LikesDiets ------------
insert into LikesDiets (Id_User, Id_Diet, TypeLikes)
     values (3, 2, '2-�������');
insert into LikesDiets (Id_User, Id_Diet, TypeLikes)
     values (3, 3, '3-�������');
insert into LikesDiets (Id_User, Id_Diet, TypeLikes)
     values (2, 8, '4-����'); 
insert into LikesDiets (Id_User, Id_Diet, TypeLikes)
     values (7, 7, '3-����');
insert into LikesDiets (Id_User, Id_Diet, TypeLikes)
     values (8, 9, '1-����');  
     
     

------------ TABLE FinishTraining ------------
insert into FinishTraining (Id_User, Id_Train, TypeTrain, FinishDate)
     values (5, 3,'3-��������', '06.05.2023');  
insert into FinishTraining (Id_User, Id_Train, TypeTrain, FinishDate)
     values (5, 5,'2-���������', '07.05.2023');   
insert into FinishTraining (Id_User, Id_Train, TypeTrain, FinishDate)
     values (8, 5,'2-���������', '09.05.2023'); 
insert into FinishTraining (Id_User, Id_Train, TypeTrain, FinishDate)
     values (9, 12,'1-����������', '10.05.2023'); 
insert into FinishTraining (Id_User, Id_Train, TypeTrain, FinishDate)
     values (9, 8,'1-����������', '11.05.2023'); 
insert into FinishTraining (Id_User, Id_Train, TypeTrain, FinishDate)
     values (10, 14,'3-����������', '11.05.2023');      
    
     
     
     