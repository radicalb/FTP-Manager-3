unit GlavnoOkno;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Buttons, ExtCtrls, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdExplicitTLSClientServerBase, IdAllFTPListParsers, IdFTP, ShellAPI,
  ImgList, ShlObj, ActiveX, DSiWin32, Menus, IdFTPCommon;

type TFTPShortCut=record
  local:boolean;
  path:string[255];
  filename:string[255];
  host:string[255];
  port:integer;
  username:string[255];
  password:string[255];
  pasive:boolean;
end;

type
  TFormGlavnoOkno = class(TForm)
    ListView1: TListView;
    ListView2: TListView;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Panel1: TPanel;
    Panel2: TPanel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    CheckBox1: TCheckBox;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    CheckBox2: TCheckBox;
    IdFTP2: TIdFTP;
    Button1: TButton;
    Button2: TButton;
    Edit9: TEdit;
    Edit10: TEdit;
    ImageList1: TImageList;
    Timer1: TTimer;
    Timer2: TTimer;
    Button3: TButton;
    Button4: TButton;
    ListView3: TListView;
    PopupMenu1: TPopupMenu;
    PopupMenu2: TPopupMenu;
    Delete1: TMenuItem;
    Delete2: TMenuItem;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    BitBtn8: TBitBtn;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    IdFTP1: TIdFTP;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure LoadLeftLocalDir(dir:String);
    procedure LoadRightLocalDir(dir:String);
    function FindFiles(const Path, Mask: string; IncludeSubDir: boolean; FilesList:TStringList): integer;
    procedure FormCreate(Sender: TObject);
    function FindDirectories(const Path:string; IncludeSubDir: boolean; FilesList:TStringList): integer;
    function GetLinkTarget(const LinkFileName:String):String;
    function ExtractDirectoryNameFromPath(path:String):String;
    procedure ListView1DblClick(Sender: TObject);
    procedure ListView2DblClick(Sender: TObject);
    procedure Edit9KeyPress(Sender: TObject; var Key: Char);
    procedure Edit10KeyPress(Sender: TObject; var Key: Char);
    procedure LoadLeftFTPDir(dir:String);
    procedure LoadRightFTPDir(dir:String);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    function GetParentDirectory(path:String):String;
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure AfterOdpriDatotekoNit(msg:String; IdFTPx:TIdFTP);
    procedure AfterGetNit(msg:String; IdFTPx:TIdFTP);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ListView1DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure ListView1DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure ListView2DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure ListView2DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure DoTransferLeftToRight(ASourceDir, ASourceFile, ADestDir, ADestFile: String);
    procedure DoTransferRightToLeft(ASourceDir, ASourceFile, ADestDir, ADestFile: String);
    function CopyDir(const fromDir, toDir: string): Boolean;
    function MoveDir(const fromDir, toDir: string): Boolean;
    function DelDir(dir: string): Boolean;
    procedure IdFTPxWork(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCount: Int64);
    function DoAddProgressBar(tip,vir,cilj:String; max:integer):integer;
    function RepairPath(path:String):String;
    function ExtractFTPDirectoryNameFromPath(path:String):String;
    function FTPDirectorySize(IdFTPy:TIdFTP; ADir:String):integer;
    function IsDirectoryEmpty(const directory : string) : boolean;
    procedure EmptyFolder(folder:string; delete:boolean);
    procedure AfterPutThread(msg:String; IdFTPx:TIdFTP);
    procedure AfterFromBinThread(msg:String; IdFTPx:TIdFTP);
    function CalculateFileSize(fileName:string):integer;
    function CalculateDirectorySize(folder:string):integer;
    procedure Delete1Click(Sender: TObject);
    procedure RemoveFTPDir(IdFTPy:TIdFTP; folder:string);
    procedure RemoveFTPDirectory(IdFTPy:TIdFTP; folder:string);
    procedure Delete2Click(Sender: TObject);
    procedure DeleteLeft;
    procedure DeleteRight;
    procedure BitBtn4DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure BitBtn4DragDrop(Sender, Source: TObject; X, Y: Integer);
    function IncludeTrailingSlash(path:string):string;
    procedure AfterS2SThread(IdFTPs,IdFTPd:TIdFTP);
    procedure BitBtn5DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure BitBtn6DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure BitBtn7DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure BitBtn8DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure BitBtn5DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure BitBtn6DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure BitBtn7DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure BitBtn8DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure DoTransferShortCut(FTPShortCutx:TFTPShortCut; toRight:boolean);
    procedure BitBtn3DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure BitBtn3DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure AfterToBinThread(msg:String; IdFTPx:TIdFTP; fromLeft:boolean);
    procedure BitBtn3Click(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormGlavnoOkno: TFormGlavnoOkno;
  LeftFilesList:TStringList;
  RightFilesList:TStringList;
  LeftCurrentDir, RightCurrentDir: String;
  FTPShortCut1, FTPShortCut2, FTPShortCut3, FTPShortCut4:TFTPShortCut;

implementation

uses OdpriDatoteko, GetNit, PutThread, S2SThread, ToBinThread, RecycleBin;

{$R *.dfm}

procedure TFormGlavnoOkno.BitBtn1Click(Sender: TObject);
begin
  if Panel1.Visible then
    Panel1.Hide
  else if IdFTP1.Connected then
  begin
    Timer1.Enabled:=false;
    IdFTP1.Disconnect;
    BitBtn1.Caption:='-';
    LoadLeftLocalDir(GetCurrentDir);
  end
  else Panel1.Show;
end;

procedure TFormGlavnoOkno.BitBtn2Click(Sender: TObject);
begin
  if Panel2.Visible then
    Panel2.Hide
  else if IdFTP2.Connected then
  begin
    Timer2.Enabled:=false;
    IdFTP2.Disconnect;
    BitBtn2.Caption:='-';
    LoadRightLocalDir(GetCurrentDir);
  end
  else Panel2.Show;
end;

procedure TFormGlavnoOkno.BitBtn3Click(Sender: TObject);
begin
  RecycleBin.FormRecycleBin.Show;
end;

procedure TFormGlavnoOkno.BitBtn3DragDrop(Sender, Source: TObject; X,
  Y: Integer);
var TrashFolderPath:string;
    TrashData:TFTPShortCut;
    TrashInfoFile:file of TFTPShortCut;
begin
  TrashFolderPath:=IncludeTrailingBackslash(GetParentDirectory(application.ExeName))+'RecycleBin\'+StringReplace(DateToStr(Now),'.','',[rfReplaceAll, rfIgnoreCase])+StringReplace(TimeToStr(Now),':','',[rfReplaceAll, rfIgnoreCase])+'\';
  if Source=ListView1 then
  begin
    ForceDirectories(TrashFolderPath);
    //showmessage(TrashFolderPath);
    if IdFTP1.Connected then     // left server to recycle bin
    begin
      TrashData.local:=false;
      TrashData.path:=IncludeTrailingSlash(IdFTP1.RetrieveCurrentDir);
      TrashData.filename:=ListView1.Selected.Caption;
      TrashData.host:=IdFTP1.Host;
      TrashData.port:=IdFTP1.Port;
      TrashData.username:=IdFTP1.Username;
      TrashData.password:=IdFTP1.Password;
      TrashData.pasive:=IdFTP1.Passive;

      IdFTPx:=TIdFTP.Create(FormGlavnoOkno);
      IdFTPx.Port:=IdFTP1.Port;
      IdFTPx.Host:=IdFTP1.Host;
      IdFTPx.Username:=IdFTP1.Username;
      IdFTPx.Password:=IdFTP1.Password;
      IdFTPx.Passive:=IdFTP1.Passive;
      IdFTPx.TransferType:=IdFTP1.TransferType;
      IdFTPx.UseMLIS:=false;
      IdFTPx.OnWork:=IdFTPxWork;
      IdFTPx.Connect;
      IdFTPx.ChangeDir(IdFTP1.RetrieveCurrentDir);

      if IdFTP1.Size(TrashData.filename)<>-1 then
      begin
        //IdFTPx.Tag:=DoAddProgressBar('GET',IncludeTrailingSlash(ASourceDir)+ASourceFile,IncludeTrailingBackSlash(ADestDir)+ADestFile,IdFTPx.Size(ASourceFile));
        IdFTPx.Tag:=DoAddProgressBar('2BIN',IncludeTrailingSlash(TrashData.path)+TrashData.filename,IncludeTrailingBackSlash(TrashFolderPath)+TrashData.filename,0);
        TToBinThread.Create(IdFTPx,TrashData.filename,IncludeTrailingBackSlash(TrashFolderPath)+TrashData.filename,false,true);
      end
      else
      begin
        //IdFTPx.Tag:=DoAddProgressBar('GET',IncludeTrailingSlash(ASourceDir)+ASourceFile,IncludeTrailingBackSlash(ADestDir)+ADestFile,FTPDirectorySize(IdFTPx,ASourceFile));
        IdFTPx.Tag:=DoAddProgressBar('2BIN',IncludeTrailingSlash(TrashData.path)+TrashData.filename,IncludeTrailingBackSlash(TrashFolderPath)+TrashData.filename,0);
        TToBinThread.Create(IdFTPx,TrashData.filename,IncludeTrailingBackSlash(TrashFolderPath)+TrashData.filename,true,true);
      end;
    end
    else             //left local to recycle bin
    begin
      TrashData.local:=true;
      TrashData.path:=IncludeTrailingBackSlash(LeftCurrentDir);
      TrashData.filename:=ListView1.Selected.Caption;

      if FileExists(IncludeTrailingBackSlash(TrashData.path)+TrashData.filename) then
      begin
        CopyFile(PChar(IncludeTrailingBackSlash(TrashData.path)+TrashData.filename),PChar(IncludeTrailingBackSlash(TrashFolderPath)+TrashData.filename),true);
        Windows.DeleteFile(PChar(IncludeTrailingBackSlash(TrashData.path)+TrashData.filename));
      end
      else
      begin
        CopyDir(IncludeTrailingBackSlash(TrashData.path)+TrashData.filename,IncludeTrailingBackSlash(TrashFolderPath)+TrashData.filename);
        EmptyFolder(IncludeTrailingBackSlash(TrashData.path)+TrashData.filename,true);
      end;

      LoadLeftLocalDir(LeftCurrentDir);
    end;
  end
  else  if Source=ListView2 then
  begin
    ForceDirectories(TrashFolderPath);
    //showmessage(TrashFolderPath);
    if IdFTP2.Connected then     // right server to recycle bin
    begin
      TrashData.local:=false;
      TrashData.path:=IncludeTrailingSlash(IdFTP2.RetrieveCurrentDir);
      TrashData.filename:=ListView2.Selected.Caption;
      TrashData.host:=IdFTP2.Host;
      TrashData.port:=IdFTP2.Port;
      TrashData.username:=IdFTP2.Username;
      TrashData.password:=IdFTP2.Password;
      TrashData.pasive:=IdFTP2.Passive;

      IdFTPx:=TIdFTP.Create(FormGlavnoOkno);
      IdFTPx.Port:=IdFTP2.Port;
      IdFTPx.Host:=IdFTP2.Host;
      IdFTPx.Username:=IdFTP2.Username;
      IdFTPx.Password:=IdFTP2.Password;
      IdFTPx.Passive:=IdFTP2.Passive;
      IdFTPx.TransferType:=IdFTP2.TransferType;
      IdFTPx.UseMLIS:=false;
      IdFTPx.OnWork:=IdFTPxWork;
      IdFTPx.Connect;
      IdFTPx.ChangeDir(IdFTP2.RetrieveCurrentDir);

      if IdFTP2.Size(TrashData.filename)<>-1 then
      begin
        //IdFTPx.Tag:=DoAddProgressBar('GET',IncludeTrailingSlash(ASourceDir)+ASourceFile,IncludeTrailingBackSlash(ADestDir)+ADestFile,IdFTPx.Size(ASourceFile));
        IdFTPx.Tag:=DoAddProgressBar('2BIN',IncludeTrailingSlash(TrashData.path)+TrashData.filename,IncludeTrailingBackSlash(TrashFolderPath)+TrashData.filename,0);
        TToBinThread.Create(IdFTPx,TrashData.filename,IncludeTrailingBackSlash(TrashFolderPath)+TrashData.filename,false,false);
      end
      else
      begin
        //IdFTPx.Tag:=DoAddProgressBar('GET',IncludeTrailingSlash(ASourceDir)+ASourceFile,IncludeTrailingBackSlash(ADestDir)+ADestFile,FTPDirectorySize(IdFTPx,ASourceFile));
        IdFTPx.Tag:=DoAddProgressBar('2BIN',IncludeTrailingSlash(TrashData.path)+TrashData.filename,IncludeTrailingBackSlash(TrashFolderPath)+TrashData.filename,0);
        TToBinThread.Create(IdFTPx,TrashData.filename,IncludeTrailingBackSlash(TrashFolderPath)+TrashData.filename,true,false);
      end;
    end
    else             //right local to recycle bin
    begin
      TrashData.local:=true;
      TrashData.path:=IncludeTrailingBackSlash(RightCurrentDir);
      TrashData.filename:=ListView2.Selected.Caption;

      if FileExists(IncludeTrailingBackSlash(TrashData.path)+TrashData.filename) then
      begin
        CopyFile(PChar(IncludeTrailingBackSlash(TrashData.path)+TrashData.filename),PChar(IncludeTrailingBackSlash(TrashFolderPath)+TrashData.filename),true);
        Windows.DeleteFile(PChar(IncludeTrailingBackSlash(TrashData.path)+TrashData.filename));
      end
      else
      begin
        CopyDir(IncludeTrailingBackSlash(TrashData.path)+TrashData.filename,IncludeTrailingBackSlash(TrashFolderPath)+TrashData.filename);
        EmptyFolder(IncludeTrailingBackSlash(TrashData.path)+TrashData.filename,true);
      end;

      LoadRightLocalDir(RightCurrentDir);
    end;
  end;

  AssignFile(TrashInfoFile, TrashFolderPath+'trash.info');
  ReWrite(TrashInfoFile);
  Write(TrashInfoFile, TrashData);
  CloseFile(TrashInfoFile);

  if FormRecycleBin.Visible=true then
  begin
    FormRecycleBin.LoadBin;
  end;

end;

procedure TFormGlavnoOkno.BitBtn3DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept:=(Source=ListView1) or (Source=ListView2);
end;

procedure TFormGlavnoOkno.BitBtn4DragDrop(Sender, Source: TObject; X,
  Y: Integer);
begin
  if Source=ListView1 then
    DeleteLeft
  else  if Source=ListView2 then
    DeleteRight;
end;

procedure TFormGlavnoOkno.BitBtn4DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept:=(Source=ListView1) or (Source=ListView2);
end;

procedure TFormGlavnoOkno.BitBtn5DragDrop(Sender, Source: TObject; X,
  Y: Integer);
begin
  if Source=ListView1 then
  begin
    if IdFTP1.Connected then
    begin
      FTPShortCut1.local:=false;
      FTPShortCut1.path:=IdFTP1.RetrieveCurrentDir;
      FTPShortCut1.filename:=ListView1.Selected.Caption;
      FTPShortCut1.host:=IdFTP1.Host;
      FTPShortCut1.port:=IdFTP1.Port;
      FTPShortCut1.username:=IdFTP1.Username;
      FTPShortCut1.password:=IdFTP1.Password;
      FTPShortCut1.pasive:=IdFTP1.Passive;
    end
    else
    begin
      FTPShortCut1.local:=true;
      FTPShortCut1.path:=IncludeTrailingBackSlash(LeftCurrentDir);
      FTPShortCut1.filename:=ListView1.Selected.Caption;
    end;
  end
  else  if Source=ListView2 then
  begin
    if IdFTP2.Connected then
    begin
      FTPShortCut1.local:=false;
      FTPShortCut1.path:=IdFTP2.RetrieveCurrentDir;
      FTPShortCut1.filename:=ListView2.Selected.Caption;
      FTPShortCut1.host:=IdFTP2.Host;
      FTPShortCut1.port:=IdFTP2.Port;
      FTPShortCut1.username:=IdFTP2.Username;
      FTPShortCut1.password:=IdFTP2.Password;
      FTPShortCut1.pasive:=IdFTP2.Passive;
    end
    else
    begin
      FTPShortCut1.local:=true;
      FTPShortCut1.path:=IncludeTrailingBackSlash(RightCurrentDir);
      FTPShortCut1.filename:=ListView2.Selected.Caption;
    end;
  end;
  BitBtn5.Hint:=FTPShortCut1.path+FTPShortCut1.filename;
  //showmessage(FTPShortCut1.path+FTPShortCut1.filename);
end;

procedure TFormGlavnoOkno.BitBtn5DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept:=(Source=ListView1) or (Source=ListView2);
end;

procedure TFormGlavnoOkno.BitBtn6DragDrop(Sender, Source: TObject; X,
  Y: Integer);
begin
  if Source=ListView1 then
  begin
    if IdFTP1.Connected then
    begin
      FTPShortCut2.local:=false;
      FTPShortCut2.path:=IdFTP1.RetrieveCurrentDir;
      FTPShortCut2.filename:=ListView1.Selected.Caption;
      FTPShortCut2.host:=IdFTP1.Host;
      FTPShortCut2.port:=IdFTP1.Port;
      FTPShortCut2.username:=IdFTP1.Username;
      FTPShortCut2.password:=IdFTP1.Password;
      FTPShortCut2.pasive:=IdFTP1.Passive;
    end
    else
    begin
      FTPShortCut2.local:=true;
      FTPShortCut2.path:=IncludeTrailingBackSlash(LeftCurrentDir);
      FTPShortCut2.filename:=ListView1.Selected.Caption;
    end;
  end
  else  if Source=ListView2 then
  begin
    if IdFTP2.Connected then
    begin
      FTPShortCut2.local:=false;
      FTPShortCut2.path:=IdFTP2.RetrieveCurrentDir;
      FTPShortCut2.filename:=ListView2.Selected.Caption;
      FTPShortCut2.host:=IdFTP2.Host;
      FTPShortCut2.port:=IdFTP2.Port;
      FTPShortCut2.username:=IdFTP2.Username;
      FTPShortCut2.password:=IdFTP2.Password;
      FTPShortCut2.pasive:=IdFTP2.Passive;
    end
    else
    begin
      FTPShortCut2.local:=true;
      FTPShortCut2.path:=IncludeTrailingBackSlash(RightCurrentDir);
      FTPShortCut2.filename:=ListView2.Selected.Caption;
    end;
  end;
  BitBtn6.Hint:=FTPShortCut2.path+FTPShortCut2.filename;
end;

procedure TFormGlavnoOkno.BitBtn6DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept:=(Source=ListView1) or (Source=ListView2);
end;

procedure TFormGlavnoOkno.BitBtn7DragDrop(Sender, Source: TObject; X,
  Y: Integer);
begin
  if Source=ListView1 then
  begin
    if IdFTP1.Connected then
    begin
      FTPShortCut3.local:=false;
      FTPShortCut3.path:=IdFTP1.RetrieveCurrentDir;
      FTPShortCut3.filename:=ListView1.Selected.Caption;
      FTPShortCut3.host:=IdFTP1.Host;
      FTPShortCut3.port:=IdFTP1.Port;
      FTPShortCut3.username:=IdFTP1.Username;
      FTPShortCut3.password:=IdFTP1.Password;
      FTPShortCut3.pasive:=IdFTP1.Passive;
    end
    else
    begin
      FTPShortCut3.local:=true;
      FTPShortCut3.path:=IncludeTrailingBackSlash(LeftCurrentDir);
      FTPShortCut3.filename:=ListView1.Selected.Caption;
    end;
  end
  else  if Source=ListView2 then
  begin
    if IdFTP2.Connected then
    begin
      FTPShortCut3.local:=false;
      FTPShortCut3.path:=IdFTP2.RetrieveCurrentDir;
      FTPShortCut3.filename:=ListView2.Selected.Caption;
      FTPShortCut3.host:=IdFTP2.Host;
      FTPShortCut3.port:=IdFTP2.Port;
      FTPShortCut3.username:=IdFTP2.Username;
      FTPShortCut3.password:=IdFTP2.Password;
      FTPShortCut3.pasive:=IdFTP2.Passive;
    end
    else
    begin
      FTPShortCut3.local:=true;
      FTPShortCut3.path:=IncludeTrailingBackSlash(RightCurrentDir);
      FTPShortCut3.filename:=ListView2.Selected.Caption;
    end;
  end;
  BitBtn7.Hint:=FTPShortCut3.path+FTPShortCut3.filename;
end;

procedure TFormGlavnoOkno.BitBtn7DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept:=(Source=ListView1) or (Source=ListView2);
end;

procedure TFormGlavnoOkno.BitBtn8DragDrop(Sender, Source: TObject; X,
  Y: Integer);
begin
  if Source=ListView1 then
  begin
    if IdFTP1.Connected then
    begin
      FTPShortCut4.local:=false;
      FTPShortCut4.path:=IdFTP1.RetrieveCurrentDir;
      FTPShortCut4.filename:=ListView1.Selected.Caption;
      FTPShortCut4.host:=IdFTP1.Host;
      FTPShortCut4.port:=IdFTP1.Port;
      FTPShortCut4.username:=IdFTP1.Username;
      FTPShortCut4.password:=IdFTP1.Password;
      FTPShortCut4.pasive:=IdFTP1.Passive;
    end
    else
    begin
      FTPShortCut4.local:=true;
      FTPShortCut4.path:=IncludeTrailingBackSlash(LeftCurrentDir);
      FTPShortCut4.filename:=ListView1.Selected.Caption;
    end;
  end
  else  if Source=ListView2 then
  begin
    if IdFTP2.Connected then
    begin
      FTPShortCut4.local:=false;
      FTPShortCut4.path:=IdFTP2.RetrieveCurrentDir;
      FTPShortCut4.filename:=ListView2.Selected.Caption;
      FTPShortCut4.host:=IdFTP2.Host;
      FTPShortCut4.port:=IdFTP2.Port;
      FTPShortCut4.username:=IdFTP2.Username;
      FTPShortCut4.password:=IdFTP2.Password;
      FTPShortCut4.pasive:=IdFTP2.Passive;
    end
    else
    begin
      FTPShortCut4.local:=true;
      FTPShortCut4.path:=IncludeTrailingBackSlash(RightCurrentDir);
      FTPShortCut4.filename:=ListView2.Selected.Caption;
    end;
  end;
  BitBtn8.Hint:=FTPShortCut4.path+FTPShortCut4.filename;
end;

procedure TFormGlavnoOkno.BitBtn8DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept:=(Source=ListView1) or (Source=ListView2);
end;

procedure TFormGlavnoOkno.Button1Click(Sender: TObject);
begin
  try
    if IdFTP1.Connected then
      IdFTP1.Disconnect;
    IdFTP1.Port:=StrToInt(Edit1.Text);
    IdFTP1.Host:=Edit2.Text;
    IdFTP1.Username:=Edit3.Text;
    IdFTP1.Password:=Edit4.Text;
    IdFTP1.Passive:=CheckBox1.Checked;
    IdFTP1.Connect;
    LoadLeftFTPDir(IdFTP1.RetrieveCurrentDir);
    Panel1.Hide;
    BitBtn1.Caption:='x';
    Timer1.Enabled:=true;
  except
      try
        if IdFTP1.Connected then
          IdFTP1.Disconnect;
        IdFTP1.Port:=StrToInt(Edit1.Text);
        IdFTP1.Host:=Edit2.Text;
        IdFTP1.Username:=Edit3.Text;
        IdFTP1.Password:=Edit4.Text;
        IdFTP1.Passive:=not(CheckBox1.Checked);
        IdFTP1.Connect;
        LoadLeftFTPDir(IdFTP1.RetrieveCurrentDir);
        Panel1.Hide;
        BitBtn1.Caption:='x';
        Timer1.Enabled:=true;
        CheckBox1.Checked:=IdFTP1.Passive;
        if IdFTP1.Passive=true then
          showmessage('Povezani ste v PASIVNEM naèinu!')
        else
          showmessage('NISTE povezani v pasivnem naèinu!');
      except
        showmessage('Povezave ni bilo mogoèe vzpostaviti!!!');
      end;
  end;

end;

procedure TFormGlavnoOkno.Button2Click(Sender: TObject);
begin
  try
    if IdFTP2.Connected then
      IdFTP2.Disconnect;
    IdFTP2.Port:=StrToInt(Edit5.Text);
    IdFTP2.Host:=Edit6.Text;
    IdFTP2.Username:=Edit7.Text;
    IdFTP2.Password:=Edit8.Text;
    IdFTP2.Passive:=CheckBox2.Checked;
    IdFTP2.Connect;
    LoadRightFTPDir(IdFTP2.RetrieveCurrentDir);
    Panel2.Hide;
    BitBtn2.Caption:='x';
    Timer2.Enabled:=true;
  except
    try
      if IdFTP2.Connected then
        IdFTP2.Disconnect;
      IdFTP2.Port:=StrToInt(Edit5.Text);
      IdFTP2.Host:=Edit6.Text;
      IdFTP2.Username:=Edit7.Text;
      IdFTP2.Password:=Edit8.Text;
      IdFTP2.Passive:=not(CheckBox2.Checked);
      IdFTP2.Connect;
      LoadRightFTPDir(IdFTP2.RetrieveCurrentDir);
      Panel2.Hide;
      BitBtn2.Caption:='x';
      Timer2.Enabled:=true;

      CheckBox2.Checked:=IdFTP2.Passive;
      if IdFTP2.Passive=true then
        showmessage('Povezani ste v PASIVNEM naèinu!')
      else
        showmessage('NISTE povezani v pasivnem naèinu!');
    except
    showmessage('Povezave ni bilo mogoèe vzpostaviti!!!');
    end;
  end;
end;

procedure TFormGlavnoOkno.Button3Click(Sender: TObject);
begin
  if IdFTP1.Connected then
  begin
    IdFTP1.ChangeDirUp;
    LoadLeftFTPDir(IdFTP1.RetrieveCurrentDir);
  end
  else
  begin
    LoadLeftLocalDir(GetParentDirectory(edit9.Text));
  end;
end;

procedure TFormGlavnoOkno.Button4Click(Sender: TObject);
begin
  if IdFTP2.Connected then
  begin
    IdFTP2.ChangeDirUp;
    LoadRightFTPDir(IdFTP2.RetrieveCurrentDir);
  end
  else
  begin
    LoadRightLocalDir(GetParentDirectory(edit10.Text));
  end;
end;

procedure TFormGlavnoOkno.ListView1DblClick(Sender: TObject);
var IdFTPx:TIdFTP;
begin
  if ListView1.SelCount<=0 then
    exit;

  if IdFTP1.Connected then
  begin
    if IdFTP1.Size(ListView1.Selected.Caption)=-1 then
      LoadLeftFTPDir(ListView1.Selected.Caption)
    else if FileExists(IncludeTrailingBackslash(GetParentDirectory(application.ExeName))+'Temp\'+ListView1.ItemFocused.Caption) then
      ShellExecute(Handle, 'open', PWideChar(IncludeTrailingBackslash(GetParentDirectory(application.ExeName))+'Temp\'+ListView1.ItemFocused.Caption),nil,nil,SW_SHOWNORMAL)
    else if IdFTP1.Size(ListView1.Selected.Caption)>(1024*1024) then
         showmessage('Datoteka je veèja od 1MB, zato predogled ni mogoè!')
    else
    begin
      IdFTPx:=TIdFTP.Create(FormGlavnoOkno);
      IdFTPx.Port:=IdFTP1.Port;
      IdFTPx.Host:=IdFTP1.Host;
      IdFTPx.Username:=IdFTP1.Username;
      IdFTPx.Password:=IdFTP1.Password;
      IdFTPx.Passive:=IdFTP1.Passive;
      IdFTPx.TransferType:=IdFTP1.TransferType;
      IdFTPx.UseMLIS:=false;
      IdFTPx.Connect;
      IdFTPx.ChangeDir(IdFTP1.RetrieveCurrentDir);
      if LeftCurrentDir='/' then
        TOdpriDatotekoNit.Create(IdFTPx,ListView1.ItemFocused.Caption,IncludeTrailingBackslash(GetParentDirectory(application.ExeName))+'Temp\'+ListView1.ItemFocused.Caption)
      else
        TOdpriDatotekoNit.Create(IdFTPx,ListView1.ItemFocused.Caption,IncludeTrailingBackslash(GetParentDirectory(application.ExeName))+'Temp\'+ListView1.ItemFocused.Caption);
    end;
  end
  else
  begin
    if FileExists(IncludeTrailingBackslash(LeftCurrentDir)+ListView1.ItemFocused.Caption) then
      ShellExecute(Handle, 'open', PWideChar(IncludeTrailingBackslash(LeftCurrentDir)+ListView1.ItemFocused.Caption),nil,nil,SW_SHOWNORMAL)
    else
    begin
      if ListView1.ItemFocused.Caption='..' then
        LoadLeftLocalDir(GetParentDirectory(LeftCurrentDir))
      else if ListView1.ItemFocused.Caption<>'.' then
        LoadLeftLocalDir(IncludeTrailingBackslash(LeftCurrentDir)+ListView1.ItemFocused.Caption);
    end;
  end;
end;

procedure TFormGlavnoOkno.ListView1DragDrop(Sender, Source: TObject; X,
  Y: Integer);
begin
  if Source=ListView2 then
    DoTransferRightToLeft(RightCurrentDir,ListView2.Selected.Caption,LeftCurrentDir,ListView2.Selected.Caption)
  else if Source=BitBtn5 then
    DoTransferShortCut(FTPShortCut1,false)
  else if Source=BitBtn6 then
    DoTransferShortCut(FTPShortCut2,false)
  else if Source=BitBtn7 then
    DoTransferShortCut(FTPShortCut3,false)
  else if Source=BitBtn8 then
    DoTransferShortCut(FTPShortCut4,false);
end;

procedure TFormGlavnoOkno.ListView1DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept:=(Source=ListView2) or (Source=BitBtn5) or (Source=BitBtn6) or (Source=BitBtn7) or (Source=BitBtn8);
end;

procedure TFormGlavnoOkno.ListView2DblClick(Sender: TObject);
var IdFTPx:TIdFTP;
begin
  if ListView2.SelCount<=0 then
    exit;

  if IdFTP2.Connected then
  begin
    if IdFTP2.Size(ListView2.Selected.Caption)=-1 then
      LoadRightFTPDir(ListView2.Selected.Caption)
    else if FileExists(IncludeTrailingBackslash(GetParentDirectory(application.ExeName))+'Temp\'+ListView2.ItemFocused.Caption) then
      ShellExecute(Handle, 'open', PWideChar(IncludeTrailingBackslash(GetParentDirectory(application.ExeName))+'Temp\'+ListView2.ItemFocused.Caption),nil,nil,SW_SHOWNORMAL)
    else if IdFTP2.Size(ListView2.Selected.Caption)>(1024*1024) then
         showmessage('Datoteka je veèja od 1MB, zato predogled ni mogoè!')
    else
    begin
      IdFTPx:=TIdFTP.Create(FormGlavnoOkno);
      IdFTPx.Port:=IdFTP2.Port;
      IdFTPx.Host:=IdFTP2.Host;
      IdFTPx.Username:=IdFTP2.Username;
      IdFTPx.Password:=IdFTP2.Password;
      IdFTPx.Passive:=IdFTP2.Passive;
      IdFTPx.TransferType:=IdFTP2.TransferType;
      IdFTPx.UseMLIS:=false;
      IdFTPx.Connect;
      IdFTPx.ChangeDir(IdFTP2.RetrieveCurrentDir);
      if RightCurrentDir='/' then
        TOdpriDatotekoNit.Create(IdFTPx,ListView2.ItemFocused.Caption,IncludeTrailingBackslash(GetParentDirectory(application.ExeName))+'Temp\'+ListView2.ItemFocused.Caption)
      else
        TOdpriDatotekoNit.Create(IdFTPx,RightCurrentDir+'/'+ListView2.ItemFocused.Caption,IncludeTrailingBackslash(GetParentDirectory(application.ExeName))+'Temp\'+ListView2.ItemFocused.Caption);
    end;
  end
  else
  begin
    if FileExists(IncludeTrailingBackslash(RightCurrentDir)+ListView2.ItemFocused.Caption) then
      ShellExecute(Handle, 'open', PWideChar(IncludeTrailingBackslash(RightCurrentDir)+ListView2.ItemFocused.Caption),nil,nil,SW_SHOWNORMAL)
    else
    begin
      if ListView2.ItemFocused.Caption='..' then
        LoadRightLocalDir(GetParentDirectory(RightCurrentDir))
      else if ListView2.ItemFocused.Caption<>'.' then
        LoadRightLocalDir(IncludeTrailingBackslash(RightCurrentDir)+ListView2.ItemFocused.Caption);
    end;
  end;
end;

procedure TFormGlavnoOkno.ListView2DragDrop(Sender, Source: TObject; X,
  Y: Integer);
begin
  if Source=ListView1 then
    DoTransferLeftToRight(LeftCurrentDir,ListView1.Selected.Caption,RightCurrentDir, ListView1.Selected.Caption)
  else if Source=BitBtn5 then
    DoTransferShortCut(FTPShortCut1,true)
  else if Source=BitBtn6 then
    DoTransferShortCut(FTPShortCut2,true)
  else if Source=BitBtn7 then
    DoTransferShortCut(FTPShortCut3,true)
  else if Source=BitBtn8 then
    DoTransferShortCut(FTPShortCut4,true);
end;

procedure TFormGlavnoOkno.ListView2DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept:=(Source=ListView1) or (Source=BitBtn5) or (Source=BitBtn6) or (Source=BitBtn7) or (Source=BitBtn8);
end;

procedure TFormGlavnoOkno.LoadLeftLocalDir(dir:String); //napolni levi listView z lokalno mapo
var   i:integer;
      ListItem:TListItem;
begin
  LeftCurrentDir:=dir;
  LeftFilesList.Clear;
  for i := 0 to ListView1.Items.Count - 1 do
    TProgressBar(ListView1.Items.Item[i].Data).Free;
  ListView1.Clear;
  FindFiles(IncludeTrailingBackSlash(dir),'*.*',false,LeftFilesList);

  for i := 0 to LeftFilesList.Count - 1 do
  begin
    ListView1.Items.BeginUpdate;
    ListView1.SmallImages:=ImageList1;
    ListItem := ListView1.Items.Add;
    if FileExists(LeftFilesList.Strings[i]) then
    begin
      ListItem.Caption:=ExtractFileName(LeftFilesList.Strings[i]);
      ListItem.ImageIndex:=1;
    end
    else
    begin
      ListItem.Caption:=ExtractDirectoryNameFromPath(LeftFilesList.Strings[i]);
      ListItem.ImageIndex:=0;
    end;
    ListView1.Items.EndUpdate;

  end;
  Edit9.Text:=dir;

end;

procedure TFormGlavnoOkno.LoadRightLocalDir(dir:String); //napolni levi listView z lokalno mapo
var   i:integer;
      ListItem:TListItem;
begin
  RightCurrentDir:=dir;
  RightFilesList.Clear;
  for i := 0 to ListView2.Items.Count - 1 do
    TProgressBar(ListView2.Items.Item[i].Data).Free;
  ListView2.Clear;
  FindFiles(IncludeTrailingBackSlash(dir),'*',false,RightFilesList);

  for i := 0 to RightFilesList.Count - 1 do
  begin
    ListView2.Items.BeginUpdate;
    ListView2.SmallImages:=ImageList1;
    ListItem := ListView2.Items.Add;
    if FileExists(RightFilesList.Strings[i]) then
    begin
      ListItem.Caption:=ExtractFileName(RightFilesList.Strings[i]);
      ListItem.ImageIndex:=1;
    end
    else
    begin
      ListItem.Caption:=ExtractDirectoryNameFromPath(RightFilesList.Strings[i]);
      ListItem.ImageIndex:=0;
    end;
    ListView2.Items.EndUpdate;

  end;
  Edit10.Text:=dir;

end;

procedure TFormGlavnoOkno.Timer1Timer(Sender: TObject);
begin
  try
    IdFTP1.Noop;
  except
    IdFTP1.Connect;
  end;
end;

procedure TFormGlavnoOkno.Timer2Timer(Sender: TObject);
begin
  try
    IdFTP2.Noop;
  except
    IdFTP2.Connect;
  end;
end;

function TFormGlavnoOkno.FindFiles(const Path, Mask: string; IncludeSubDir: boolean; FilesList:TStringList): integer;
var
 FindResult: integer;
 SearchRec : TSearchRec;
begin
 result := 0;

 FindResult := FindFirst(Path + Mask, faAnyFile, SearchRec);
 while FindResult = 0 do
 begin
   { do whatever you'd like to do with the files found }
   FilesList.Add(Path + SearchRec.Name);
   result := result + 1;

   FindResult := FindNext(SearchRec);
 end;
 { free memory }
 FindClose(SearchRec);

 if not IncludeSubDir then
   Exit;

 FindResult := FindFirst(Path + '*.*', faDirectory, SearchRec);
 while FindResult = 0 do
 begin
   if (SearchRec.Name <> '.') and (SearchRec.Name <> '..') then
     result := result + FindFiles (Path + SearchRec.Name + '\', Mask, true, FilesList);

   FindResult := FindNext(SearchRec);
 end;
 { free memory }
 FindClose(SearchRec);
end;

function TFormGlavnoOkno.FindDirectories(const Path:string; IncludeSubDir: boolean; FilesList:TStringList): integer;
var
 FindResult: integer;
 SearchRec : TSearchRec;
begin
 result := 0;

 FindResult := FindFirst(Path + '*.*', faDirectory, SearchRec);
 while FindResult = 0 do
 begin
   { do whatever you'd like to do with the files found }
   FilesList.Add(Path + SearchRec.Name);
   result := result + 1;

   FindResult := FindNext(SearchRec);
 end;
 { free memory }
 FindClose(SearchRec);

 if not IncludeSubDir then
   Exit;

 FindResult := FindFirst(Path + '*.*', faDirectory, SearchRec);
 while FindResult = 0 do
 begin
   if (SearchRec.Name <> '.') and (SearchRec.Name <> '..') then
     result := result + FindDirectories (Path + SearchRec.Name + '\', true, FilesList);

   FindResult := FindNext(SearchRec);
 end;
 { free memory }
 FindClose(SearchRec);
end;


procedure TFormGlavnoOkno.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if IsDirectoryEmpty(IncludeTrailingBackslash(GetParentDirectory(application.ExeName))+'Temp')=false then
  begin
     if MessageDlg('Zaèasen imenik vsebuje datoteke/mape. Ali ga želite izprazniti?',mtConfirmation,[mbYes,mbNo], 0)=mrYes then
       EmptyFolder(IncludeTrailingBackslash(GetParentDirectory(application.ExeName))+'Temp',false);
  end;
end;

procedure TFormGlavnoOkno.FormCreate(Sender: TObject);
begin
  //zacasno brisanje
  Edit2.Clear;
  Edit3.Clear;
  Edit4.Clear;
  Edit6.Clear;
  Edit7.Clear;
  Edit8.Clear;

  ForceDirectories(IncludeTrailingBackslash(GetParentDirectory(application.ExeName))+'Temp\');
  ForceDirectories(IncludeTrailingBackslash(GetParentDirectory(application.ExeName))+'RecycleBin\');
  LeftFilesList:=TStringList.Create;
  RightFilesList:=TStringList.Create;
  LoadLeftLocalDir(GetCurrentDir);
  LoadRightLocalDir(GetCurrentDir);
end;

function TFormGlavnoOkno.GetLinkTarget(const LinkFileName:String):String;
var
   psl  : IShellLink;
   ppf  : IPersistFile;
   WidePath  : Array[0..260] of WideChar;
   Info      : Array[0..MAX_PATH] of Char;
   wfs       : TWin32FindData;
begin
 if UpperCase(ExtractFileExt(LinkFileName)) <> '.LNK' Then
 begin
   Result:=LinkFileName;
   Exit;
 end;

 CoCreateInstance(CLSID_ShellLink,
                  nil,
                  CLSCTX_INPROC_SERVER,
                  IShellLink,
                  psl);
 if psl.QueryInterface(IPersistFile, ppf) = 0 then
 begin
   MultiByteToWideChar(CP_ACP,
                       MB_PRECOMPOSED,
                       PAnsiChar(LinkFileName),
                       -1,
                       @WidePath,
                       MAX_PATH);
   ppf.Load(WidePath, STGM_READ);
   psl.GetPath(@info,
               MAX_PATH,
               wfs,
               SLGP_UNCPRIORITY);
   Result := info;
 end
 else
   Result := '';
end;

procedure TFormGlavnoOkno.Edit10KeyPress(Sender: TObject; var Key: Char);
begin
  if ord(Key)=13 then
  begin
    if IdFTP2.Connected then
      LoadRightFTPDir(Edit10.Text)
    else LoadRightLocalDir(Edit10.Text);
  end;
end;

procedure TFormGlavnoOkno.Edit9KeyPress(Sender: TObject; var Key: Char);
begin
  if ord(Key)=13 then
  begin
    if IdFTP1.Connected then
      LoadLeftFTPDir(edit9.Text)
    else LoadLeftLocalDir(edit9.Text);
  end;
end;

function TFormGlavnoOKno.ExtractDirectoryNameFromPath(path:String):String;
var i:integer;
    rezultat:String;
begin
  path:=ExcludeTrailingBackslash(path);
  rezultat:='';
  i:=Length(path);
  while(path[i]<>'\') do
  begin
    rezultat:=path[i]+rezultat;
    i:=i-1;
  end;

  Result:=rezultat;
  //izpiše ime mape iz poti mape
end;

procedure TFormGlavnoOkno.LoadLeftFTPDir(dir:String); //napolni levi listView z ftp mapo
const
  pbColumnIndex = 1;

var   i:integer;
      ListItem:TListItem;
begin
  LeftFilesList.Clear;
  ListView1.Clear;

  if(dir<>'$refresh$') then
  begin
  //showmessage('DIR L:'+dir);
    try
      IdFTP1.ChangeDir(dir);
    except
    end;
  end;
  IdFTP1.List(LeftFilesList,'',false);

  for i := 0 to LeftFilesList.Count - 1 do
  begin
    ListView1.Items.BeginUpdate;
    ListView1.SmallImages:=ImageList1;
    ListItem := ListView1.Items.Add;
    if IdFTP1.Size(LeftFilesList.Strings[i])<>-1 then
    begin
      ListItem.Caption:=LeftFilesList.Strings[i];
      ListItem.ImageIndex:=1;
    end
    else
    begin
      ListItem.Caption:=LeftFilesList.Strings[i];
      ListItem.ImageIndex:=0;
    end;

    ListView1.Items.EndUpdate;

  end;
  LeftCurrentDir:=IdFTP1.RetrieveCurrentDir;
  Edit9.Text:=IdFTP1.RetrieveCurrentDir;
end;

procedure TFormGlavnoOkno.LoadRightFTPDir(dir:String); //napolni desni listView z FTP mapo
const  pbColumnIndex = 1;

var   i:integer;
      ListItem:TListItem;
begin
  RightFilesList.Clear;
  ListView2.Clear;
  //showmessage('DIR R:'+dir);
  if(dir<>'$refresh$') then
  begin
    try
      IdFTP2.ChangeDir(dir);
    except
    end;
  end;
  //showmessage('CDIR_R:'+IdFTP2.RetrieveCurrentDir);
  IdFTP2.List(RightFilesList,'',false);

  for i := 0 to RightFilesList.Count - 1 do
  begin
    ListView2.Items.BeginUpdate;
    ListView2.SmallImages:=ImageList1;
    ListItem := ListView2.Items.Add;
    if IdFTP2.Size(RightFilesList.Strings[i])<>-1 then
    begin
      ListItem.Caption:=RightFilesList.Strings[i];
      ListItem.ImageIndex:=1;
    end
    else
    begin
      ListItem.Caption:=RightFilesList.Strings[i];
      ListItem.ImageIndex:=0;
    end;

    ListView2.Items.EndUpdate;

  end;
  RightCurrentDir:=IdFTP2.RetrieveCurrentDir;
  Edit10.Text:=IdFTP2.RetrieveCurrentDir;

end;

function TFormGlavnoOKno.GetParentDirectory(path:String):String;
var i:integer;
begin
  if ExcludeTrailingBackSlash(path)<>ExtractFileDrive(path) then
  begin
    path:=ExcludeTrailingBackslash(path);
    i:=Length(path);
    while(path[i]<>'\') do
    begin
      Delete(path,length(path),1);
      i:=i-1;
    end;
  end;

  Result:=path;
  //izpiše ime nadmape
end;

procedure TFormGlavnoOkno.AfterOdpriDatotekoNit(msg:String; IdFTPx:TIdFTP);
begin
  IdFTPx.Disconnect;
  IdFTPx.Free;
  ShellExecute(Handle, 'open', PWideChar(msg),nil,nil,SW_SHOWNORMAL);
end;

procedure TFormGlavnoOkno.AfterGetNit(msg:String; IdFTPx:TIdFTP);
begin
  IdFTPx.Disconnect;
  ListView3.Items.Item[TIdFTP(IdFTPx).Tag].SubItems[3]:='Konèano';
  IdFTPx.Free;

  if IdFTP1.Connected=false then
    LoadLeftLocalDir(LeftCurrentDir);
  if IdFTP2.Connected=false then
    LoadRightLocalDir(RightCurrentDir);
end;

procedure TFormGlavnoOkno.AfterToBinThread(msg:String; IdFTPx:TIdFTP; fromLeft:boolean);
begin
  if fromLeft=true then
  begin
    if IdFTPx.Size(msg)<>-1 then
      IdFTPx.Delete(msg)
    else RemoveFTPDirectory(IdFTPx,msg);
    LoadLeftFTPDir('$refresh$');
  end
  else
  begin
    if IdFTPx.Size(msg)<>-1 then
      IdFTPx.Delete(msg)
    else RemoveFTPDirectory(IdFTPx,msg);
    LoadRightFTPDir('$refresh$');
  end;

  IdFTPx.Disconnect;
  ListView3.Items.Item[TIdFTP(IdFTPx).Tag].SubItems[3]:='Konèano';
  IdFTPx.Free;
end;

procedure TFormGlavnoOkno.AfterPutThread(msg:String; IdFTPx:TIdFTP);
begin
  IdFTPx.Disconnect;
  ListView3.Items.Item[TIdFTP(IdFTPx).Tag].SubItems[3]:='Konèano';
  IdFTPx.Free;
  if IdFTP1.Connected=true then
    LoadLeftFTPDir('$refresh$');
  if IdFTP2.Connected=true then
    LoadRightFTPDir('$refresh$');
end;

procedure TFormGlavnoOkno.AfterFromBinThread(msg:String; IdFTPx:TIdFTP);
begin
  EmptyFolder(GetParentDirectory(msg),true);
  IdFTPx.Disconnect;
  ListView3.Items.Item[TIdFTP(IdFTPx).Tag].SubItems[3]:='Konèano';
  IdFTPx.Free;
  if IdFTP1.Connected=true then
    LoadLeftFTPDir('$refresh$');
  if IdFTP2.Connected=true then
    LoadRightFTPDir('$refresh$');
end;

procedure TFormGlavnoOkno.DoTransferLeftToRight(ASourceDir, ASourceFile, ADestDir, ADestFile: String);
var rwt:boolean;
    IdFTPx,IdFTPy:TIdFTP;
begin
  //showmessage(ASourceFile);
  rwt:=true;
  if (IdFTP1.Connected=false) and (IdFTP2.Connected=false) then   //local to local
  begin
    if FileExists(IncludeTrailingBackSlash(ASourceDir)+ASourceFile) then
    begin
      if (FileExists(IncludeTrailingBackSlash(ADestDir)+ADestFile)) then
        if  MessageDlg('Datoteka '+ADestFile+' ze obstaja. Ali jo zelite prepisati?',mtWarning,[mbYes,mbNo], 0)=mrNo then
          rwt:=false;
      CopyFile(PChar(IncludeTrailingBackSlash(ASourceDir)+ASourceFile),PChar(IncludeTrailingBackSlash(ADestDir)+ADestFile),rwt);
    end
    else CopyDir(IncludeTrailingBackSlash(ASourceDir)+ASourceFile,IncludeTrailingBackSlash(ADestDir)+ADestFile);
  LoadRightLocalDir(RightCurrentDir);
  end
  else if(IdFTP1.Connected = true) and (IdFTP2.Connected=false) then       //server to local - GET
  begin
    IdFTPx:=TIdFTP.Create(FormGlavnoOkno);
    IdFTPx.Port:=IdFTP1.Port;
    IdFTPx.Host:=IdFTP1.Host;
    IdFTPx.Username:=IdFTP1.Username;
    IdFTPx.Password:=IdFTP1.Password;
    IdFTPx.Passive:=IdFTP1.Passive;
    IdFTPx.TransferType:=IdFTP1.TransferType;
    IdFTPx.UseMLIS:=false;
    IdFTPx.OnWork:=IdFTPxWork;
    IdFTPx.Connect;
    IdFTPx.ChangeDir(IdFTP1.RetrieveCurrentDir);

    if IdFTP1.Size(ASourceFile)<>-1 then
    begin
      //IdFTPx.Tag:=DoAddProgressBar('GET',IncludeTrailingSlash(ASourceDir)+ASourceFile,IncludeTrailingBackSlash(ADestDir)+ADestFile,IdFTPx.Size(ASourceFile));
      IdFTPx.Tag:=DoAddProgressBar('GET',IncludeTrailingSlash(ASourceDir)+ASourceFile,IncludeTrailingBackSlash(ADestDir)+ADestFile,0);
      TGetNit.Create(IdFTPx,ASourceFile,IncludeTrailingBackSlash(ADestDir)+ADestFile,false);
    end
    else
    begin
      //IdFTPx.Tag:=DoAddProgressBar('GET',IncludeTrailingSlash(ASourceDir)+ASourceFile,IncludeTrailingBackSlash(ADestDir)+ADestFile,FTPDirectorySize(IdFTPx,ASourceFile));
      IdFTPx.Tag:=DoAddProgressBar('GET',IncludeTrailingSlash(ASourceDir)+ASourceFile,IncludeTrailingBackSlash(ADestDir)+ADestFile,0);
      TGetNit.Create(IdFTPx,ASourceFile,IncludeTrailingBackSlash(ADestDir)+ADestFile,true);
    end;

  end
  else if(IdFTP1.Connected = false) and (IdFTP2.Connected=true) then  //local to server
  begin
    IdFTPx:=TIdFTP.Create(FormGlavnoOkno);
    IdFTPx.Port:=IdFTP2.Port;
    IdFTPx.Host:=IdFTP2.Host;
    IdFTPx.Username:=IdFTP2.Username;
    IdFTPx.Password:=IdFTP2.Password;
    IdFTPx.Passive:=IdFTP2.Passive;
    IdFTPx.TransferType:=IdFTP2.TransferType;
    IdFTPx.UseMLIS:=false;
    IdFTPx.OnWork:=IdFTPxWork;
    IdFTPx.Connect;
    IdFTPx.ChangeDir(IdFTP2.RetrieveCurrentDir);

    if FileExists(IncludeTrailingBackSlash(ASourceDir)+ASourceFile) then
    begin
      //IdFTPx.Tag:=DoAddProgressBar('PUT',IncludeTrailingBackSlash(ASourceDir)+ASourceFile,IncludeTrailingSlash(ADestDir)+ADestFile,CalculateFileSize(ASourceFile));
      IdFTPx.Tag:=DoAddProgressBar('PUT',IncludeTrailingBackSlash(ASourceDir)+ASourceFile,IncludeTrailingSlash(ADestDir)+ADestFile,0);
      TPutThread.Create(IdFTPx,IncludeTrailingBackSlash(ASourceDir)+ASourceFile,ADestFile,false);
    end
    else
    begin
      //IdFTPx.Tag:=DoAddProgressBar('PUT',IncludeTrailingBackSlash(ASourceDir)+ASourceFile,IncludeTrailingSlash(ADestDir)+ADestFile,CalculateDirectorySize(ASourceFile));
      IdFTPx.Tag:=DoAddProgressBar('PUT',IncludeTrailingBackSlash(ASourceDir)+ASourceFile,IncludeTrailingSlash(ADestDir)+ADestFile,0);
      TPutThread.Create(IdFTPx,IncludeTrailingBackSlash(ASourceDir)+ASourceFile,ADestFile,true);
    end;

  end
  else  //Server to server
  begin
    IdFTPx:=TIdFTP.Create(FormGlavnoOkno);
    IdFTPx.Port:=IdFTP1.Port;
    IdFTPx.Host:=IdFTP1.Host;
    IdFTPx.Username:=IdFTP1.Username;
    IdFTPx.Password:=IdFTP1.Password;
    IdFTPx.Passive:=IdFTP1.Passive;
    IdFTPx.TransferType:=IdFTP1.TransferType;
    IdFTPx.UseMLIS:=false;
    IdFTPx.OnWork:=IdFTPxWork;
    IdFTPx.Connect;
    IdFTPx.ChangeDir(IdFTP1.RetrieveCurrentDir);

    IdFTPy:=TIdFTP.Create(FormGlavnoOkno);
    IdFTPy.Port:=IdFTP2.Port;
    IdFTPy.Host:=IdFTP2.Host;
    IdFTPy.Username:=IdFTP2.Username;
    IdFTPy.Password:=IdFTP2.Password;
    IdFTPy.Passive:=IdFTP2.Passive;
    IdFTPy.TransferType:=IdFTP2.TransferType;
    IdFTPy.UseMLIS:=false;
    IdFTPy.OnWork:=IdFTPxWork;
    IdFTPy.Connect;
    IdFTPy.ChangeDir(IdFTP2.RetrieveCurrentDir);

    IdFTPx.Tag:=DoAddProgressBar('S2S',IncludeTrailingSlash(IdFTPx.RetrieveCurrentDir)+ASourceFile,IncludeTrailingSlash(IdFTPy.RetrieveCurrentDir)+ADestFile,0);
    IdFTPy.Tag:=IdFTPx.Tag;
    TS2SThread.Create(IdFTPx,IdFTPy,ASourceFile,IncludeTrailingBackslash(GetParentDirectory(application.ExeName))+'Temp\',ADestFile);
  end;

end;

procedure TFormGlavnoOkno.DoTransferRightToLeft(ASourceDir, ASourceFile, ADestDir, ADestFile: String);
var rwt:boolean;
    IdFTPx,IdFTPy:TIdFTP;
begin
  rwt:=true;
  if (IdFTP1.Connected=false) and (IdFTP2.Connected=false) then   //local to local
  begin
    if FileExists(IncludeTrailingBackSlash(ASourceDir)+ASourceFile) then
    begin
      if (FileExists(IncludeTrailingBackSlash(ADestDir)+ADestFile)) then
        if  MessageDlg('Datoteka '+ADestFile+' ze obstaja. Ali jo zelite prepisati?',mtWarning,[mbYes,mbNo], 0)=mrNo then
          rwt:=false;
      CopyFile(PChar(IncludeTrailingBackSlash(ASourceDir)+ASourceFile),PChar(IncludeTrailingBackSlash(ADestDir)+ADestFile),rwt);
    end
    else CopyDir(IncludeTrailingBackSlash(ASourceDir)+ASourceFile,IncludeTrailingBackSlash(ADestDir)+ADestFile);
  LoadLeftLocalDir(LeftCurrentDir);
  end
  else if(IdFTP2.Connected = true) and (IdFTP1.Connected=false) then       //server to local - GET
  begin
    IdFTPx:=TIdFTP.Create(FormGlavnoOkno);
    IdFTPx.Port:=IdFTP2.Port;
    IdFTPx.Host:=IdFTP2.Host;
    IdFTPx.Username:=IdFTP2.Username;
    IdFTPx.Password:=IdFTP2.Password;
    IdFTPx.Passive:=IdFTP2.Passive;
    IdFTPx.TransferType:=IdFTP2.TransferType;
    IdFTPx.UseMLIS:=false;
    IdFTPx.OnWork:=IdFTPxWork;
    IdFTPx.Connect;
    IdFTPx.ChangeDir(IdFTP2.RetrieveCurrentDir);

    if IdFTP2.Size(ASourceFile)<>-1 then
    begin
      //IdFTPx.Tag:=DoAddProgressBar('GET',IncludeTrailingSlash(ASourceDir)+ASourceFile,IncludeTrailingBackSlash(ADestDir)+ADestFile,IdFTPx.Size(ASourceFile));
      IdFTPx.Tag:=DoAddProgressBar('GET',IncludeTrailingSlash(ASourceDir)+ASourceFile,IncludeTrailingBackSlash(ADestDir)+ADestFile,0);
      TGetNit.Create(IdFTPx,ASourceFile,IncludeTrailingBackSlash(ADestDir)+ADestFile,false);
    end
    else
    begin
      //IdFTPx.Tag:=DoAddProgressBar('GET',IncludeTrailingSlash(ASourceDir)+ASourceFile,IncludeTrailingBackSlash(ADestDir)+ADestFile,FTPDirectorySize(IdFTPx,ASourceFile));
      IdFTPx.Tag:=DoAddProgressBar('GET',IncludeTrailingSlash(ASourceDir)+ASourceFile,IncludeTrailingBackSlash(ADestDir)+ADestFile,0);
      TGetNit.Create(IdFTPx,ASourceFile,IncludeTrailingBackSlash(ADestDir)+ADestFile,true);
    end;

  end
  else if(IdFTP2.Connected = false) and (IdFTP1.Connected=true) then  //local to server
  begin
    IdFTPx:=TIdFTP.Create(FormGlavnoOkno);
    IdFTPx.Port:=IdFTP1.Port;
    IdFTPx.Host:=IdFTP1.Host;
    IdFTPx.Username:=IdFTP1.Username;
    IdFTPx.Password:=IdFTP1.Password;
    IdFTPx.Passive:=IdFTP1.Passive;
    IdFTPx.TransferType:=IdFTP1.TransferType;
    IdFTPx.UseMLIS:=false;
    IdFTPx.OnWork:=IdFTPxWork;
    IdFTPx.Connect;
    IdFTPx.ChangeDir(IdFTP1.RetrieveCurrentDir);

    if FileExists(IncludeTrailingBackSlash(ASourceDir)+ASourceFile) then
    begin
      //IdFTPx.Tag:=DoAddProgressBar('PUT',IncludeTrailingBackSlash(ASourceDir)+ASourceFile,IncludeTrailingSlash(ADestDir)+ADestFile,CalculateFileSize(ASourceFile));
      IdFTPx.Tag:=DoAddProgressBar('PUT',IncludeTrailingBackSlash(ASourceDir)+ASourceFile,IncludeTrailingSlash(ADestDir)+ADestFile,0);
      TPutThread.Create(IdFTPx,IncludeTrailingBackSlash(ASourceDir)+ASourceFile,ADestFile,false);
    end
    else
    begin
      //IdFTPx.Tag:=DoAddProgressBar('PUT',IncludeTrailingBackSlash(ASourceDir)+ASourceFile,IncludeTrailingSlash(ADestDir)+ADestFile,CalculateDirectorySize(ASourceFile));
      IdFTPx.Tag:=DoAddProgressBar('PUT',IncludeTrailingBackSlash(ASourceDir)+ASourceFile,IncludeTrailingSlash(ADestDir)+ADestFile,0);
      TPutThread.Create(IdFTPx,IncludeTrailingBackSlash(ASourceDir)+ASourceFile,ADestFile,true);
    end;

  end
  else  //Server to server
  begin
    IdFTPx:=TIdFTP.Create(FormGlavnoOkno);
    IdFTPx.Port:=IdFTP2.Port;
    IdFTPx.Host:=IdFTP2.Host;
    IdFTPx.Username:=IdFTP2.Username;
    IdFTPx.Password:=IdFTP2.Password;
    IdFTPx.Passive:=IdFTP2.Passive;
    IdFTPx.TransferType:=IdFTP2.TransferType;
    IdFTPx.UseMLIS:=false;
    IdFTPx.OnWork:=IdFTPxWork;
    IdFTPx.Connect;
    IdFTPx.ChangeDir(IdFTP2.RetrieveCurrentDir);

    IdFTPy:=TIdFTP.Create(FormGlavnoOkno);
    IdFTPy.Port:=IdFTP1.Port;
    IdFTPy.Host:=IdFTP1.Host;
    IdFTPy.Username:=IdFTP1.Username;
    IdFTPy.Password:=IdFTP1.Password;
    IdFTPy.Passive:=IdFTP1.Passive;
    IdFTPy.TransferType:=IdFTP1.TransferType;
    IdFTPy.UseMLIS:=false;
    IdFTPy.OnWork:=IdFTPxWork;
    IdFTPy.Connect;
    IdFTPy.ChangeDir(IdFTP1.RetrieveCurrentDir);

    IdFTPx.Tag:=DoAddProgressBar('S2S',IncludeTrailingSlash(IdFTPx.RetrieveCurrentDir)+ASourceFile,IncludeTrailingSlash(IdFTPy.RetrieveCurrentDir)+ADestFile,0);
    IdFTPy.Tag:=IdFTPx.Tag;
    TS2SThread.Create(IdFTPx,IdFTPy,ASourceFile,IncludeTrailingBackslash(GetParentDirectory(application.ExeName))+'Temp\',ADestFile);
  end;

end;

function TFormGlavnoOkno.CopyDir(const fromDir, toDir: string): Boolean;
var
  fos: TSHFileOpStruct;
begin
  ZeroMemory(@fos, SizeOf(fos));
  with fos do
  begin
    wFunc  := FO_COPY;
    fFlags := FOF_FILESONLY;
    pFrom  := PChar(fromDir + #0);
    pTo    := PChar(toDir)
  end;
  Result := (0 = ShFileOperation(fos));
end;


function TFormGlavnoOkno.MoveDir(const fromDir, toDir: string): Boolean;
var
  fos: TSHFileOpStruct;
begin
  ZeroMemory(@fos, SizeOf(fos));
  with fos do
  begin
    wFunc  := FO_MOVE;
    fFlags := FOF_FILESONLY;
    pFrom  := PChar(fromDir + #0);
    pTo    := PChar(toDir)
  end;
  Result := (0 = ShFileOperation(fos));
end;

function TFormGlavnoOkno.DelDir(dir: string): Boolean;
var
  fos: TSHFileOpStruct;
begin
  ZeroMemory(@fos, SizeOf(fos));
  with fos do
  begin
    wFunc  := FO_DELETE;
    fFlags := FOF_SILENT or FOF_NOCONFIRMATION;
    pFrom  := PChar(dir + #0);
  end;
  Result := (0 = ShFileOperation(fos));
end;

procedure TFormGlavnoOkno.Delete1Click(Sender: TObject);
begin
  DeleteLeft;
end;

procedure TFormGlavnoOkno.Delete2Click(Sender: TObject);
begin
  DeleteRight;
end;

procedure TFormGlavnoOkno.IdFTPxWork(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCount: Int64);
begin
  //showmessage('BeforeWORK'+IntToStr(TIdFTP(ASender).Tag));
  try
    TProgressBar(ListView3.Items.Item[TIdFTP(ASender).Tag].Data).Position:=AWorkCount;
  except

  end;
end;

function TFormGlavnoOkno.DoAddProgressBar(tip,vir,cilj:String; max:integer):integer;
var   i:integer;
      ListItem:TListItem;
      pBar:TProgressBar;
      pbRect:TRect;
begin
    //showmessage('DoADD');
    ListView3.Items.BeginUpdate;
    ListItem := ListView3.Items.Add;
    ListItem.Caption:=tip;
    ListItem.SubItems.Add(vir);
    ListItem.SubItems.Add(cilj);

    //create a ProgressBar, place it in the napredek column
    pBar := TProgressBar.Create(nil);
    pBar.Parent := ListView3;
    ListItem.Data := pBar;

    pbRect := ListItem.DisplayRect(drBounds);
    pbRect.Left := pbRect.Left +ListView3.Columns[0].Width+ListView3.Columns[1].Width+ListView3.Columns[2].Width;
    pbRect.Right := pbRect.Left +ListView3.Columns[3].Width;
    pBar.BoundsRect := pbRect;
    //pBar.Max:=max;

    ListItem.SubItems.Add('');
    ListItem.SubItems.Add('Prenašam');

    ListView3.Items.EndUpdate;

    Result:=ListView3.Items.Count-1;
    //showmessage('DoEND');

end;

function TFormGlavnoOkno.RepairPath(path:String):String;
var i:integer;
    rezultat:String;
begin
  rezultat:=path[1];
  for i:=2 to Length(path) do
    if not ((path[i-1]='/')and(path[i]='\')) then
      rezultat:=rezultat+path[i];

  Result:=rezultat;
end;

function TFormGlavnoOKno.ExtractFTPDirectoryNameFromPath(path:String):String;
var i:integer;
    rezultat:String;
begin
  if(path[Length(path)])='/' then
    delete(path,Length(path),1);

  rezultat:='';
  i:=Length(path);
  while(path[i]<>'/') do
  begin
    rezultat:=path[i]+rezultat;
    i:=i-1;
  end;

  Result:=rezultat;
  //izpiše ime mape ali datoteke na FTP iz poti mape oz. datoteke
end;

function TFormGlavnoOKno.FTPDirectorySize(IdFTPy:TIdFTP; ADir:String):integer;
var Files:TStringList;
    i:integer;
    IdFTPx:TIdFTP;
    rezultat:integer;
begin
  rezultat:=0;
  // By RadicalB: Calculate dir size on ftp
  IdFTPx:=TIdFTP.Create(FormGlavnoOkno);
  IdFTPx.Port:=IdFTPy.Port;
  IdFTPx.Host:=IdFTPy.Host;
  IdFTPx.Username:=IdFTPy.Username;
  IdFTPx.Password:=IdFTPy.Password;
  IdFTPx.Passive:=IdFTPy.Passive;
  IdFTPx.TransferType:=IdFTPy.TransferType;
  IdFTPx.UseMLIS:=false;
  IdFTPx.Connect;

  IdFTPx.ChangeDir(ADir);
  Files:=TStringList.Create;
  IdFTPx.List(Files,'',false);
  for i:=0 to Files.Count-1  do
  begin
    if IdFTPx.Size(Files.Strings[i])<>-1 then
      rezultat:=rezultat+IdFTPx.Size(Files.Strings[i])
    else
      rezultat:=rezultat+FTPDirectorySize(IdFTPx,Files.Strings[i]);
  end;
  Files.Free;
  IdFTPx.ChangeDirUp;
  Result:=rezultat;

end;

//returns true if a given directory is empty, false otherwise
function TFormGlavnoOkno.IsDirectoryEmpty(const directory : string) : boolean;
var
  searchRec :TSearchRec;
begin
  try
   result := (FindFirst(directory+'\*.*', faAnyFile, searchRec) = 0) AND
             (FindNext(searchRec) = 0) AND
             (FindNext(searchRec) <> 0) ;
  finally
    FindClose(searchRec) ;
  end;
end;

procedure TFormGlavnoOkno.EmptyFolder(folder:string; delete:boolean);
var
    err     : integer;
    folderBk: string;
    S       : TSearchRec;
  begin
    folderBk := IncludeTrailingBackslash(folder);
    err := FindFirst(folderBk+'*.*', faAnyFile, S);
    if err = 0 then
    begin
      repeat
        if FileExists(folderBk+S.Name) then
          Windows.DeleteFile(PChar(folderBk+S.Name))
        else if (DirectoryExists(folderBk+S.Name)) and (S.Name<>'.') and (S.Name<>'..') then
          EmptyFolder(folderBk+S.Name,true);
        err := FindNext(S);
      until err <> 0;
      FindClose(S);

      if delete=true then
        Windows.RemoveDirectory(PChar(folderBk));
    end;
end;

// returns file size or -1 if not found.
function TFormGlavnoOkno.CalculateFileSize(fileName:string):integer;
var
  sr : TSearchRec;
begin
  if FindFirst(fileName, faAnyFile, sr ) = 0 then
      result := Integer(sr.FindData.nFileSizeHigh) shl Integer(32) + Integer(sr.FindData.nFileSizeLow)
  else
     result := -1;

  FindClose(sr) ;
end;


procedure TFormGlavnoOkno.CheckBox3Click(Sender: TObject);
begin
if CheckBox3.Checked then
begin
  Edit4.Enabled:=false;
  Edit3.Text:='anonymous';
end
else
begin
  Edit4.Enabled:=true;
end;
end;

procedure TFormGlavnoOkno.CheckBox4Click(Sender: TObject);
begin
if CheckBox4.Checked then
begin
  Edit8.Enabled:=false;
  Edit7.Text:='anonymous';
end
else
begin
  Edit8.Enabled:=true;
end;
end;

function TFormGlavnoOkno.CalculateDirectorySize(folder:string):integer;
var
    err     : integer;
    folderBk: string;
    S       : TSearchRec;
    rez     : integer;
  begin
    rez:=0;
    folderBk := IncludeTrailingBackslash(folder);
    err := FindFirst(folderBk+'*.*', faAnyFile, S);
    if err = 0 then
    begin
      repeat
        if FileExists(folderBk+S.Name) then
          rez:=rez+CalculateFileSize(folderBk+S.Name)
        else if (DirectoryExists(folderBk+S.Name)) and (S.Name<>'.') and (S.Name<>'..') then
          rez:=rez+CalculateDirectorySize(folderBk+S.Name);
        err := FindNext(S);
      until err <> 0;
      FindClose(S);
  end;
  Result:=rez;
end;

procedure TFormGlavnoOkno.RemoveFTPDirectory(IdFTPy: TIdFTP; folder: string);
var IdFTPx:TIdFTP;
begin
  IdFTPx:=TIdFTP.Create(FormGlavnoOkno);
  IdFTPx.Port:=IdFTPy.Port;
  IdFTPx.Host:=IdFTPy.Host;
  IdFTPx.Username:=IdFTPy.Username;
  IdFTPx.Password:=IdFTPy.Password;
  IdFTPx.Passive:=IdFTPy.Passive;
  IdFTPx.TransferType:=IdFTPy.TransferType;
  IdFTPx.UseMLIS:=false;
  IdFTPx.Connect;
  IdFTPx.ChangeDir(IdFTPy.RetrieveCurrentDir);

  //showmessage('REM:'+folder);
  RemoveFTPDir(IdFTPx, folder);

  IdFTPx.Disconnect;
  IdFTPx.Free;
end;

procedure TFormGlavnoOkno.RemoveFTPDir(IdFTPy: TIdFTP; folder: string);      //please use RemoveFTPDirectory
var Files:TStringList;
    i:integer;
begin
  //showmessage(folder);

  IdFTPy.ChangeDir(folder);
  //showmessage('AFTER');

  Files:=TStringList.Create;
  IdFTPy.List(Files,'',false);
  for i:=0 to Files.Count-1  do
  begin
    //showmessage('FILER:'+Files.Strings[i]);
    if IdFTPy.Size(Files.Strings[i])<>-1 then
      IdFTPy.Delete(Files.Strings[i])
    else RemoveFTPDir(IdFTPy,Files.Strings[i]);
  end;
  Files.Free;
  IdFTPy.ChangeDirUp;
  //showmessage('UP:'+IdFTPy.RetrieveCurrentDir);
  IdFTPy.RemoveDir(folder);
end;

procedure TFormGlavnoOkno.DeleteLeft;
begin
  if MessageDlg('Ali ste preprièani, da želite izbrisati datoteko/mapo '+ListView1.Selected.Caption+' ?',mtWarning,[mbYes,mbNo], 0)=mrYes then
  begin
    if IdFTP1.Connected=false then
    begin
      if FileExists(IncludeTrailingBackSlash(LeftCurrentDir)+ListView1.Selected.Caption) then
        Windows.DeleteFile(PWideChar(IncludeTrailingBackSlash(LeftCurrentDir)+ListView1.Selected.Caption))
      else EmptyFolder(IncludeTrailingBackSlash(LeftCurrentDir)+ListView1.Selected.Caption,true);
      LoadLeftLocalDir(LeftCurrentDir);
    end
    else
    begin
      if IdFTP1.Size(ListView1.Selected.Caption)<>-1 then
        IdFTP1.Delete(ListView1.Selected.Caption)
      else RemoveFTPDirectory(IdFTP1,ListView1.Selected.Caption);
      LoadLeftFTPDir('$refresh$');
    end;
  end;
end;

procedure TFormGlavnoOkno.DeleteRight;
begin
    if MessageDlg('Ali ste preprièani, da želite izbrisati datoteko/mapo '+ListView2.Selected.Caption+' ?',mtWarning,[mbYes,mbNo], 0)=mrYes then
  begin
    if IdFTP2.Connected=false then
    begin
      if FileExists(IncludeTrailingBackSlash(RightCurrentDir)+ListView2.Selected.Caption) then
        Windows.DeleteFile(PWideChar(IncludeTrailingBackSlash(RightCurrentDir)+ListView2.Selected.Caption))
      else EmptyFolder(IncludeTrailingBackSlash(RightCurrentDir)+ListView2.Selected.Caption,true);
      LoadRightLocalDir(RightCurrentDir);
    end
    else
    begin
      if IdFTP2.Size(ListView2.Selected.Caption)<>-1 then
        IdFTP2.Delete(ListView2.Selected.Caption)
      else RemoveFTPDirectory(IdFTP2,ListView2.Selected.Caption);
      LoadRightFTPDir('$refresh$');
    end;
  end;
end;

function TFormGlavnoOkno.IncludeTrailingSlash(path:string):string;
begin
  //
  if path[length(path)]<>'/' then
    path:=path+'/';

  Result:=path;

end;

procedure TFormGlavnoOkno.AfterS2SThread(IdFTPs,IdFTPd:TIdFTP);
begin
  //
  IdFTPs.Disconnect;
  ListView3.Items.Item[TIdFTP(IdFTPs).Tag].SubItems[3]:='Konèano';
  IdFTPs.Free;
  IdFTPd.Disconnect;
  IdFTPd.Free;

  if IdFTP1.Connected=false then
    LoadLeftLocalDir(LeftCurrentDir);
  if IdFTP2.Connected=false then
    LoadRightLocalDir(RightCurrentDir);

  if IdFTP1.Connected=true then
    LoadLeftFTPDir('$refresh$');
  if IdFTP2.Connected=true then
    LoadRightFTPDir('$refresh$');

end;

procedure TFormGlavnoOkno.DoTransferShortCut(FTPShortCutx:TFTPShortCut; toRight:boolean);
    var rwt:boolean;
    IdFTPx,IdFTPy:TIdFTP;
begin
  if toRight=true then                 //Transfer from Shortcut to Right side
  begin
    rwt:=true;
    if (FTPShortCutx.local=true) and (IdFTP2.Connected=false) then   //local to local
    begin
      if FileExists(IncludeTrailingBackSlash(FTPShortCutx.path)+FTPShortCutx.filename) then
      begin
        if (FileExists(IncludeTrailingBackSlash(RightCurrentDir)+FTPShortCutx.filename)) then
          if  MessageDlg('Datoteka '+FTPShortCutx.filename+' ze obstaja. Ali jo zelite prepisati?',mtWarning,[mbYes,mbNo], 0)=mrNo then
            rwt:=false;
        CopyFile(PChar(IncludeTrailingBackSlash(FTPShortCutx.path)+FTPShortCutx.filename),PChar(IncludeTrailingBackSlash(RightCurrentDir)+FTPShortCutx.filename),rwt);
      end
      else CopyDir(IncludeTrailingBackSlash(FTPShortCutx.path)+FTPShortCutx.filename,IncludeTrailingBackSlash(RightCurrentDIr)+FTPShortCutx.filename);
    LoadRightLocalDir(RightCurrentDir);
    end
    else if(FTPShortCutx.local=false) and (IdFTP2.Connected=false) then       //server to local - GET
    begin
      IdFTPx:=TIdFTP.Create(FormGlavnoOkno);
      IdFTPx.Port:=FTPShortCutx.port;
      IdFTPx.Host:=FTPShortCutx.host;
      IdFTPx.Username:=FTPShortCutx.username;
      IdFTPx.Password:=FTPShortCutx.password;
      IdFTPx.Passive:=FTPShortCutx.pasive;
      IdFTPx.TransferType:=ftBinary;
      IdFTPx.UseMLIS:=false;
      IdFTPx.OnWork:=IdFTPxWork;
      IdFTPx.Connect;

      IdFTPx.ChangeDir(FTPShortCutx.path);
      if IdFTPx.Size(FTPShortCutx.filename)<>-1 then
      begin
        //IdFTPx.Tag:=DoAddProgressBar('GET',IncludeTrailingSlash(ASourceDir)+ASourceFile,IncludeTrailingBackSlash(ADestDir)+ADestFile,IdFTPx.Size(ASourceFile));
        IdFTPx.Tag:=DoAddProgressBar('GET',IncludeTrailingSlash(FTPShortCutx.path)+FTPShortCutx.filename,IncludeTrailingBackSlash(RightCurrentDir)+FTPShortCutx.filename,0);
        TGetNit.Create(IdFTPx,FTPShortCutx.filename,IncludeTrailingBackSlash(RightCurrentDir)+FTPShortCutx.filename,false);
      end
      else
      begin
        //IdFTPx.Tag:=DoAddProgressBar('GET',IncludeTrailingSlash(ASourceDir)+ASourceFile,IncludeTrailingBackSlash(ADestDir)+ADestFile,FTPDirectorySize(IdFTPx,ASourceFile));
       IdFTPx.Tag:=DoAddProgressBar('GET',IncludeTrailingSlash(FTPShortCutx.path)+FTPShortCutx.filename,IncludeTrailingBackSlash(RightCurrentDir)+FTPShortCutx.filename,0);
        TGetNit.Create(IdFTPx,FTPShortCutx.filename,IncludeTrailingBackSlash(RightCurrentDir)+FTPShortCutx.filename,true);
      end;

    end
    else if(FTPShortCutx.local=true) and (IdFTP2.Connected=true) then  //local to server
    begin
      IdFTPx:=TIdFTP.Create(FormGlavnoOkno);
      IdFTPx.Port:=IdFTP2.Port;
      IdFTPx.Host:=IdFTP2.Host;
      IdFTPx.Username:=IdFTP2.Username;
      IdFTPx.Password:=IdFTP2.Password;
      IdFTPx.Passive:=IdFTP2.Passive;
      IdFTPx.TransferType:=IdFTP2.TransferType;
      IdFTPx.UseMLIS:=false;
      IdFTPx.OnWork:=IdFTPxWork;
      IdFTPx.Connect;
      IdFTPx.ChangeDir(IdFTP2.RetrieveCurrentDir);

      if FileExists(IncludeTrailingBackSlash(FTPShortCutx.path)+FTPShortCutx.filename) then
      begin
        //IdFTPx.Tag:=DoAddProgressBar('PUT',IncludeTrailingBackSlash(ASourceDir)+ASourceFile,IncludeTrailingSlash(ADestDir)+ADestFile,CalculateFileSize(ASourceFile));
        IdFTPx.Tag:=DoAddProgressBar('PUT',IncludeTrailingBackSlash(FTPShortCutx.path)+FTPShortCutx.filename,IncludeTrailingSlash(RightCurrentDir)+FTPShortCutx.filename,0);
        TPutThread.Create(IdFTPx,IncludeTrailingBackSlash(FTPShortCutx.path)+FTPShortCutx.filename,FTPShortCutx.filename,false);
      end
      else
      begin
        //IdFTPx.Tag:=DoAddProgressBar('PUT',IncludeTrailingBackSlash(ASourceDir)+ASourceFile,IncludeTrailingSlash(ADestDir)+ADestFile,CalculateDirectorySize(ASourceFile));
        IdFTPx.Tag:=DoAddProgressBar('PUT',IncludeTrailingBackSlash(FTPShortCutx.path)+FTPShortCutx.filename,IncludeTrailingSlash(RightCurrentDir)+FTPShortCutx.filename,0);
        TPutThread.Create(IdFTPx,IncludeTrailingBackSlash(FTPShortCutx.path)+FTPShortCutx.filename,FTPShortCutx.filename,true);
      end;

    end
    else  //Server to server
    begin
      IdFTPx:=TIdFTP.Create(FormGlavnoOkno);
      IdFTPx.Port:=FTPShortCutx.Port;
      IdFTPx.Host:=FTPShortCutx.Host;
      IdFTPx.Username:=FTPShortCutx.Username;
      IdFTPx.Password:=FTPShortCutx.Password;
      IdFTPx.Passive:=FTPShortCutx.pasive;
      IdFTPx.TransferType:=ftBinary;
      IdFTPx.UseMLIS:=false;
      IdFTPx.OnWork:=IdFTPxWork;
      IdFTPx.Connect;
      IdFTPx.ChangeDir(FTPShortCutx.path);

      IdFTPy:=TIdFTP.Create(FormGlavnoOkno);
      IdFTPy.Port:=IdFTP2.Port;
      IdFTPy.Host:=IdFTP2.Host;
      IdFTPy.Username:=IdFTP2.Username;
      IdFTPy.Password:=IdFTP2.Password;
      IdFTPy.Passive:=IdFTP2.Passive;
      IdFTPy.TransferType:=IdFTP2.TransferType;
      IdFTPy.UseMLIS:=false;
      IdFTPy.OnWork:=IdFTPxWork;
      IdFTPy.Connect;
      IdFTPy.ChangeDir(IdFTP2.RetrieveCurrentDir);

      IdFTPx.Tag:=DoAddProgressBar('S2S',IncludeTrailingSlash(IdFTPx.RetrieveCurrentDir)+FTPShortCutx.filename,IncludeTrailingSlash(IdFTPy.RetrieveCurrentDir)+FTPShortCutx.filename,0);
      IdFTPy.Tag:=IdFTPx.Tag;
      TS2SThread.Create(IdFTPx,IdFTPy,FTPShortCutx.filename,IncludeTrailingBackslash(GetParentDirectory(application.ExeName))+'Temp\',FTPShortCutx.filename);
    end;

  end
  else  //from shortcut to left side
  begin
    rwt:=true;
    if (FTPShortCutx.local=true) and (IdFTP1.Connected=false) then   //local to local
    begin
      if FileExists(IncludeTrailingBackSlash(FTPShortCutx.path)+FTPShortCutx.filename) then
      begin
        if (FileExists(IncludeTrailingBackSlash(LeftCurrentDir)+FTPShortCutx.filename)) then
          if  MessageDlg('Datoteka '+FTPShortCutx.filename+' ze obstaja. Ali jo zelite prepisati?',mtWarning,[mbYes,mbNo], 0)=mrNo then
            rwt:=false;
        CopyFile(PChar(IncludeTrailingBackSlash(FTPShortCutx.path)+FTPShortCutx.filename),PChar(IncludeTrailingBackSlash(LeftCurrentDir)+FTPShortCutx.filename),rwt);
      end
      else CopyDir(IncludeTrailingBackSlash(FTPShortCutx.path)+FTPShortCutx.filename,IncludeTrailingBackSlash(LeftCurrentDir)+FTPShortCutx.filename);
    LoadRightLocalDir(LeftCurrentDir);
    end
    else if(FTPShortCutx.local=false) and (IdFTP1.Connected=false) then       //server to local - GET
    begin
      IdFTPx:=TIdFTP.Create(FormGlavnoOkno);
      IdFTPx.Port:=FTPShortCutx.port;
      IdFTPx.Host:=FTPShortCutx.host;
      IdFTPx.Username:=FTPShortCutx.username;
      IdFTPx.Password:=FTPShortCutx.password;
      IdFTPx.Passive:=FTPShortCutx.pasive;
      IdFTPx.TransferType:=ftBinary;
      IdFTPx.UseMLIS:=false;
      IdFTPx.OnWork:=IdFTPxWork;
      IdFTPx.Connect;

      IdFTPx.ChangeDir(FTPShortCutx.path);
      if IdFTPx.Size(FTPShortCutx.filename)<>-1 then
      begin
        //IdFTPx.Tag:=DoAddProgressBar('GET',IncludeTrailingSlash(ASourceDir)+ASourceFile,IncludeTrailingBackSlash(ADestDir)+ADestFile,IdFTPx.Size(ASourceFile));
        IdFTPx.Tag:=DoAddProgressBar('GET',IncludeTrailingSlash(FTPShortCutx.path)+FTPShortCutx.filename,IncludeTrailingBackSlash(LeftCurrentDir)+FTPShortCutx.filename,0);
        TGetNit.Create(IdFTPx,FTPShortCutx.filename,IncludeTrailingBackSlash(LeftCurrentDir)+FTPShortCutx.filename,false);
      end
      else
      begin
        //IdFTPx.Tag:=DoAddProgressBar('GET',IncludeTrailingSlash(ASourceDir)+ASourceFile,IncludeTrailingBackSlash(ADestDir)+ADestFile,FTPDirectorySize(IdFTPx,ASourceFile));
       IdFTPx.Tag:=DoAddProgressBar('GET',IncludeTrailingSlash(FTPShortCutx.path)+FTPShortCutx.filename,IncludeTrailingBackSlash(LeftCurrentDir)+FTPShortCutx.filename,0);
        TGetNit.Create(IdFTPx,FTPShortCutx.filename,IncludeTrailingBackSlash(LeftCurrentDir)+FTPShortCutx.filename,true);
      end;

    end
    else if(FTPShortCutx.local=true) and (IdFTP1.Connected=true) then  //local to server
    begin
      IdFTPx:=TIdFTP.Create(FormGlavnoOkno);
      IdFTPx.Port:=IdFTP1.Port;
      IdFTPx.Host:=IdFTP1.Host;
      IdFTPx.Username:=IdFTP1.Username;
      IdFTPx.Password:=IdFTP1.Password;
      IdFTPx.Passive:=IdFTP1.Passive;
      IdFTPx.TransferType:=IdFTP1.TransferType;
      IdFTPx.UseMLIS:=false;
      IdFTPx.OnWork:=IdFTPxWork;
      IdFTPx.Connect;
      IdFTPx.ChangeDir(IdFTP1.RetrieveCurrentDir);

      if FileExists(IncludeTrailingBackSlash(FTPShortCutx.path)+FTPShortCutx.filename) then
      begin
        //IdFTPx.Tag:=DoAddProgressBar('PUT',IncludeTrailingBackSlash(ASourceDir)+ASourceFile,IncludeTrailingSlash(ADestDir)+ADestFile,CalculateFileSize(ASourceFile));
        IdFTPx.Tag:=DoAddProgressBar('PUT',IncludeTrailingBackSlash(FTPShortCutx.path)+FTPShortCutx.filename,IncludeTrailingSlash(LeftCurrentDir)+FTPShortCutx.filename,0);
        TPutThread.Create(IdFTPx,IncludeTrailingBackSlash(FTPShortCutx.path)+FTPShortCutx.filename,FTPShortCutx.filename,false);
      end
      else
      begin
        //IdFTPx.Tag:=DoAddProgressBar('PUT',IncludeTrailingBackSlash(ASourceDir)+ASourceFile,IncludeTrailingSlash(ADestDir)+ADestFile,CalculateDirectorySize(ASourceFile));
        IdFTPx.Tag:=DoAddProgressBar('PUT',IncludeTrailingBackSlash(FTPShortCutx.path)+FTPShortCutx.filename,IncludeTrailingSlash(LeftCurrentDir)+FTPShortCutx.filename,0);
        TPutThread.Create(IdFTPx,IncludeTrailingBackSlash(FTPShortCutx.path)+FTPShortCutx.filename,FTPShortCutx.filename,true);
      end;

    end
    else  //Server to server
    begin
      IdFTPx:=TIdFTP.Create(FormGlavnoOkno);
      IdFTPx.Port:=FTPShortCutx.Port;
      IdFTPx.Host:=FTPShortCutx.Host;
      IdFTPx.Username:=FTPShortCutx.Username;
      IdFTPx.Password:=FTPShortCutx.Password;
      IdFTPx.Passive:=FTPShortCutx.pasive;
      IdFTPx.TransferType:=ftBinary;
      IdFTPx.UseMLIS:=false;
      IdFTPx.OnWork:=IdFTPxWork;
      IdFTPx.Connect;
      IdFTPx.ChangeDir(FTPShortCutx.path);

      IdFTPy:=TIdFTP.Create(FormGlavnoOkno);
      IdFTPy.Port:=IdFTP1.Port;
      IdFTPy.Host:=IdFTP1.Host;
      IdFTPy.Username:=IdFTP1.Username;
      IdFTPy.Password:=IdFTP1.Password;
      IdFTPy.Passive:=IdFTP1.Passive;
      IdFTPy.TransferType:=IdFTP1.TransferType;
      IdFTPy.UseMLIS:=false;
      IdFTPy.OnWork:=IdFTPxWork;
      IdFTPy.Connect;
      IdFTPy.ChangeDir(IdFTP1.RetrieveCurrentDir);

      IdFTPx.Tag:=DoAddProgressBar('S2S',IncludeTrailingSlash(IdFTPx.RetrieveCurrentDir)+FTPShortCutx.filename,IncludeTrailingSlash(IdFTPy.RetrieveCurrentDir)+FTPShortCutx.filename,0);
      IdFTPy.Tag:=IdFTPx.Tag;
      TS2SThread.Create(IdFTPx,IdFTPy,FTPShortCutx.filename,IncludeTrailingBackslash(GetParentDirectory(application.ExeName))+'Temp\',FTPShortCutx.filename);
    end;

  end;

end;

end.
