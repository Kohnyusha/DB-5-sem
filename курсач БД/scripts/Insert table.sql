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
       values (t_sequence_trainings.nextval, 'На старт!', '1-Разминка', 15, 'Не спеши сразу же переходить к упражнениям. Разминки улучшают показатели, снижают риск травм и помогают настроиться на нужный лад./1. 50р Прыжков вприпрыжку /2. прыгающие домкраты по 50 пенсов /3. приседания на 10 пунктов /4. 10 пенсов Бурпи /5. поворот выпада на 10 пунктов /6. удержание доски 30 секунд');
insert into Trainings (Id_Train, NameTrain, TypeTrain, Lessons, Description)         
       values (t_sequence_trainings.nextval,'Активация мышц корпуса', '2-Разминка', 10, 'Не спеши сразу же переходить к упражнениям. Разминки улучшают показатели, снижают риск травм и помогают настроиться на нужный лад/1. 50р Прыжков вприпрыжку /2. прыгающие домкраты по 50 пенсов/3. 20 грамм сухариков /4. планка 10p От колен до локтей /5. 10 секунд Удержания Высокой Боковой Планки Слева /6. боковая Планка Высотой 10 с Удерживается Справа');
insert into Trainings (Id_Train, NameTrain, TypeTrain, Lessons, Description)           
       values (t_sequence_trainings.nextval,'Разминка для повышения пульса', '3-Разминка', 5, 'Не спеши сразу же переходить к упражнениям. Разминки улучшают показатели, снижают риск травм и помогают настроиться на нужный лад./1. 50р Прыжков вприпрыжку /2. прыгающие домкраты по 50 пенсов /3. 10 пенсов Бурпи /4. планка 10p От колен до локтей ');
insert into Trainings (Id_Train, NameTrain, TypeTrain, Lessons, Description)
       values (t_sequence_trainings.nextval,'Гибкость бедер и ног', '1-Расстяжка', 8, 'Комплекс упражнений стретчинга возвращает эластичность и подвижность не только сухожилиям и мышцам, но и улучшает кровоснабжение всего тела и мозга./ 1. разминка плеч 20p /2. 10-дюймовые круги для бедер /3. 5-дюймовые черви /4. 10 пенсов Кошка-Корова /5. Наземные Супермены /6. повороты стола 10p');
insert into Trainings (Id_Train, NameTrain, TypeTrain, Lessons, Description)          
       values (t_sequence_trainings.nextval,'Абсолютная гибкость', '2-Расстяжка', 8, 'Комплекс упражнений стретчинга возвращает эластичность и подвижность не только сухожилиям и мышцам, но и улучшает кровоснабжение всего тела и мозга./1. разминка плеч 20p /2. 10-дюймовые круги для бедер /3. 5-дюймовые черви /4. 10 пенсов Кошка-Корова /5. Наземные Супермены 6. повороты стола 10p');
insert into Trainings (Id_Train, NameTrain, TypeTrain, Lessons, Description)           
       values (t_sequence_trainings.nextval,'Расслабление мышц тела', '3-Расстяжка', 12, 'Комплекс упражнений стретчинга возвращает эластичность и подвижность не только сухожилиям и мышцам, но и улучшает кровоснабжение всего тела и мозга./1. разминка плеч 20p /2. 10-дюймовые круги для бедер /3. 5-дюймовые черви /4. 10 пенсов Кошка-Корова /5. Наземные Супермены 6. повороты стола 10p');
insert into Trainings (Id_Train, NameTrain, TypeTrain, Lessons, Description)          
       values (t_sequence_trainings.nextval, 'На каждый день', '4-Расстяжка', 7, 'Комплекс упражнений стретчинга возвращает эластичность и подвижность не только сухожилиям и мышцам, но и улучшает кровоснабжение всего тела и мозга./1. разминка плеч 20p /2. 10-дюймовые круги для бедер /3. 5-дюймовые черви /4. 10 пенсов Кошка-Корова /5. Наземные Супермены 6. повороты стола 10p');		       
insert into Trainings (Id_Train, NameTrain, TypeTrain, Lessons, Description)             
       values (t_sequence_trainings.nextval, 'Скакалка', '1-Упражнение', 3, 'Заставь сердце битьcя чаще. разминка плеч 20p. 10-дюймовые круги для бедер. 5-дюймовые черви. 10 пенсов Кошка-Корова. Наземные Супермены. повороты стола 10p');
