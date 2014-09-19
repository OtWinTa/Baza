unit mainunit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Menus,
  metaunit, referenunit;

type

  { TMainForm }

  TMainForm = class(TForm)
    MainMenu: TMainMenu;
    ffile: TMenuItem;
    Referen: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure MenuTable_Show(Sender: TObject);
  private
    RefenForms: array of TRefenForm;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.lfm}

{ TMainForm }

procedure TMainForm.FormCreate(Sender: TObject);
var
  i: Integer;
  MenuItem: TmenuItem;
begin
  SetLength(RefenForms, Length(Tables));
  for i := 0 to High(Tables) do begin
    MenuItem := TMenuItem.Create(MainMenu);
    with MenuItem do begin
      Tag := i;
      Caption := Tables[i].Caption;
      Name := 'MI_' + Tables[i].Name;
      OnClick := @MenuTable_Show;
    end;
    Referen.Insert(i, MenuItem);
  end;
end;

procedure TMainForm.MenuTable_Show(Sender: TObject);
begin
  if RefenForms[(Sender as TMenuItem).Tag] = nil then
    RefenForms[(Sender as TMenuItem).Tag] :=
      TRefenForm.Create(self, Tables[(Sender as TMenuItem).Tag]);
  RefenForms[(Sender as TMenuItem).Tag].Show;
end;

end.

