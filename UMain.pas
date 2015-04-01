unit UMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Registry;

type
  TFMain = class(TForm)
    btnGet: TButton;
    btnSet: TButton;
    btnClose: TButton;
    lbPathes: TListBox;
    StatusBar1: TStatusBar;
    btnAdd: TButton;
    btnEdit: TButton;
    btnDel: TButton;
    btnCopy: TButton;
    procedure btnCloseClick(Sender: TObject);
    procedure btnGetClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSetClick(Sender: TObject);
    procedure btnDelClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure lbPathesDblClick(Sender: TObject);
    procedure btnCopyClick(Sender: TObject);
  private
    { Private declarations }
    procedure GetEnv;
  public
    { Public declarations }
  end;

var
  FMain: TFMain;

const
  RegPath = 'System\CurrentControlSet\Control\Session Manager\Environment';

implementation

{$R *.dfm}

procedure TFMain.btnGetClick(Sender: TObject);
begin
  GetEnv;
end;

procedure TFMain.btnSetClick(Sender: TObject);
var
  i: integer;
  Line: string;
  Reg: TRegistry;
begin
  Line := '';
  for i := 0 to lbPathes.Count - 1 do
    if not lbPathes.Items[i].IsEmpty then
      Line := Line + lbPathes.Items[i] + ';';
  if Line[Length(Line)] <> ';' then
    Line := Copy(Line, 1, Length(Line) - 1);

  Reg := TRegistry.Create(KEY_ALL_ACCESS);
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    if Reg.OpenKey(RegPath, false) then
      Reg.WriteString('PATH', Line);
    BroadcastSystemMessage(BSF_POSTMESSAGE, 0, WM_SETTINGCHANGE, 0, 0);
  finally
    Reg.Free;
  end;

end;

procedure TFMain.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFMain.btnCopyClick(Sender: TObject);
var
  NewPath, OldPath: string;
begin
  if lbPathes.ItemIndex = -1 then
    exit;
  OldPath := lbPathes.Items[lbPathes.ItemIndex];
  NewPath := InputBox('Path', 'Enter path', OldPath);
  if NewPath <> OldPath then
    lbPathes.Items.Add(NewPath);
end;

procedure TFMain.btnAddClick(Sender: TObject);
var
  NewPath: string;
begin
  NewPath := InputBox('Path', 'Enter path', '');
  if NewPath <> '' then
    lbPathes.Items.Add(NewPath);
end;

procedure TFMain.btnEditClick(Sender: TObject);
var
  NewPath, OldPath: string;
begin
  if lbPathes.ItemIndex = -1 then
    exit;
  OldPath := lbPathes.Items[lbPathes.ItemIndex];
  NewPath := InputBox('Path', 'Enter path', OldPath);
  if NewPath <> OldPath then
    lbPathes.Items[lbPathes.ItemIndex] := NewPath;
end;

procedure TFMain.btnDelClick(Sender: TObject);
var
  OldIndex: integer;
begin
  OldIndex := lbPathes.ItemIndex;
  if OldIndex = -1 then
    exit;
  lbPathes.Items.Delete(OldIndex);
  if OldIndex > lbPathes.Count - 1 then
    OldIndex := lbPathes.Count - 1;
  try
    lbPathes.ItemIndex := OldIndex;
  except
  end;
end;

procedure TFMain.FormCreate(Sender: TObject);
begin
  GetEnv;
end;

function utlsGetToken(aString: string; const SepChar: string; TokenNum: integer): string;
var
  Token: string;
  StrLen, TNum, TEnd: integer;
begin
  StrLen := Length(aString);
  TNum := 1;
  TEnd := StrLen;

  while (TNum <= TokenNum) and (TEnd <> 0) do
  begin
    TEnd := Pos(SepChar, aString);
    if TEnd <> 0 then
    begin
      Token := Copy(aString, 1, TEnd - 1);
      Delete(aString, 1, TEnd);
      Inc(TNum);
    end
    else
      Token := aString;
  end;

  if TNum >= TokenNum then
    utlsGetToken := Token
  else
    utlsGetToken := '';
end;

{******************************************************************************}

function utlsNumToken(aString: string; const aSepChar: string): integer;
var
  RChar: Char;
  CurrPos: integer;
begin
  if aSepChar = '#' then
    RChar := '*'
  else
    RChar := '#';

  Result := 0;
  CurrPos := Length(aString);
  while CurrPos <> 0 do
  begin
    Inc(Result);
    CurrPos := Pos(aSepChar, aString);
    if CurrPos <> 0 then
      aString[CurrPos] := RChar;
  end;
end;



procedure TFMain.GetEnv;
var
  i: integer;
  Line: string;
  Reg: TRegistry;
begin
  Line := '';
  Reg := TRegistry.Create(KEY_ALL_ACCESS);
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    if Reg.OpenKey(RegPath, false) then
      Line := Reg.ReadString('PATH');
  finally
    Reg.Free;
  end;

  lbPathes.Clear;
  if Line.IsEmpty then
    exit;
  if Line[Length(Line)] <> ';' then
    Line := Line + ';';

  for i := 1 to utlsNumToken(Line, ';') do
    if not utlsGetToken(Line, ';', i).IsEmpty then
      lbPathes.AddItem(utlsGetToken(Line, ';', i), nil);
end;

procedure TFMain.lbPathesDblClick(Sender: TObject);
begin
  btnEditClick(btnEdit);
end;

end.