insert into Trainings (Id_Train, NameTrain, TypeTrain, Lessons, Description)           
       values (t_sequence_trainings.nextval,'Гантеля', '2-Упражнение', 22, 'Упражнения с гантелями — отличный способ поддерживать тело в тонусе. Они помогают лучше себя чувствовать, нормализовать вес, улучшить кровообращение, набрать мышечную массу или увеличить выносливость/1. 40-е годы Дьяволы давят /2. прогулки Фреймера 40-х годов /3. Ряды отступников 40-х годов /4. 40-секундные толчки с гантелями /5. комплексы производителей 40-х годов');
insert into Trainings (Id_Train, NameTrain, TypeTrain, Lessons, Description)           
       values (t_sequence_trainings.nextval,'Эластичная лента', '3-Упражнение', 3, 'Выполняй массаж кованных или болезненных мышщ./1. разминка плеч 20p /2. 10-дюймовые круги для бедер /3. 5-дюймовые черви /4. 10 пенсов Кошка-Корова /5. Наземные Супермены 6. повороты стола 10p');
insert into Trainings (Id_Train, NameTrain, TypeTrain, Lessons, Description)           
       values (t_sequence_trainings.nextval,'Ролик для фитнеса', '4-Упражнение', 5, 'Выполняй массаж кованных или болезненных мышщ./1. разминка плеч 20p /2. 10-дюймовые круги для бедер /3. 5-дюймовые черви /4. 10 пенсов Кошка-Корова /5. Наземные Супермены 6. повороты стола 10p');
insert into Trainings (Id_Train, NameTrain, TypeTrain, Lessons, Description)          
       values (t_sequence_trainings.nextval,'Подтянутые мышцы', '1-Тренировка', 4, 'Развивай силу и выносливость мышц рук, спиный, груди и плеч./1. разминка плеч 20p /2. 10-дюймовые круги для бедер /3. 5-дюймовые черви /4. 10 пенсов Кошка-Корова /5. Наземные Супермены 6. повороты стола 10p');
insert into Trainings (Id_Train, NameTrain, TypeTrain, Lessons, Description)          
       values (t_sequence_trainings.nextval,'Рельефные плечи', '2-Тренировка', 8, 'Развивай силу и выносливость мышц рук, спиный, груди и плеч./1. разминка плеч 20p /2. 10-дюймовые круги для бедер /3. 5-дюймовые черви /4. 10 пенсов Кошка-Корова /5. Наземные Супермены 6. повороты стола 10p');
insert into Trainings (Id_Train, NameTrain, TypeTrain, Lessons, Description)        
       values (t_sequence_trainings.nextval,'Жиросжигающая тренировка', '3-Тренировка', 6, 'Развивай силу и выносливость мышц рук, спиный, груди и плеч./1. разминка плеч 20p /2. 10-дюймовые круги для бедер /3. 5-дюймовые черви /4. 10 пенсов Кошка-Корова /5. Наземные Супермены 6. повороты стола 10p');
insert into Trainings (Id_Train, NameTrain, TypeTrain, Lessons, Description)            
       values (t_sequence_trainings.nextval,'Двойной комплекс с гантелями', '4-Тренировка', 5, 'Развивай силу и выносливость мышц рук, спиный, груди и плеч./1. разминка плеч 20p /2. 10-дюймовые круги для бедер /3. 5-дюймовые черви /4. 10 пенсов Кошка-Корова /5. Наземные Супермены 6. повороты стола 10p');


------------ TABLE DIETS ------------
create sequence t_sequence_diets
start with 1
increment by 1; 

drop sequence t_sequence_diets;

insert into Diets (Id_Diet, NameDiet, TypeDiet, DayAmount, Description)
     values (t_sequence_diets.nextval,'Разгрузочные дни','1-Завтрак', 3, 'трехдневная разгрузочная диета предполагает каждый день менять свой рацион. Это значит, что человек будет питаться различными продуктами. В данной статье представлены 6 вариантов разгрузочных дней.');
insert into Diets (Id_Diet, NameDiet, TypeDiet, DayAmount, Description)
     values (t_sequence_diets.nextval,'Свежевыжитые соки', '2-Завтрак', 7, 'Результат уже через неделею! Гарантируем -3 кг');
insert into Diets (Id_Diet, NameDiet, TypeDiet, DayAmount, Description)
     values (t_sequence_diets.nextval,'Овощи и фрукты', '3-Завтрак', 5, 'Результат уже через 5 ней! Гарантируем -4 кг');
insert into Diets (Id_Diet, NameDiet, TypeDiet, DayAmount, Description)
     values (t_sequence_diets.nextval,'Белок', '4-Завтрак', 8, 'Результат уже через неделею! Гарантируем -2 кг');
