import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'Student.dart';

class NavHandler {
  const NavHandler();

  Future<List<Student>> check(BuildContext context, String email, String pass) async {
    final msg = json.encode(<String, String>{
      'email': email,
      'password': pass,
    });
    http.Response result = await http.post(
      Uri.parse('http://192.168.0.2:8000/app/auth'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8'
      },
      body: msg,
    );
    if (result.statusCode == 200) {
      var data = jsonDecode(result.body);
      print(data);
      var students = <Student>[];
      for (var i = 0; i < data['student'].length; i++) {
        print(data['student'][i]);
        students.add(Student.fromJson(data['student'][i]));
      }
      return students;
    } else {
      throw Exception('Failed to load student');
    }
  }
  Future<String> getPic(BuildContext context, String nome, int numero) async {
    final msg = json.encode(<String, String>{
      "name": nome,
      "numero": numero.toString()
    });
    http.Response result = await http.post(
      Uri.parse('http://192.168.0.2:8000/app/fotos'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8'
      },
      body: msg,
    );
    if (result.statusCode == 200) {
      var path = jsonDecode(result.body);
      print(path);
      return path['path'];
    } else {
      throw Exception('Failed to load pic');
    }
  }
}