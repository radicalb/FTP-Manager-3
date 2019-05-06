unit FromBinThread;

interface

uses
  Classes, IdFTP, Dialogs, SysUtils, ComCtrls;

type
  TFromBinThread = class(TThread)
  private
    { Private declarations }
  protected
    procedure Execute; override;
    procedure PutDirectory(IdFTPx:TIdFTP; ASourceDir:String; ADestDir:String);
    function IncludeTrailingSlash(path:string):string;
  public
    constructor Create(YourFTPClient:TIdFTP; ASource,ADest:String;IsDir:boolean);
  end;

var
  IdFTPx:TIdFTP;
  xSource,xDest:String;
  IsDirectory:boolean;

implementation

uses GlavnoOkno;

{ Important: Methods and properties of objects in visual components can only be
  used in a method called using Synchronize, for example,

      Synchronize(UpdateCaption);

  and UpdateCaption could look like,

    procedure PutThread.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end; }

{ PutThread }

constructor TFromBinThread.Create(YourFTPClient:TIdFTP; ASource,ADest:String; IsDir:boolean);
begin
  xSource:=ASource;
  xDest:=ADest;
  IdFTPx:=YourFTPClient;
  IsDirectory:=IsDir;
  self.FreeOnTerminate:= true;
  inherited Create(False);
end;

procedure TFromBinThread.Execute;
begin
  //showmessage(xDest);
  if IsDirectory then
  begin
    PutDirectory(IdFTPx,xSource,xDest);
  end
  else
  begin
    IdFTPx.Put(xSource,IncludeTrailingSlash(IdFTPx.RetrieveCurrentDir)+xDest);
  end;
  FormGlavnoOkno.AfterFromBinThread(xSource,IdFTPx);
  Terminate;
end;

procedure TFromBinThread.PutDirectory(IdFTPx:TIdFTP; ASourceDir:String; ADestDir:String);
var Files:TStringList;
    i:integer;
    err     : integer;
    folderBk: string;
    S       : TSearchRec;
begin
  // By RadicalB: Transfer complete Directory

  try
    IdFTPx.MakeDir(ADestDir);
  except
    //ShowMessage('Napaka mapa '+ADestDir+' že obstaja||'+IdFTPx.RetrieveCurrentDir);
    //ShowMessage('ASourceDir');
  end;
  IdFTPx.ChangeDir(ADestDir);

  folderBk := IncludeTrailingBackslash(ASourceDir);
    err := FindFirst(folderBk+'*.*', faAnyFile, S);
    if err = 0 then
    begin
      repeat
        if FileExists(folderBk+S.Name) then
          IdFTPx.Put(folderBk+S.Name,S.Name)
        else if (DirectoryExists(folderBk+S.Name)) and (S.Name<>'.') and (S.Name<>'..') then
          PutDirectory(IdFTPx,S.Name,IncludeTrailingSlash(IdFTPx.RetrieveCurrentDir)+S.Name);
        err := FindNext(S);
      until err <> 0;
      FindClose(S);
    end;
  IdFTPx.ChangeDirUp;
end;

function TFromBinThread.IncludeTrailingSlash(path:string):string;
begin
  //
  if path[length(path)]<>'/' then
    path:=path+'/';

  Result:=path;

end;

end.
