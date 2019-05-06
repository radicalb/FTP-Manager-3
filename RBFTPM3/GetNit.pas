unit GetNit;

interface

uses
  Classes, IdFTP, Dialogs, SysUtils, ComCtrls;

type
  TGetNit = class(TThread)
  private
    { Private declarations }
  protected
    procedure Execute; override;
    procedure GetDirectory(IdFTPx:TIdFTP; ASourceDir:String; ADestDir:String; Overwrite:boolean);
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

    procedure getNit.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end; }

{ getNit }

constructor TGetNit.Create(YourFTPClient:TIdFTP; ASource,ADest:String; IsDir:boolean);
begin
  xSource:=ASource;
  xDest:=ADest;
  IdFTPx:=YourFTPClient;
  IsDirectory:=IsDir;
  self.FreeOnTerminate:= true;
  inherited Create(False);
end;

procedure TGetNit.Execute;
begin
  //showmessage(xSource+'!!'+xDest+'!!'+IdFTPx.RetrieveCurrentDir);
  if IsDirectory then
  begin
    GetDirectory(IdFTPx,xSource,xDest,true);
  end
  else
  begin
    IdFTPx.Get(xSource,xDest,true,true);
  end;

  FormGlavnoOkno.AfterGetNit(xDest,IdFTPx);
  Terminate;
end;

procedure TGetNit.GetDirectory(IdFTPx:TIdFTP; ASourceDir:String; ADestDir:String; Overwrite:boolean);
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
