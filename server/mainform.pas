unit mainform;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, Sockets, StdCtrls;

type
  TFrmMain = class(TForm)
    btn1: TButton;
    btn2: TButton;
    mmo1: TMemo;
    btn3: TButton;
    TcpServer1: TTcpServer;


    procedure btn1Click(Sender: TObject);

    procedure btn2Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TcpServer1Accept(Sender: TObject;
  ClientSocket: TCustomIpClient);
    procedure TcpServer1CreateHandle(Sender: TObject);
    procedure TcpServer1DestroyHandle(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;



var
  FrmMain: TFrmMain;


implementation

const DEFAULT_PORT = 2501;

{$R *.dfm}




procedure TFrmMain.btn1Click(Sender: TObject);
begin
  TcpServer1.Active := true;
end;


procedure TFrmMain.btn2Click(Sender: TObject);
begin
  TcpServer1.Active := False;
end;

procedure TFrmMain.btn3Click(Sender: TObject);
begin
  mmo1.Lines.Clear;
end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  mmo1.Lines.Clear;

  TcpServer1 := TTcpServer.Create(Self);
  TcpServer1.OnAccept := TCpServer1Accept;
  TcpServer1.OnCreateHandle := TcpServer1CreateHandle;
  TcpServer1.OnDestroyHandle := TcpServer1DestroyHandle;
  TcpServer1.LocalPort := IntToStr(DEFAULT_PORT);
end;

procedure TFrmMain.TcpServer1Accept(Sender: TObject;
  ClientSocket: TCustomIpClient);
var
  a : array[0..9] of byte;
  I : Cardinal;
begin

  ClientSocket.ReceiveBuf(a,10,0);
  mmo1.Lines.Add(DateTimeToStr(now) + ' Data added with ' +
                  IntToStr(a[9]));
  for I := 0 to 8 do
  begin
    mmo1.Lines.Add(IntToStr(a[I] + a[9]));
  end;
  mmo1.Lines.Add('--------------------');

end;

procedure TFrmMain.TcpServer1CreateHandle(Sender: TObject);
begin
  mmo1.Lines.Add(DateTimeToStr(now) + ' Server started.');
end;

procedure TFrmMain.TcpServer1DestroyHandle(Sender: TObject);
begin
  if Self.mmo1 <> nil then
    mmo1.Lines.Add(DateTimeToStr(now) + ' Server stopped.');
end;

end.
