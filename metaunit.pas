unit metaunit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Dialogs;

Type
  TField = class
    Name, Caption, RefTable, KeyField, ListField: string;
    constructor create (AName, ACaption, ARefTable, AKeyField, AListField: string);
    function GetFieldName(): string;
  end;

  TTable = class
    Name, Caption: string;
    Fields: array of TField;
    function GetQuery (): TStringList;
    procedure AddField(AName, ACaption, ARefTable, AKeyField, AListField: string);
    constructor create (AName, ACaption: string);
  end;

 function AddTable (AName, ACaption: string) : TTable;

 Var
   Tables: array of TTable;

implementation

function AddTable (AName, ACaption: string) : TTable;
begin
 SetLength(Tables, Length(Tables)+1);
 Tables[High(Tables)]:= TTable.create(AName, ACaption);
 Result:= Tables[High(Tables)];
end;

constructor TField.create (AName, ACaption, ARefTable, AKeyField, AListField: string);
begin
  Name:= AName;
  Caption:= Acaption;
  Reftable:= ARefTable;
  KeyField:= AKeyField;
  ListField:= AListField;
end;

function TField.GetFieldName(): string;
begin
  if RefTable = '' then Result := Name
  else Result := ListField;
end;

constructor TTable.create (AName, ACaption: string);
begin
  Name:= AName;
  Caption:= Acaption;
end;

function TTable.GetQuery (): TStringList;
var
  i: integer;
  sqlSelect, sqlFrom: string;
begin
  Result := TStringList.Create;
  sqlSelect := 'SELECT ';
  sqlFrom := 'FROM ' + Name + ' ';

  for i := 0 to high(Fields) do begin
    if Fields[i].RefTable = '' then
      sqlSelect := sqlSelect + Name + '.' + Fields[i].Name + ', '
    else begin
      sqlSelect := sqlSelect + Fields[i].RefTable + '.' + Fields[i].ListField + ', ';
      sqlFrom := sqlFrom + 'INNER JOIN ' + Fields[i].RefTable + ' ON ' + Name +
        '.' + Fields[i].Name + ' = ' + Fields[i].RefTable + '.' + Fields[i].KeyField + ' ';
    end;
  end;
  Delete(sqlSelect, Length(sqlSelect)-1, 2);

  Result.Add(sqlSelect);
  Result.Add(sqlFrom);
end;

procedure TTable.AddField(AName, ACaption, ARefTable, AKeyField, AListField: string);
  begin
    SetLength(Fields, Length(Fields)+1);
    Fields[High(Fields)]:= TField.create(AName, ACaption, ARefTable, AKeyField, AListField);
  end;

initialization


with AddTable('Subjects', 'Предметы') do begin
  AddField('ID', 'ID','' ,'' ,'' );
  AddField('Name', 'Предмет','' ,'' ,'' );
end;

with AddTable('Subject_Types', 'Виды занятий') do begin
  AddField('ID', 'ID','' ,'' ,'' );
  AddField('Name', 'Вид','' ,'' ,'' );
end;

with AddTable('Professors', 'Преподаватели') do begin
  AddField('ID', 'ID','' ,'' ,'' );
  AddField('Name', 'Преподаватель','' ,'' ,'' );
end;

with AddTable('Times', 'Пары') do begin
  AddField('"Index"', 'Индекс','' ,'' ,'' );
  AddField('"Begin"', 'Начало','' ,'' ,'' );
  AddField('"End"', 'Окончание','' ,'' ,'' );
end;

with AddTable('Days', 'Дни') do begin
  AddField('"Index"', 'Индекс','' ,'' ,'' );
  AddField('Name', 'День недели','' ,'' ,'' );
end;

with AddTable('Groups', 'Группы') do begin
  AddField('ID', 'ID','' ,'' ,'' );
  AddField('Name', 'Номер группы','' ,'' ,'' );
  AddField('Group_size', 'Количество','' ,'' ,'' );
end;

with AddTable('Rooms', 'Аудитории') do begin
  AddField('ID', 'ID','' ,'' ,'' );
  AddField('Name', 'Номер','' ,'' ,'' );
  AddField('Size', 'Вместимость','' ,'' ,'' );
end;

with AddTable('Professors_Subjects', 'Преподаватели-предметы') do begin
  AddField('ID', 'ID','' ,'' ,'' );
  AddField('Professor_ID', 'Преподаватель','Professors' ,'ID' ,'Name' );
  AddField('Subject_ID', 'Предмет','Subjects' ,'ID' ,'Name' );
end;

with AddTable('Subjects_Groups', 'Предметы - группы') do begin
  AddField('ID', 'ID','' ,'' ,'' );
  AddField('Subject_ID', 'Предмет','Subjects' ,'ID' ,'Name' );
  AddField('Group_ID', 'Группа','Groups' ,'ID' ,'Name' );
end;

with AddTable('Schedule_Items', 'Расписание') do begin
  AddField('ID', 'ID','' ,'' ,'' );
  AddField('Subject_ID', 'Предмет','Subjects' ,'ID' ,'Name' );
  AddField('Subject_Type_ID', 'Вид','Subject_Types' ,'ID' ,'Name' );
  AddField('Professor_ID', 'Преподаватель','Professors' ,'ID' ,'Name' );
  AddField('TIME_INDEX', 'Начало', 'Times' ,'"Index"' ,'"Begin"' );
  AddField('DAY_INDEx', 'День недели','Days', '"Index"', 'Name');
  AddField('GROUP_ID', 'Группа','Groups' ,'ID' ,'Name' );
  AddField('ROOM_ID', 'Аудитория','Rooms' ,'ID' ,'Name' );
end;


end.

