create directory infilexml as 'C:\infile';



CREATE OR REPLACE FUNCTION ReadFileForImport(FileName NVARCHAR2)
RETURN XMLTYPE
AS
FileContent CLOB;
Buffer CLOB;
FileDescriptor UTL_FILE.FILE_TYPE;
BEGIN
FileDescriptor := UTL_FILE.FOPEN('INFILEXML', FileName, 'R');
LOOP
BEGIN
UTL_FILE.GET_LINE(FileDescriptor, Buffer);
FileContent := FileContent || Buffer;
EXCEPTION WHEN NO_DATA_FOUND THEN EXIT;
END;
END LOOP;

RETURN XMLTYPE(FileContent);
END;




CREATE OR REPLACE PROCEDURE ImportXMLUsers(FileName VARCHAR2)
AS
FileContent     XMLTYPE;
    IdUser       number(10) ;
    LoginUser        NVARCHAR2(50);
    UserPass     NVARCHAR2(50);
    EmailUser           NVARCHAR2(50);
    RegDate         DATE;
    AdminOrNot           number(10);
    i INT DEFAULT 1;
BEGIN
FileContent := ReadFileForImport(FileName);
LOOP
BEGIN
SELECT EXTRACTVALUE(FileContent, '/data/row['||i||']/ID_USER') INTO IdUser FROM DUAL;
            SELECT EXTRACTVALUE(FileContent, '/data/row['||i||']/LOGIN') INTO LoginUser FROM DUAL;
            SELECT EXTRACTVALUE(FileContent, '/data/row['||i||']/USERPASSWORD') INTO UserPass FROM DUAL;
            SELECT EXTRACTVALUE(FileContent, '/data/row['||i||']/EMAIL') INTO EmailUser FROM DUAL;
            SELECT TO_DATE(EXTRACTVALUE(FileContent, '/data/row['||i||']/REGISTERDATE'), 'yyyy-mm-dd') INTO RegDate FROM DUAL;
            SELECT EXTRACTVALUE(FileContent, '/data/row['||i||']/ISADMIN') INTO AdminOrNot FROM DUAL;
IF IdUser IS NULL THEN EXIT;
END IF;

insert into users2(Id_User, Login, UserPassword, Email, RegisterDate, IsAdmin) 
values (IdUser, LoginUser, UserPass, EmailUser, RegDate, AdminOrNot);

i := i + 1;
END;

END LOOP;
exception
when others then dbms_output.put_line('Error');
END;


begin
  ImportXMLUsers('USERS_DATA_TABLE.xml');
end;

select * from users2;