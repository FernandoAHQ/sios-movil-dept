import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sios_v1/models/authData.dart';
import 'package:sios_v1/models/service.dart';
import 'package:sios_v1/providers/providerServices.dart';
import 'package:sios_v1/providers/providerUserData.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

enum ServerStatus { Online, Offline, Connecting }

class ProviderSocket with ChangeNotifier {
  var _serverStatus = ServerStatus.Offline;
  late Socket socket;
  late AuthData user;
    String adminId = '621c19019cef936ea47c9645';


  void disconnectFromServer() {
    socket.disconnect();
  }

  Future connectToServer(BuildContext _context) async {
    user = _context.read<ProviderUserData>().data;

    String token = await _context.read<ProviderUserData>().getToken();

    print('TOKEN: $token');

    try {
      // Configure socket transports must be sepecified
      socket = IO.io(
          'https://sios-server.herokuapp.com/',
          IO.OptionBuilder()
              .setTransports(['websocket'])
              .enableForceNew()
              .disableAutoConnect()
              .setQuery({'accessToken': 'Bearer $token'})
              .build());

      // Connect to websocket
      socket.connect();

      // Handle socket events
      socket.onConnect((_) {
        _context.read<ProviderServices>().resetServices();
        print('connect: ${socket.id}');
        _serverStatus = ServerStatus.Online;
      });

      socket.onReconnectError((data) => print("RECONNECT ERROR"));
      socket.onReconnectFailed((data) => print("RECONNECT FAILED"));
      socket.on('event', (data) => null);

      socket.onDisconnect((_) {
        print('disconnect');
        _serverStatus = ServerStatus.Offline;
        if (_context.read<ProviderUserData>().data.isLogged()) {
          //   print(_context.read<ProviderUserData>().data.isLogged());
          // connectToServer(_context);
        }
      });

      socket.on('fromServer', (_) => print(_));
    } catch (e) {
      print(e.toString());
    }

    socket.on(
        "reports-list",
        (data) => handleReportList(
            _context, data)); //print("\n\n\n" + data[0]['title'].toString()));
  }

  // Send Location to Server
  sendLocation(Map<String, dynamic> data) {
    socket.emit("location", data);
  }

  // Listen to Location updates of connected usersfrom server
  handleReportList(BuildContext context, data) async {
    //print("HANDLE XD");
    //print(data[0].toString());
    if (data != null) {
      context.read<ProviderServices>().readServices(data);
    }
    notifyListeners();
  }

  // Send update of user's typing status
  sendTyping(bool typing) {
    socket.emit("typing", {
      "id": socket.id,
      "typing": typing,
    });
  }

  // Listen to update of typing status from connected users
  void handleTyping(Map<String, dynamic> data) {
    print(data);
  }

  // Send a Message to the server
  sendMessage(String message) {
    socket.emit(
      "message",
      {
        "id": socket.id,
        "message": message, // Message to be sent
        "timestamp": DateTime.now().millisecondsSinceEpoch,
      },
    );
  }

  void sendReport({
    required String title,
    required String description,
    required String category,
  }) {
    var report = {
      'to': '621c19019cef936ea47c9645',
      'from': user.user?.sId,
      'report': {
        'title': title,
        'description': description,
        'category': category
      }
    };
  
    socket.emit('depto-report', report);
    //    print(report);
  }

  void editReport({
    required String title,
    required String description,
    required String category,
    required String id
  }) {
    var report = {
      'to': adminId,
      'from': user.user?.sId,
      'report': {
        '_id' : id,
        'title': title,
        'description': description,
        'category': category
      }
    };

    socket.emit('edit-report', report);
    //    print(report);
  }

  // Listen to all message events from connected users
  void handleMessage(Map<String, dynamic> data) {
    print(data);
  }

  void rateService(Service service, String comment, int rating) {
    socket.emit('calificar-report',
      {
      'to': adminId,
      'from': user.user?.sId,
      'service': service.sId,
      'grade': {
        'score': rating,
        'comment': comment
              }
      });
  }
}
