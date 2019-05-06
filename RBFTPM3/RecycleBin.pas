unit RecycleBin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ComCtrls, ImgList, IdFTP, IdFTPCommon;

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
  TFormRecycleBin = class(TForm)
    ListView1: TListView;
    MainMenu1: TMainMenu;
    Ko1: TMenuItem;
    Izprazni1: TMenuItem;
    Obnovi1: TMenuItem;
    ImageList1: TImageList;
    PopupMenu1: TPopupMenu;
    Obnovi2: TMenuItem;
    Izbrisi1: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Izprazni1Click(Sender: TObject);
    procedure Obnovi1Click(Sender: TObject);
    procedure LoadBin;
    procedure ListView1InfoTip(Sender: TObject; Item: TListItem;
      var InfoTip: string);
    procedure Izbrisi1Click(Sender: TObject);
    procedure Obnovi2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormRecycleBin: TFormRecycleBin;

implementation

{$R *.dfm}

uses GlavnoOkno, FromBinThread;

procedure TFormRecycleBin.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose:=false;
  self.Hide;
end;

procedure TFormRecycleBin.FormShow(Sender: TObject);
begin
  LoadBin;
end;

procedure TFormRecycleBin.Izbrisi1Click(Sender: TObject);
begin
  if ListView1.SelCount<=0 then
    exit;

  //showmessage(ListView1.Selected.SubItems.Strings[0]);
  FormGlavnoOkno.EmptyFolder(ListView1.Selected.SubItems.Strings[0],true);
  ListView1.Selected.Delete;
end;

