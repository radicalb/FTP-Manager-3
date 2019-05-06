unit OdpriDatoteko;

interface

uses
  Classes, ShellApi, IdFTP, Dialogs; //Odstrani dialogs

type
  TOdpriDatotekoNit = class(TThread)
  private
    { Private declarations }
  protected
    procedure Execute; override;
  public
    constructor Create(YourFTPClient:TIdFTP; ASource,ADest:String);
  end;

var
  IdFTPx:TIdFTP;
  xSource,xDest:String;

implementation

uses GlavnoOkno;

{ Important: Methods and properties of objects in visual components can only be
  used in a method called using Synchronize, for example,

      Synchronize(UpdateCaption);

  and UpdateCaption could look like,

    procedure OdpriDatotekoNit.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end; }

{ OdpriDatotekoNit }

constructor TOdpriDatotekoNit.Create(YourFTPClient:TIdFTP; ASource,ADest:String);
begin
  xSource:=ASource;
  xDest:=ADest;
  IdFTPx:=YourFTPClient;
  self.FreeOnTerminate:= true;
  inherited Create(False);
end;

procedure TOdpriDatotekoNit.Execute;
begin
  IdFTPx.Get(xSource,xDest,true,true);
  FormGlavnoOkno.AfterOdpriDatotekoNit(xDest,IdFTPx);
  Terminate;
  { Place thread code here }
end;

end.
