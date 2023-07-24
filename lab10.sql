---------1---------
--простейший АБ
begin
    null;
end;



---------2---------
begin
    dbms_output.put_line('Hello, world');
ENd;


pp
---------3---------
--Продемонстр исключ и встр.ф SQLERRM, SQLCODE
declare
    x number(3) := 3;
    y number(3) := 0;
    z number (10,2);
begin
    dbms_output.put_line('x = '||x||', y = '||y);
    z:=x/y;
    exception 
        when others
        then dbms_output.put_line(sqlcode||': error = '||sqlerrm); --|| конкатенация
end;



---------4---------
--вложенный блок 
declare
    x number(3) := 3;
begin
    begin
        declare x number(3) :=1;
        begin dbms_output.put_line('x = '||x); end;
    end;
    dbms_output.put_line('x = '||x);
end;



---------5---------
--Какие типы предупреждения компилятора поддерж в данный момент
show parameter plsql_warnings;

alter system set plsql_warnings = 'ENABLE:INFORMATIONAL';


---------6---------
--просмотреть все спецсимволы PL/SQL
select keyword from v$reserved_words 
where length=1 and keyword!='A';



---------7---------
--просмотреть все ключевые слова  PL/SQL
select keyword from v$reserved_words 
  where length > 2 and keyword!='A' 
  order by keyword;



---------8---------
--просмотреть все параметры Oracle Server, связанные с PL/SQL
show parameter plsql;



---------9-17---------
--АБ, демонстр:
declare
        c1 number(3):= 25;
        c2 number(3):= 10;
        div number(10,2);
        fix number(10,2):= 3.12;
        otr number(4, -5):= 32.12345;
        bf binary_float:= 12345.6789;
        bd binary_double := 12345.6789;
        en number(6,2) := 1e3;
        b1 boolean:= true;
    
    begin
        div := mod(c1,c2);
        dbms_output.put_line('c1 = '||c1);
        dbms_output.put_line('c2 = '||c2);
        dbms_output.put_line('c1%c2 = '||div);
        dbms_output.put_line('fix = '||fix);
        dbms_output.put_line('otr = '||otr);
        dbms_output.put_line('bf = '||bf);
        dbms_output.put_line('bd = '||bd);
        dbms_output.put_line('en = '||en);
        if b1 then dbms_output.put_line('b1 = '||'true'); end if;
    end;



---------18---------
--аб PL/SQL содержащий объявление констант
declare
    String1 constant varchar2(10):='Kohnyuk';
    String2 constant char(10):='Sasha';
begin
    dbms_output.put_line('String1 = ' || String1 || ', length(String1) = ' || length(String1));
    dbms_output.put_line('String2 = ' || String2 || ', length(String2) = ' || length(String2));
end;


---------19-20---------
--объявления с опцией %TYPE, %ROWTYPE
`
declare
    subject sys.subject.subject%type;
    pulpit sys.pulpit.pulpit%type;
    faculty_rec sys.faculty%rowtype;
begin
    subject := 'INF';
    pulpit := 'ISiT';
    faculty_rec.faculty :='IT';
    faculty_rec.faculty_name := 'Fakul`tet informacionnyh tekhnologij';
    dbms_output.put_line(subject);
    dbms_output.put_line(pulpit);
    dbms_output.put_line(rtrim(faculty_rec.faculty) || ': ' || faculty_rec.faculty_name);
    exception
        when others
        then dbms_output.put_line('error = ' || sqlerrm);
end;


---------21---------
--Конструкции if, elseif
declare
    x int := 99;
begin
    if 50 > x
        then dbms_output.put_line('50 > ' || x);
    elsif 50 = x
        then dbms_output.put_line('50 = '||x);
    elsif 100 > x
        then dbms_output.put_line('100 > ' || x);
    elsif 100 = x
        then dbms_output.put_line('100 = ' || x);
    else dbms_output.put_line('100 <> ' || x);
    end if;
end;



---------23---------
--Оператор CASE
declare
  x int := 99;
begin
    case
        when 50 > x
            then dbms_output.put_line('100 > ' || x);
        when x between 50 and 100
            then dbms_output.put_line('50 =< ' || x || ' <= 100');
        else dbms_output.put_line('not of all');
    end case;
end;
    
    
    
---------24-26--------- 
--Работа LOOP, WHILE, FOR
declare
x int := 0;
begin
    dbms_output.put_line('LOOP:');
    loop
        x := x + 1;
        dbms_output.put_line(x);
        exit when x > 5;
    end loop;
    
    dbms_output.put_line('FOR:');
    for k in 1..5
    loop
        dbms_output.put_line(k);
    end loop;
    
    dbms_output.put_line('WHILE:');
    while x > 0
    loop
        x := x-1;
        dbms_output.put_line(x);
    end loop;
end;
























declare 
   num1 number(5):= 10;
   num2 number(5):= 0;
   rez number(5);
   
   begin
     rez :=  num1/num2;
     exception 
      when others
      then dbms_output.put_line(sqlcode||': error = '||sqlerrm);
   end;


















