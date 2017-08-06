# delphi-socket-examples
delphi socket examples

Tcpserver 组件属性
 LocalHostAddr  获取本地机 IP;
 localport      获取本地端口;
 LocalHostName  本地计算机名称;
 BlockMode 属性, 可以设定 TTCPServer 为 bmBlocking\bmNonBlocking\bmThreadBlocking 这三种通讯模式;   
    
   bmBlocking       为阻塞模式, 以同步的方式进行数据传输,   
   bmNonBlocking    非阻塞模式, 以异步的方式进行数据传输,   
   bmThreadBlocking 线程异步模式, 创建一个子线程与 TcpClient 进行通讯, 在线程中以同步的方式传输数    据;

   如果是 bmBlocking 模式, 可以 OnAccept 事件中编写代码     
   procedure   TForm1.TcpServer1Accept(Sender:   TObject;  ClientSocket:   TCustomIpClient);   
         // 接收 tcpclient 的数据   
         ClientSocket.ReceiveFrom()   
          ClientSocket.ReceiveBuf()   
    
        // 向 tcpclient 发送数据   
        ClientSocket.SendBuf()   
        ClientSocket.SendTo()   
    
 如果是 bmThreadBlocking 模式, 可以 OnGetThread 事件中编写代码     
   procedure   TForm1.TcpServer1GetThread(Sender: TObject; var ClientSocketThread: TClientSocketThread);   
    begin   
         ClientSocketThread.ClientSocket.     
        // 接收 tcpclient 的数据   
         ClientSocketThread.ClientSocket.ReceiveFrom()   
         ClientSocketThread.ClientSocket.ReceiveBuf()   
    
         // 向 tcpclient 发送数据   
          ClientSocketThread.ClientSocket.SendBuf()   
          ClientSocketThread.ClientSocket.SendTo()   
 Listening    返回布尔值, 是否正在侦听
 LookupHostName  指定参数 IP 可以获取其主机名;

D7-->TCPserver 通信方法
1、指定其 Localport 属性为大于 1024 值的整型值，目的是指定 TCPsever1 的监听端口；
2、设定其通信方式：Blockmode；
3、打开 TCPsever1 监听客户端连接请求，TCPsever1.active:=true；
4、在 TCPserver1.OnAccept 事件中写读写客户端代码；Receivebuf(char 数组，长度),Sendbuf(char 数组，长度) 读写客户端连接；

var buff:array[0..255]of char;
      tmpbuf:string;
  begin
    Clientsocket.OnReceive:=onbuff;// 自定义 Onbuff 显示接收到数据
    while ClientSocket.Connected  do
    begin
        if ClientSocket.WaitForData(50)then// 保证无阻塞的读数据；
        ClientSocket.receivebuf(buff[0],sizeof(buff)); // 必须有这外判定不然发不出数据

        if outbuf<>'' then   //outbuf 为全局变量用于接收 Form 中的 Memo 值；
        begin
        tmpbuf:=outbuf;
        outbuf:='';
        ClientSocket.SendBuf(pchar(tmpbuf)^,length(tmpbuf));
    end;

// 将接收到的数据显示到 Memo
procedure Tform1.onbuff(Sender: TObject; Buf: pchar; var DataLen: Integer);
var buff:pchar;
    st:string;
    I:integer;
begin
  st:='';
  buff:=buf;
  for i:=0  to datalen do
  begin
  st:=st+ buff^;
  inc(buff);
  end;
  self.memo1.Lines.Add(st) ;
end;


## 客户端

D7-->internet-->TcpClient 的使用方法
1、设定它的 Blockmode TCP 通信方式；
                       RmoteHost  远端服务器 IP 或名称；
     RmotePort   指定其端口；
2、TcpClient.active:=true;  激活 SOCKET，向服务器发出连接请求；
3、连接成功后，通过 TcpClient 的 ReceiveBuf 方法接收 --->server 的数据；
     如果是实时接收可以通过 Timer 中写以下代码实现；
 var
   Buf: array[0..2048] of char;// 将数据暂存到这里；
 begin
   if TCPClient1.Connected and TCPClient1.WaitForData(50)
      then
        begin
          TCPClient1.ReceiveBuf(buf, sizeof(buf));
        end;
                end;
      其中，WaitFData() 作用测试 socket 是否准备好读了，WaitForData(50)=False 说明延时 50 毫秒后还未准备就绪；
4、因为调用 ReceiveBuf 就有 OnReceive 事件产生, 所以，可以在 Tcpclient1.onreceive 事件中写数据处理代码；
   如将接收到的数据显示到 Memo 中；
  var
  Astr: string;
  Achar: Pchar;
  index: integer;
     begin
   Astr := '';
   Achar := buf;
   for index := 1 to datalen do
     begin
       Astr := Astr + char(Achar^);
       INC(Achar);
     end;
  self.memo1.lines.add(Astr);
5、向 -->Sever 发送数据使用 SendBuf 函数，在确保连接的状态下；
     TcpClient1.SendBuf(pchar(self.SendData.text)^, length(senddata.text), 0);



## code

unit ClientMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, Sockets;

type
  TForm1 = class(TForm)
    Client: TTcpClient;
    btnConnect: TButton;
    btnSend: TButton;
    edText: TEdit;
    Label3: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure btnSendClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnConnectClick(Sender: TObject);
begin
  Client.Disconnect;
  Client.RemoteHost := '127.0.0.1';
  Client.RemotePort := '2609';
  Client.Connect;
  if Client.Connected then
    Form1.Caption := 'Client Connected';
end;

procedure TForm1.btnSendClick(Sender: TObject);
begin
  if Client.Connected then
    Client.SendLn( 'abcdefghijklmnop' );
end;

end.

This is the code for Server
CODE
unit ServerMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Sockets;

type
  TForm1 = class(TForm)
    Server: TTcpServer;
    btnConnect: TButton;
    log: TMemo;
    procedure btnConnectClick(Sender: TObject);
    procedure ServerAccept(Sender: TObject; ClientSocket: TCustomIpClient);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnConnectClick(Sender: TObject);
begin
  Server.Active := false;
  Server.LocalHost := '127.0.0.1';
  Server.LocalPort := '2609';
  Server.Active := true;
  if Server.Active then
    Form1.Caption := 'Server Connected';
end;

procedure TForm1.ServerAccept(Sender: TObject;
  ClientSocket: TCustomIpClient);
var
  s: string;
begin
//  log.Lines.Append( ClientSocket.LookupHostName( ClientSocket.RemoteHost ) );
  s := ClientSocket.ReceiveLn;
  while s <> '' do begin
    log.Lines.Append( s );
    s := ClientSocket.ReceiveLn;
  end;
end;

end.