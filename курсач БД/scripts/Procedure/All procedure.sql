----admin----
begin
  addUser(t_sequence_users.nextval, 'login123', 'userpassword', 'email', '06.05.2023');
end;


begin 
  deleteUserByID(23);
end;


-------
begin
  addTraining(t_sequence_trainings.nextval, 'Новая тренировка', '5-Разминка', 20, 'Не спеши сразу же переходить к упражнениям.');
end;

begin 
  ChangeTrainById('UpdateName', 21);
end;

begin 
  deleteTrainById(21);
end;


-------
begin 
  addDiet(t_sequence_diets.nextval, 'Новая', '8-Ужин', 7, 'Результат уже через неделею!');
end;

begin 
  ChangeDietById('10-Ужин', 21);
end;

begin 
  deleteDietById(21);
end;

-------
begin
  getAllUsers();
end;

begin
  getDefiniteDateUsers('20.04.2023');
end;

begin
  getUsersLogin('Admin');
end;

begin
  getAllTrainings();
end;

begin
  getAllDiets();
end;

begin
  getAllLikesTrainUser(5);
end;

begin
  getAllLikesDiets();
end;

begin
  getAllLikesDietUser(3);
end;

begin
  getAllFinishTrain();
end;

begin
  getAllFinishTrainUser(9);
end;

begin
  getAllLikesTrains();
end;

begin 
  addDiet(t_sequence_diets.nextval, 'Новая', '8-Ужин', 7, 'Результат уже через неделею!');
end;

begin 
  addLikesTraining(2, 9, '2-Упражнение');
end;

begin 
  ChangeTrainByName(100, 'UpdateName');
end;

begin 
  changeDietByName('Куриное филе и овощи', 'Новое описание, Новое описа-ние, Новое описание');
end;

begin 
  deleteUserByID(22);
end;

begin 
  deleteUserByLogin('NewUser5JU');
end;

begin 
  deleteTrainById(23);
end;

begin 
  deleteDietById(25);
end;

begin 
  deleteLikesTrainById(7);
end;

begin 
  deleteLikesDietById(8);
end;

begin 
  deleteFinishTrainById(12);
end;

begin 
  deleteFinishTrainByIdUser(10);
end;




----user-----
begin 
  system.addLikesDiet(2, 6, '2-Обед');
end;

begin 
  system.addLikesTraining(2, 10, '3-Упражнение');
end;

-----
--id тренировки
begin 
  system.deleteLikesTrainById(10);
end;

--id диеты
begin 
  system.deleteLikesDietById(6);
end;

begin 
  system.getAllFinishTrainUser(5);
end;

begin
  system.getAllTrainings();
end;

begin
  system.getAllDiets();
end;

begin 
  system.getAllLikesTrains();
end;

begin
  system.getAllLikesTrainUser(5);
end;

begin
  system.getAllLikesDiets();
end;

begin
  system.getAllLikesDietUser(3);
end;

begin 
  system.getAllFinishTrain();
end;



























