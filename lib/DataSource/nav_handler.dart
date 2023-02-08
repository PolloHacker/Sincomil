import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sincomil/Classes/Parent/payments.dart';
import 'package:sincomil/Classes/Student/subject.dart';
import 'package:sincomil/Constants/constants.dart';
import '../Classes/Student/grades.dart';
import '../Classes/Parent/parent.dart';
import '../Classes/Student/student.dart';

class NavHandler {
  const NavHandler();

  Future<List> check(String email, String pass) async {
    final msg = json.encode(<String, String>{'email': email, 'password': pass});
    http.Response result = await http.post(Uri.parse(Urls.auth),
        headers: <String, String>{'Content-Type': 'application/json; charset=utf-8'}, body: msg);
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

  Future<List<Payments>> getPayments(int id) async {
    final msg = json.encode(<String, int>{'id': id});
    http.Response result = await http.post(Uri.parse(Urls.payments),
        headers: <String, String>{'Content-Type': 'application/json; charset=utf-8'}, body: msg);
    if (result.statusCode == 200) {
      var data = jsonDecode(result.body);
      var payments = <Payments>[];
      for (var i = 0; i < data['payments'].length; i++) {
        payments.add(Payments.fromJson(data['payments'][i]));
      }
      return payments;
    } else {
      throw Exception('id inválido.');
    }
  }

  Future<List<String>> getPic(List<String> nomes, List<int> numeros) async {
    final paths = <String>[];
    String nome;
    int numero;
    for (int i = 0; i < nomes.length; i++) {
      nome = nomes[i];
      numero = numeros[i];
      final msg = json.encode(<String, String>{"name": nome, "numero": numero.toString()});
      http.Response result = await http.post(
        Uri.parse(Urls.fotos),
        headers: <String, String>{'Content-Type': 'application/json; charset=utf-8'},
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
      final msg = json.encode(<String, String>{"name": nome, "numero": numero.toString()});
      http.Response result = await http.post(
        Uri.parse(Urls.fotosBG),
        headers: <String, String>{'Content-Type': 'application/json; charset=utf-8'},
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
      http.Response result = await http.post(Uri.parse(Urls.grades),
          headers: <String, String>{'Content-Type': 'application/json; charset=utf-8'}, body: msg);
      if (result.statusCode == 200) {
        var data = jsonDecode(result.body);
        var artes = await getSubject(data['grades'][0]['artes_id']);
        var bio = await getSubject(data['grades'][0]['bio_id']);
        var ef = await getSubject(data['grades'][0]['ef_id']);
        var filo = await getSubject(data['grades'][0]['filo_id']);
        var fis = await getSubject(data['grades'][0]['fis_id']);
        var geo = await getSubject(data['grades'][0]['geo_id']);
        var hist = await getSubject(data['grades'][0]['hist_id']);
        var lem = await getSubject(data['grades'][0]['lem_id']);
        var port = await getSubject(data['grades'][0]['port_id']);
        var mat = await getSubject(data['grades'][0]['mat_id']);
        var quim = await getSubject(data['grades'][0]['quim_id']);
        var red = await getSubject(data['grades'][0]['red_id']);
        var socio = await getSubject(data['grades'][0]['socio_id']);
        grades.add(Grades(
            id: data['grades'][0]['id'],
            nome: data['grades'][0]['nome'],
            artes: artes,
            bio: bio,
            ef: ef,
            filo: filo,
            fis: fis,
            geo: geo,
            hist: hist,
            lem: lem,
            port: port,
            mat: mat,
            quim: quim,
            red: red,
            socio: socio));
      } else {
        throw Exception('nome inválido');
      }
    }
    return grades;
  }

  Future<Subject> getSubject(int id) async {
    final Subject subjects;

    final msg = json.encode(<String, int>{"id": id});
    http.Response result = await http.post(Uri.parse(Urls.subject),
        headers: <String, String>{'Content-Type': 'application/json; charset=utf-8'}, body: msg);
    if (result.statusCode == 200) {
      var data = jsonDecode(result.body);
      data['subject'][0]['grades'].toString().split(' ').forEach((element)  {
        if (data['subject'][0]['grades'] is String) {
          data['subject'][0]['grades'] = <double>[];
        }
        data['subject'][0]['grades'].add(double.parse(element));
      });
      subjects = Subject.fromJson(data['subject'][0]);
    } else {
      throw Exception('id inválido');
    }

    return subjects;
  }

  Future<bool> recoverPass(String cpf, String nascimento) async {
    final msg = json.encode(<String, String>{
      'cpf': cpf,
      'nascimento': nascimento,
    });
    http.Response result = await http.post(Uri.parse(Urls.password),
        headers: <String, String>{'Content-Type': 'application/json; charset=utf-8'}, body: msg);
    if (result.statusCode == 200) {
      var resp = jsonDecode(result.body);
      return resp['result'];
    } else {
      throw Exception('Email ou cpf inválidos.');
    }
  }

  Future<bool> register(String email, String cpf, String nascimento, String colegio) async {
    final msg = json.encode(<String, String>{'email': email, 'cpf': cpf, 'nascimento': nascimento, 'colegio': colegio});
    http.Response result = await http.post(Uri.parse(Urls.register),
        headers: <String, String>{'Content-Type': 'application/json; charset=utf-8'}, body: msg);
    if (result.statusCode == 200) {
      var resp = jsonDecode(result.body);
      return resp['result'];
    } else {
      throw Exception('Email ou cpf inválidos.');
    }
  }
}
