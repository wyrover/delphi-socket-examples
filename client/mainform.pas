unit mainform;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Sockets;

type
  TForm1 = class(TForm)
    btn1: TButton;
    TcpClient1: TTcpClient;
    Edit1: TEdit;
    Memo1: TMemo;
    procedure btn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TcpClient1Send(Sender: TObject; Buf: PWideChar;
      var DataLen: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

const DEFAULT_PORT = 2501;


{$R *.dfm}

procedure TForm1.btn1Click(Sender: TObject);
var
  myStream : TMemoryStream;
  I : Cardinal;
  userValue : Integer;
begin
  //creating a stream
  myStream := TMemoryStream.Create();
  for I := 0 to 8 do
  begin
    myStream.WriteBuffer(I,1);
  end;
  userValue := StrToIntDef(Edit1.Text, 0);
  myStream.WriteBuffer(userValue,1);

  //resetting the stream position
  myStream.Seek(0,0);

  //sending the stream
  TcpClient1.Active := true;
  TcpClient1.SendStream(myStream);
  TcpClient1.Active := false;

  //free the stream
  myStream.Free;

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Edit1.Text := '0';
  Memo1.Lines.Clear;

  TcpClient1.RemotePort := IntToStr(DEFAULT_PORT);
  TcpClient1.RemoteHost := 'localhost';
  TcpClient1.Active := true;
end;

procedure TForm1.TcpClient1Send(Sender: TObject; Buf: PWideChar;
  var DataLen: Integer);
begin
  Memo1.Lines.Add(DateTimeToStr(now) + ' Sent data with ' + Edit1.Text);
end;

end.
