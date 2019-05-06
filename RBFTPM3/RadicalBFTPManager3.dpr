{
Author: Urban Kravos - RadicalB
Project started: December 2010
}

program RadicalBFTPManager3;

{$R *.res}



uses
  Forms,
  GlavnoOkno in 'GlavnoOkno.pas' {FormGlavnoOkno},
  OdpriDatoteko in 'OdpriDatoteko.pas',
  GetNit in 'GetNit.pas',
  PutThread in 'PutThread.pas',
  S2SThread in 'S2SThread.pas',
  ToBinThread in 'ToBinThread.pas',
  RecycleBin in 'RecycleBin.pas' {FormRecycleBin},
  FromBinThread in 'FromBinThread.pas';

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'RB TheFTP';
  Application.CreateForm(TFormGlavnoOkno, FormGlavnoOkno);
  Application.CreateForm(TFormRecycleBin, FormRecycleBin);
  Application.Run;
end.
