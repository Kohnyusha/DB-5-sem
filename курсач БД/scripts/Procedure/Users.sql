select * from users;


---Admin---
----вывести всех пользователей-----
create or replace procedure getAllUsers
is
cursor curs is select users.Login from users;
    Login users.Login%type;
begin
  open curs;
    loop 
        fetch curs into Login;
        exit when curs%notfound;
        dbms_output.put_line(Login);
    end loop;
    close curs;
exception
when others
then SYS.dbms_output.put_line(sqlcode || sqlerrm);
end;

begin 
  getAllUsers();
end;


----вывести всех пользователей, которые зарегестрированы позже определенной даты-----
create or replace procedure getDefiniteDateUsers(DefiniteDate users.registerdate%type) 
is
cursor curs is select users.id_user, users.Login, users.registerdate 
from users
where users.registerdate >= DefiniteDate;
    id users.id_user%type;
    Login users.Login%type;
    reg users.registerdate%type;
begin
  open curs;
    loop 
        fetch curs into id, Login, reg;
        exit when curs%notfound;
        dbms_output.put_line(id||' '||Login||' '||reg);
    end loop;
    close curs;
exception
when others
then SYS.dbms_output.put_line(sqlcode || sqlerrm);
end;

begin 
  getDefiniteDateUsers('20.04.2023');
end;


----вывести пользователя по логину-----
create or replace procedure getUsersLogin(loginuser users.login%type) 
is
cursor curs is select users.id_user, users.Login, users.registerdate 
from users
where users.login = loginuser;
    id users.id_user%type;
    Login users.Login%type;
    reg users.registerdate%type;
begin
  open curs;
    loop 
        fetch curs into id, Login, reg;
        exit when curs%notfound;
        dbms_output.put_line(id||' '||Login||' '||reg);
    end loop;
    close curs;
exception
when others
then SYS.dbms_output.put_line(sqlcode || sqlerrm);
end;

begin 
  getUsersLogin('Admin');
end;



----добавить пользователя-----
create or replace procedure addUser (id_user users.id_user%type, login users.login%type, userpassword users.userpassword%type, email users.email%type, registerdate users.registerdate%type) 
is
begin
insert into users(id_user, login, userpassword, email, registerdate) values (id_user, login, userpassword, email, registerdate);
SYS.dbms_output.put_line('User was inserted');
exception
when others
then SYS.dbms_output.put_line(sqlcode || sqlerrm);
end;


begin 
  addUser(t_sequence_users.nextval, 'login123', 'userpassword', 'email', '06.05.2023');
end;

select * from users;

drop procedure addUser;


-----удалить пользователя по ID----
create or replace procedure deleteUserByID(id USERS.id_user%type)
is
begin
delete from users where users.id_user = id;
SYS.dbms_output.put_line('User was deleted');
exception
when others
then SYS.dbms_output.put_line(sqlcode || sqlerrm);
end;

begin 
  deleteUserByID(22);
end;

drop procedure deleteUserByID;
