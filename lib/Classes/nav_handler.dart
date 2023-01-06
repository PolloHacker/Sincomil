import 'dart:convert';

import 'package:http/http.dart' as http;
import 'grades.dart';
import 'parent.dart';
import 'student.dart';

class NavHandler {
  const NavHandler();

  Future<List> check(String email, String pass) async {
    final msg = json.encode(<String, String>{'email': email, 'password': pass});
    http.Response result = await http.post(
        Uri.parse('http://192.168.0.2:8000/app/auth'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8'
        },
        body: msg);
    if (result.statusCode == 200) {
      var data = jsonDecode(result.body);
      var students = <Student>[];
      Parent parent;
      for (var i = 0; i < data['student'].length; i++) {
        students.add(Student.fromJson(data['student'][i]));
      }
      parent = Parent.fromJson(data['parent'][0]);
      return [parent, students];
    } else {
      throw Exception('Email ou senha inválidos.');
    }
  }

  Future<List<String>> getPic(List<String> nomes, List<int> numeros) async {
    final paths = <String>[];
    String nome;
    int numero;
    for (int i = 0; i < nomes.length; i++) {
      nome = nomes[i];
      numero = numeros[i];
      final msg = json
          .encode(<String, String>{"name": nome, "numero": numero.toString()});
      http.Response result = await http.post(
        Uri.parse('http://192.168.0.2:8000/app/fotos'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8'
        },
        body: msg,
      );
      if (result.statusCode == 200) {
        var path = jsonDecode(result.body);
        paths.add(path['path']);
      } else {
        throw Exception('Failed to load pic');
      }
    }
    return paths;
  }

  Future<List<String>> getPickBG(List<String> nomes, List<int> numeros) async {
    final paths = <String>[];
    String nome;
    int numero;
    for (int i = 0; i < nomes.length; i++) {
      nome = nomes[i];
      numero = numeros[i];
      final msg = json
          .encode(<String, String>{"name": nome, "numero": numero.toString()});
      http.Response result = await http.post(
        Uri.parse('http://192.168.0.2:8000/app/fotosBG'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8'
        },
        body: msg,
      );
      if (result.statusCode == 200) {
        var path = jsonDecode(result.body);
        paths.add(path['path']);
      } else {
        throw Exception('Failed to load pic');
      }
    }
    return paths;
  }

  Future<List<Grades>> getGrades(List<String> nomes) async {
    final grades = <Grades>[];
    for (String nome in nomes) {
      final msg = json.encode(<String, String>{"name": nome});
      http.Response result = await http.post(
          Uri.parse('http://192.168.0.2:8000/app/grades'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=utf-8'
          },
          body: msg);
      if (result.statusCode == 200) {
        var data = jsonDecode(result.body);
        grades.add(Grades.fromJson(data['grades'][0]));
      } else {
        throw Exception('Nome inválido');
      }
    }
    return grades;
  }

  Future<bool> recoverPass(String cpf, String nascimento) async {
    final msg = json.encode(<String, String>{
      'cpf': cpf,
      'nascimento': nascimento,
    });
    http.Response result = await http.post(
        Uri.parse('http://192.168.0.2:8000/app/pwd'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8'
        },
        body: msg);
    if (result.statusCode == 200) {
      var resp = jsonDecode(result.body);
      return resp['result'];
    } else {
      throw Exception('Email ou cpf inválidos.');
    }
  }

  Future<bool> register(
      String email, String cpf, String nascimento, String colegio) async {
    final msg = json.encode(<String, String>{
      'email': email,
      'cpf': cpf,
      'nascimento': nascimento,
      'colegio': colegio
    });
    http.Response result = await http.post(
        Uri.parse('http://192.168.0.2:8000/app/register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8'
        },
        body: msg);
    if (result.statusCode == 200) {
      var resp = jsonDecode(result.body);
      return resp['result'];
    } else {
      throw Exception('Email ou cpf inválidos.');
    }
  }
}
