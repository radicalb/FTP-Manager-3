unit S2SThread;

interface

uses
  Classes, IdFTP, Dialogs, SysUtils, ComCtrls, Windows;

type
  TS2SThread = class(TThread)
  private
    { Private declarations }
  protected
    procedure Execute; override;
    procedure PutDirectory(IdFTPx:TIdFTP; ASourceDir:String; ADestDir:String);
    procedure GetDirectory(IdFTPx:TIdFTP; ASourceDir:String; ADestDir:String; Overwrite:boolean);
    function IncludeTrailingSlash(path:string):string;
  public
    constructor Create(SourceFTPClient,DestFTPClient:TIdFTP; ASource,ATemp,ADest:String);
  end;

var
  IdFTPs:TIdFTP;
  IdFTPd:TIdFTP;
  xSource,xTemp,xDest:String;

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

constructor TS2SThread.Create(SourceFTPClient,DestFTPClient:TIdFTP; ASource,ATemp,ADest:String);
begin
  xSource:=ASource;
  xTemp:=ATemp;
  xDest:=ADest;
  IdFTPs:=SourceFTPClient;
  IdFTPd:=DestFTPClient;
  self.FreeOnTerminate:= true;
  inherited Create(False);
end;

procedure TS2SThread.Execute;
var tID:Integer;
begin
  tId:=Windows.GetCurrentThreadID;
  //showmessage('2TMP:'+xTemp);
  //showmessage('SDir:'+IdFTPs.RetrieveCurrentDir+' DDir:'+IdFTPd.RetrieveCurrentDir+' ');
  if IdFTPs.Size(xSource)<>-1 then
  begin
    //showmessage('GF:'+xSource);
    IdFTPs.Get(xSource,xTemp+xSource+'-'+IntToStr(tID),true,true);
    //showmessage('PF:'+xDest);
    IdFTPd.Put(xTemp+xSource+'-'+IntToStr(tID),xDest);
  end
  else
  begin
    GetDirectory(IdFTPs,xSource,xTemp+xSource+'-'+IntToStr(tID),true);
    PutDirectory(IdFTPd,xTemp+xSource+'-'+IntToStr(tID),xDest);
  end;

  FormGlavnoOkno.AfterS2SThread(IdFTPs,IdFTPd);
  Terminate;
end;

procedure TS2SThread.PutDirectory(IdFTPx:TIdFTP; ASourceDir:String; ADestDir:String);
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
    ShowMessage('Napaka mapa '+ADestDir+' že obstaja||'+IdFTPx.RetrieveCurrentDir);
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
          PutDirectory(IdFTPx,folderBk+S.Name,IncludeTrailingSlash(IdFTPx.RetrieveCurrentDir)+S.Name);
        err := FindNext(S);
      until err <> 0;
      SysUtils.FindClose(S);
    end;
  IdFTPx.ChangeDirUp;
end;

function TS2SThread.IncludeTrailingSlash(path:string):string;
begin
  //
  if path[length(path)]<>'/' then
    path:=path+'/';

  Result:=path;

end;

procedure TS2SThread.GetDirectory(IdFTPx:TIdFTP; ASourceDir:String; ADestDir:String; Overwrite:boolean);
var Files:TStringList;
    i:integer;
begin
  // By RadicalB: Transfer complete Directory
  ForceDirectories(ADestDir);
  IdFTPx.ChangeDir(ASourceDir);

  Files:=TStringList.Create;
  IdFTPx.List(Files,'',false);
  for i:=0 to Files.Count-1  do
  begin
    if IdFTPx.Size(Files.Strings[i])<>-1 then
    begin
      //TProgressBar(FormGlavnoOkno.ListView3.Items.Item[IdFTPx.Tag].Data).Max:=IdFTPx.Size(Files.Strings[i]);
      IdFTPx.Get(Files.Strings[i],IncludeTrailingBackSlash(ADestDir)+Files.Strings[i],Overwrite,false);
    end
    else
      GetDirectory(IdFTPx,Files.Strings[i],IncludeTrailingBackSlash(ADestDir)+Files.Strings[i],Overwrite);
  end;
  Files.Free;
  IdFTPx.ChangeDirUp;
end;

end.