insert into Diets (Id_Diet, NameDiet, TypeDiet, DayAmount, Description)
     values (t_sequence_diets.nextval,'Рыба и рис', '1-Обед', 9, 'Результат уже через неделею! Гарантируем -4 кг');
insert into Diets (Id_Diet, NameDiet, TypeDiet, DayAmount, Description)
     values (t_sequence_diets.nextval,'Гречка и грибы', '2-Обед', 12, 'Результат уже через неделею! Гарантируем -4 кг');
insert into Diets (Id_Diet, NameDiet, TypeDiet, DayAmount, Description)
     values (t_sequence_diets.nextval,'Свинная', '3-Обед', 7, 'Результат уже через неделею! Гарантируем -4 кг');
insert into Diets (Id_Diet, NameDiet, TypeDiet, DayAmount, Description)
     values (t_sequence_diets.nextval,'Куриная', '4-Обед', 11, 'Куриная диета – отличный вариант для тех людей, которые не могут заставить себя отказаться от мясных блюд. Куриный белок относится к полноценному');
insert into Diets (Id_Diet, NameDiet, TypeDiet, DayAmount, Description)
     values (t_sequence_diets.nextval,'Салат легкий', '1-Ужин', 13, 'Результат уже через неделею! Гарантируем -4 кг');
insert into Diets (Id_Diet, NameDiet, TypeDiet, DayAmount, Description)
     values (t_sequence_diets.nextval,'Брокколи и бобы', '2-Ужин', 14, 'Результат уже через неделею! Гарантируем -4 кг');
insert into Diets (Id_Diet, NameDiet, TypeDiet, DayAmount, Description)
     values (t_sequence_diets.nextval,'Куриное филе и овощи', '3-Ужин', 8, 'Результат уже через неделею! Гарантируем -4 кг');
insert into Diets (Id_Diet, NameDiet, TypeDiet, DayAmount, Description)
     values (t_sequence_diets.nextval,'Яичный белок и рис', '4-Ужин', 10, 'Результат уже через неделею! Гарантируем -4 кг');



------------ TABLE LikesTrainings ------------
insert into LikesTrainings (Id_User, Id_Train, TypeLikes)
     values (2, 1, '1-Разминка');
insert into LikesTrainings (Id_User, Id_Train, TypeLikes)
     values (2, 3, '3-Разминка');
insert into LikesTrainings (Id_User, Id_Train, TypeLikes)
     values (2, 8, '1-Упражнение'); 
insert into LikesTrainings (Id_User, Id_Train, TypeLikes)
     values (5, 6, '3-Расстяжка');
insert into LikesTrainings (Id_User, Id_Train, TypeLikes)
     values (5, 9, '2-Упражнение');
insert into LikesTrainings (Id_User, Id_Train, TypeLikes)
     values (8, 9, '2-Упражнение');
     
     
     
------------ TABLE LikesDiets ------------
insert into LikesDiets (Id_User, Id_Diet, TypeLikes)
     values (3, 2, '2-Завтрак');
insert into LikesDiets (Id_User, Id_Diet, TypeLikes)
     values (3, 3, '3-Завтрак');
insert into LikesDiets (Id_User, Id_Diet, TypeLikes)
     values (2, 8, '4-Обед'); 
insert into LikesDiets (Id_User, Id_Diet, TypeLikes)
     values (7, 7, '3-Обед');
insert into LikesDiets (Id_User, Id_Diet, TypeLikes)
     values (8, 9, '1-Ужин');  
     
     

------------ TABLE FinishTraining ------------
insert into FinishTraining (Id_User, Id_Train, TypeTrain, FinishDate)
     values (5, 3,'3-Разминка', '06.05.2023');  
insert into FinishTraining (Id_User, Id_Train, TypeTrain, FinishDate)
     values (5, 5,'2-Расстяжка', '07.05.2023');   
insert into FinishTraining (Id_User, Id_Train, TypeTrain, FinishDate)
     values (8, 5,'2-Расстяжка', '09.05.2023'); 
insert into FinishTraining (Id_User, Id_Train, TypeTrain, FinishDate)
     values (9, 12,'1-Тренировка', '10.05.2023'); 
insert into FinishTraining (Id_User, Id_Train, TypeTrain, FinishDate)
     values (9, 8,'1-Упражнение', '11.05.2023'); 
insert into FinishTraining (Id_User, Id_Train, TypeTrain, FinishDate)
     values (10, 14,'3-Тренировка', '11.05.2023');      
    
     
     
     