import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../env.dart';

class HTTPService {
  // final String urlBase = 'https://arsic.tectoucan.com/api';

  Future<Response> getCategories() async {
    return await http.get(Uri.parse('$urlBase/api/reports/categories'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
  }

  Future<Response> getHistory(String id) async {
    print('$urlBase/api/services/history/depto/$id');
    return await http.get(Uri.parse('$urlBase/api/services/history/depto/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
  }

  Future<Response> sendAuthData(String usr, String pass) async {
    return await http.post(
      Uri.parse('$urlBase/api/auth/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': usr,
        'password': pass,
      }),
    );
  }

  Future<Response> sendToken(String token) async {
    print(token);
    return await http.get(
      Uri.parse('$urlBase/auth/renew'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
  }
}
