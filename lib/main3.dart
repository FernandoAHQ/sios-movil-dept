import 'package:socket_io_client/socket_io_client.dart' as IO;

main() {

  String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYyMGE4MDNkOWEyYzlmZjc1MmJjMDE3NCIsInJvbGUiOiJBRE1JTl9ST0xFIiwiaWF0IjoxNjQ2ODU4ODY4LCJleHAiOjE2NDY5NDUyNjh9.1DqMPvf9ffmzhx2h5dCNvb8X6ipbyiUM-oYVsWMXM1E";
  print(token);
  // Dart client
  IO.Socket socket = IO.io('https://sios-server.herokuapp.com/',

      IO.OptionBuilder()
        .setTransports(['websocket'])
        .enableForceNew()
        .setQuery({
          'accessToken': 'Bearer $token'
        })
        .build()
    
    );
  socket.onConnect((_) {
    print('connect');
    socket.emit('msg', 'test');
  });

socket.onConnectTimeout((_) {
    print('TIME OUT');
    socket.emit('msg', 'test');
  });

  socket.on('event', (data) => print(data));
  socket.onDisconnect((_) => print('disconnect'));
  socket.on('fromServer', (_) => print(_));

  socket.connect();
}