import 'dart:async';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:sios_v1/models/authData.dart';
import 'package:sios_v1/services/httpService.dart';

class ProviderUserData with ChangeNotifier {
  String accessToken = "";

  final storage = const FlutterSecureStorage();

  late AuthData data;
  bool isLoading = false;


  void setLoading(bool l) {
    isLoading = l;
  }

  Future logout() async {
    await storage.write(key: "_token", value: null);
    data = AuthData.reset();
    print(data.user);
  }

//AUTHENTICATE WITH TOKEN
  Future<String> getToken() async {
    //   print(accessToken);
    String tk;

    if (await storage.read(key: "_token") == null) {
      tk = "";
    } else {
      tk = (await storage.read(key: "_token")) as String;
    }
    return tk;
  }

  Future<bool> authToken() async {
    if (await storage.read(key: "_token") == null) {
      return false;
    } else {
      accessToken = (await storage.read(key: "_token")) as String;
    }

    notifyListeners();

    try {
      final response = await HTTPService().sendToken(accessToken);

      if (response.statusCode == 200) {
        final Map parsedData = jsonDecode(response.body);

        await storage.write(key: "_token", value: parsedData["accessToken"]);
        data = AuthData.fromJson(parsedData);

        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

//AUTHENTICATE WITH PASSWORD
  Future<bool> authUser(String username, String password) async {
    isLoading = true;
    notifyListeners();
    final response;
    try {
      response = await HTTPService().sendAuthData(username, password);

      print(response.statusCode);

      isLoading = false;
      notifyListeners();
      if (response.statusCode == 200) {
        final Map parsedData = jsonDecode(response.body);
        print("RECIEVED RESPOSE");

        await storage.write(key: "_token", value: parsedData["accessToken"]);
        print(await storage.read(key: "_token"));
        data = AuthData.fromJson(
            parsedData); //(response.body as Map<String, dynamic>);
        if (data.status == true) {
          print("USER AUTHENTICATED");
          data.setLogged(true);
          return true;
        } else {
          print("USER NOT AUTHENTICATED");
          data.setLogged(false);
          isLoading = false;
          notifyListeners();
          return false;
        }
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      print(e);
    }
    return false;
  }
}
