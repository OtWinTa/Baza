unit referenunit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, FileUtil, Forms, Controls, Graphics, Dialogs,
  DBGrids, metaunit;

type

  { TRefenForm }

  TRefenForm = class(TForm)
    Datasource1: TDatasource;
    DBGrid1: TDBGrid;
    SQLQuery1: TSQLQuery;
    constructor Create(TheOwner: TComponent; ATable: TTable); overload;
  private
    Table: TTable;
  end;

var
  RefenForm: TRefenForm;

implementation

{$R *.lfm}

{ TRefenForm }

constructor TRefenForm.Create(TheOwner: TComponent; ATable: TTable);
var
  i, j, k: integer;
begin
  inherited Create(TheOwner);
  Table := ATable;

  for i := 0 to high(Table.Fields) do begin
    with DBGrid1.Columns.Add do begin
      Alignment:= taLeftJustify;
      Expanded:= True;
      Layout:= tlCenter;
      Title.Caption := Table.Fields[i].Caption;
      FieldName:= AnsiDequotedStr(Table.Fields[i].GetFieldName(), '"');
      k := 0;
      for j := 0 to i-1 do
        if FieldName = Table.Fields[j].GetFieldName() then inc(k);
      if k > 0 then
        FieldName := FieldName + '_' + IntToStr(k);
    end;
  end;
  SQLQuery1.SQL := Table.GetQuery();
  //ShowMessage(SQLQuery1.SQL.Text);
  SQLQuery1.Open;
end;

end.