procedure TFormRecycleBin.Izprazni1Click(Sender: TObject);
begin
if MessageDlg('Ali ste preprièani, da želite izbrisati celotno vsebino koša?',mtWarning,[mbYes,mbNo], 0)=mrYes then
  begin
    FormGlavnoOkno.EmptyFolder(IncludeTrailingBackSlash(IncludeTrailingBackslash(FormGlavnoOkno.GetParentDirectory(application.ExeName))+'RecycleBin\'),false);
    ListView1.Clear;
  end
end;

procedure TFormRecycleBin.Obnovi1Click(Sender: TObject);
var TrashCodesList:TStringList;
    i:integer;
    ListItem:TListItem;
    searchRec :TSearchRec;
    TrashFolderPath:string;
    TrashData:TFTPShortCut;
    TrashInfoFile:file of TFTPShortCut;
    IdFTPx:TIdFTP;
    safetyTriger:integer;
begin
  TrashCodesList:=TStringList.Create;
  FormGlavnoOkno.FindFiles(IncludeTrailingBackSlash(IncludeTrailingBackslash(FormGlavnoOkno.GetParentDirectory(application.ExeName))+'RecycleBin\'),'*.*',false,TrashCodesList);

  for i := 0 to TrashCodesList.Count - 1 do
  begin
    if (TrashCodesList.Strings[i][length(TrashCodesList.Strings[i])]<>'.') then
    begin
      AssignFile(TrashInfoFile, IncludeTrailingBackSlash(TrashCodesList.Strings[i])+'trash.info');
      Reset(TrashInfoFile);
      Read(TrashInfoFile, TrashData);
      CloseFile(TrashInfoFile);

      FindFirst(TrashCodesList.Strings[i]+'\*.*', faAnyFile, searchRec);

      safetyTriger:=0;
      if (searchRec.Name='.') or (searchRec.Name='..') or (searchRec.Name='trash.info') then
      begin
        while ((searchRec.Name='.') or (searchRec.Name='..')  or (searchRec.Name='trash.info') and (safetyTriger<50)) do
        begin
          FindNext(searchRec);
          safetyTriger:=safetyTriger+1;
        end;
      end;

      if(safetyTriger<50) then
      begin
        if TrashData.local=true then
        begin
          if FileExists(TrashCodesList.Strings[i]+'\'+searchRec.Name) then
          begin
            CopyFile(PChar(IncludeTrailingBackSlash(TrashCodesList.Strings[i])+TrashData.filename),PChar(IncludeTrailingBackSlash(TrashData.path)+TrashData.filename),true);
            FormGlavnoOkno.EmptyFolder(TrashCodesList.Strings[i],true);
            //showmessage(TrashCodesList.Strings[i]);
          end
          else
          begin
            FormGlavnoOkno.CopyDir(IncludeTrailingBackSlash(TrashCodesList.Strings[i])+TrashData.filename,IncludeTrailingBackSlash(TrashData.path)+TrashData.filename);
            FormGlavnoOkno.EmptyFolder(TrashCodesList.Strings[i],true);
          end;
        end
        else
        begin
          IdFTPx:=TIdFTP.Create(FormGlavnoOkno);
          IdFTPx.Port:=TrashData.port;
          IdFTPx.Host:=TrashData.Host;
          IdFTPx.Username:=TrashData.Username;
          IdFTPx.Password:=TrashData.Password;
          IdFTPx.Passive:=TrashData.Pasive;
          IdFTPx.TransferType:=ftBinary;
          IdFTPx.UseMLIS:=false;
          IdFTPx.OnWork:=FormGlavnoOkno.IdFTPxWork;
          IdFTPx.Connect;
          IdFTPx.ChangeDir(TrashData.path);

          if FileExists(IncludeTrailingBackSlash(TrashCodesList.Strings[i])+TrashData.filename) then
          begin
            IdFTPx.Tag:=FormGlavnoOkno.DoAddProgressBar('RET',IncludeTrailingBackSlash(TrashCodesList.Strings[i])+TrashData.filename,FormGlavnoOkno.IncludeTrailingSlash(TrashData.path)+TrashData.filename,0);
            TFromBinThread.Create(IdFTPx,IncludeTrailingBackSlash(TrashCodesList.Strings[i])+TrashData.filename,TrashData.filename,false);
          end
          else
          begin
            IdFTPx.Tag:=FormGlavnoOkno.DoAddProgressBar('RET',IncludeTrailingBackSlash(TrashCodesList.Strings[i])+TrashData.filename,FormGlavnoOkno.IncludeTrailingSlash(TrashData.path)+TrashData.filename,0);
            TFromBinThread.Create(IdFTPx,IncludeTrailingBackSlash(TrashCodesList.Strings[i])+TrashData.filename,TrashData.filename,true);
          end;
        end;
      end
      else
      begin
        FormGlavnoOkno.EmptyFolder(TrashCodesList.Strings[i],true);
      end;
    end;
  end;
  ListView1.Items.Clear;
  TrashCodesList.Free;
end;

procedure TFormRecycleBin.Obnovi2Click(Sender: TObject);
var TrashCodesList:TStringList;
    i:integer;
    ListItem:TListItem;
    searchRec :TSearchRec;
    TrashFolderPath:string;
    TrashData:TFTPShortCut;
    TrashInfoFile:file of TFTPShortCut;
    IdFTPx:TIdFTP;
    safetyTriger:integer;
begin
  if ListView1.SelCount<=0 then
    exit;

  AssignFile(TrashInfoFile, IncludeTrailingBackSlash(ListView1.Selected.SubItems.Strings[0])+'trash.info');
  Reset(TrashInfoFile);
  Read(TrashInfoFile, TrashData);
  CloseFile(TrashInfoFile);

  FindFirst(ListView1.Selected.SubItems.Strings[0]+'\*.*', faAnyFile, searchRec);

  safetyTriger:=0;
  if (searchRec.Name='.') or (searchRec.Name='..') or (searchRec.Name='trash.info') then
  begin
    while ((searchRec.Name='.') or (searchRec.Name='..')  or (searchRec.Name='trash.info') and (safetyTriger<50)) do
    begin
      FindNext(searchRec);
      safetyTriger:=safetyTriger+1;
    end;
  end;

  if(safetyTriger<50) then
  begin
    if TrashData.local=true then
    begin
      if FileExists(ListView1.Selected.SubItems.Strings[0]+'\'+searchRec.Name) then
      begin
        CopyFile(PChar(IncludeTrailingBackSlash(ListView1.Selected.SubItems.Strings[0])+TrashData.filename),PChar(IncludeTrailingBackSlash(TrashData.path)+TrashData.filename),true);
        FormGlavnoOkno.EmptyFolder(ListView1.Selected.SubItems.Strings[0],true);
        //showmessage(ListView1.Selected.SubItems.Strings[0]);
      end
      else
      begin
        FormGlavnoOkno.CopyDir(IncludeTrailingBackSlash(ListView1.Selected.SubItems.Strings[0])+TrashData.filename,IncludeTrailingBackSlash(TrashData.path)+TrashData.filename);
        FormGlavnoOkno.EmptyFolder(ListView1.Selected.SubItems.Strings[0],true);
      end;
    end
    else
    begin
      IdFTPx:=TIdFTP.Create(FormGlavnoOkno);
      IdFTPx.Port:=TrashData.port;
      IdFTPx.Host:=TrashData.Host;
      IdFTPx.Username:=TrashData.Username;
      IdFTPx.Password:=TrashData.Password;
      IdFTPx.Passive:=TrashData.Pasive;
      IdFTPx.TransferType:=ftBinary;
      IdFTPx.UseMLIS:=false;
      IdFTPx.OnWork:=FormGlavnoOkno.IdFTPxWork;
      IdFTPx.Connect;
      IdFTPx.ChangeDir(TrashData.path);

      if FileExists(IncludeTrailingBackSlash(ListView1.Selected.SubItems.Strings[0])+TrashData.filename) then
      begin
        IdFTPx.Tag:=FormGlavnoOkno.DoAddProgressBar('RET',IncludeTrailingBackSlash(ListView1.Selected.SubItems.Strings[0])+TrashData.filename,FormGlavnoOkno.IncludeTrailingSlash(TrashData.path)+TrashData.filename,0);
        TFromBinThread.Create(IdFTPx,IncludeTrailingBackSlash(ListView1.Selected.SubItems.Strings[0])+TrashData.filename,TrashData.filename,false);
      end
      else
      begin
        IdFTPx.Tag:=FormGlavnoOkno.DoAddProgressBar('RET',IncludeTrailingBackSlash(ListView1.Selected.SubItems.Strings[0])+TrashData.filename,FormGlavnoOkno.IncludeTrailingSlash(TrashData.path)+TrashData.filename,0);
        TFromBinThread.Create(IdFTPx,IncludeTrailingBackSlash(ListView1.Selected.SubItems.Strings[0])+TrashData.filename,TrashData.filename,true);
      end;
    end;
  end
  else
  begin
    FormGlavnoOkno.EmptyFolder(ListView1.Selected.SubItems.Strings[0],true);
  end;
  ListView1.Selected.Delete;
end;

procedure TFormRecycleBin.ListView1InfoTip(Sender: TObject; Item: TListItem;
  var InfoTip: string);
begin
  InfoTip:=Item.SubItems.Strings[1];
  //showmessage(InfoTip);
end;

procedure TFormRecycleBin.LoadBin;
var TrashCodesList:TStringList;
    TrashData:TFTPShortCut;
    TrashInfoFile:file of TFTPShortCut;
    i,safetyTriger:integer;
    ListItem:TListItem;
    searchRec :TSearchRec;
begin
  ListView1.Clear;
  TrashCodesList:=TStringList.Create;
  FormGlavnoOkno.FindFiles(IncludeTrailingBackSlash(IncludeTrailingBackslash(FormGlavnoOkno.GetParentDirectory(application.ExeName))+'RecycleBin\'),'*.*',false,TrashCodesList);

  for i := 0 to TrashCodesList.Count - 1 do
  begin
    if (TrashCodesList.Strings[i][length(TrashCodesList.Strings[i])]<>'.') then
    begin
      //showmessage(IncludeTrailingBackSlash(TrashCodesList.Strings[i])+'trash.info');
      if not FileExists(IncludeTrailingBackSlash(TrashCodesList.Strings[i])+'trash.info') then
      begin
        FormGlavnoOkno.EmptyFolder(TrashCodesList.Strings[i],true);
      end
      else
      begin
        AssignFile(TrashInfoFile, IncludeTrailingBackSlash(TrashCodesList.Strings[i])+'trash.info');
        Reset(TrashInfoFile);
        Read(TrashInfoFile, TrashData);
        CloseFile(TrashInfoFile);

        ListView1.Items.BeginUpdate;
        ListView1.LargeImages:=ImageList1;
        ListItem := ListView1.Items.Add;
        FindFirst(TrashCodesList.Strings[i]+'\*.*', faAnyFile, searchRec);

        safetyTriger:=0;
        if (searchRec.Name='.') or (searchRec.Name='..') or (searchRec.Name='trash.info') then
        begin
          while ((searchRec.Name='.') or (searchRec.Name='..')  or (searchRec.Name='trash.info') and (safetyTriger<50)) do
          begin
            FindNext(searchRec);
            safetyTriger:=safetyTriger+1;
          end;
        end;

        if FileExists(TrashCodesList.Strings[i]+'\'+searchRec.Name) then
        begin
          ListItem.Caption:=searchRec.Name;
          ListItem.ImageIndex:=1;
        end
        else
        begin
          ListItem.Caption:=searchRec.Name;
          ListItem.ImageIndex:=0;
        end;
          ListItem.SubItems.Add(TrashCodesList.Strings[i]);
          if(TrashData.local=true) then
            ListItem.SubItems.Add(TrashData.path)
          else
            ListItem.SubItems.Add(TrashData.host+':'+IntToStr(TrashData.port)+TrashData.path);
        ListView1.Items.EndUpdate;
      end;
    end;
  end;

  TrashCodesList.Free;
end;

end.
