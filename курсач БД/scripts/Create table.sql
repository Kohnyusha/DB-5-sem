create table Users
(
    Id_User number(10) primary key, 
    Login varchar(50) not null,
    UserPassword varchar(50) not null,
    Email varchar(50) not null,
    RegisterDate date not null,
    IsAdmin number(10) default(0)
);

create table Trainings
(
    Id_Train number(10),
	  NameTrain varchar(50) not null,
    TypeTrain varchar(100) not null,
	  Lessons number(10) not null,
	  Description varchar(400) not null,
    primary key (Id_Train, TypeTrain)
);

create table Diets 
(
    Id_Diet number,
	  NameDiet varchar(20) not null,
	  TypeDiet varchar(20) not null,
    DayAmount int  not null,
	  Description varchar(200)  not null,
    primary key (Id_Diet, TypeDiet)
);

create table LikesTrainings
(
    Id_Like number generated by default as identity,
    Id_User number not null,
    Id_Train number not null,
	  TypeLikes varchar(20) not null,
    primary key (Id_User, Id_Like, TypeLikes),
    constraint fk_id_user foreign key (Id_User) references Users(Id_User),
    constraint fk_type_t foreign key (Id_Train, TypeLikes) references Trainings(Id_Train, TypeTrain)
);

create table LikesDiets
(
    Id_Like number generated by default as identity,
    Id_User number not null,
    Id_Diet number not null,
	  TypeLikes varchar(20) not null,
    primary key (Id_User, Id_Like, TypeLikes),
    constraint fk_id_user2 foreign key (Id_User) references Users(Id_User),
    constraint fk_type_d foreign key (Id_Diet, TypeLikes) references Diets(Id_Diet, TypeDiet)
);

create table FinishTraining 
(
   Id_Type number generated by default as identity,
   Id_User number not null,
   Id_Train number not null,
	 TypeTrain varchar(20) not null,
	 FinishDate date not null,
   constraint fk_id_user3 foreign key (Id_User) references Users(Id_User),
   constraint fk_type_training foreign key (Id_Train, TypeTrain) references Trainings(Id_Train, TypeTrain)
);



