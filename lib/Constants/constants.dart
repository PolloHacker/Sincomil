import 'package:flutter/material.dart';
import 'package:sincomil/Classes/Student/portrait.dart';

const buttonColor = Color.fromRGBO(31, 117, 42, 1.0);
const whitePrimary = Color.fromRGBO(255, 255, 255, 1.0);
const whiteSecondary = Color.fromRGBO(199, 198, 198, 1.0);
const navigationBarBG = Color.fromRGBO(31, 117, 42, 1.0);

class Urls {
  //TODO: change url to website
  static const String baseUrl = 'http://192.168.0.2:8000/app';
  static const String auth = '$baseUrl/auth';
  static const String payments = '$baseUrl/payments';
  static const String fotos = '$baseUrl/fotos';
  static const String fotosBG = '$baseUrl/fotosBG';
  static const String grades = '$baseUrl/grades';
  static const String subject = '$baseUrl/subject';
  static const String password = '$baseUrl/password';
  static const String register = '$baseUrl/register';
}


const cartas = <String, Color>{
  //TOP SYS ano
  'toty': Color.fromRGBO(239, 215, 117, 1.0),
  'toty2': Color.fromRGBO(239, 215, 117, 1),
  //TOP série ano
  'tots': Color.fromRGBO(255, 238, 144, 1),
  'tots2': Color.fromRGBO(255, 238, 144, 1),
  //Medalha garança
  'headliners': Color.fromRGBO(255, 216, 0, 1),
  //Alamar
  'flashback': Color.fromRGBO(255, 255, 255, 1),
  //Atleta
  'shapeshifter': Color.fromRGBO(255, 255, 255, 1),
  //Destaque
  'motm': Color.fromRGBO(255, 255, 255, 1),
  //TOP trim
  'fire': Color.fromRGBO(255, 255, 255, 1),
  'ice': Color.fromRGBO(255, 255, 255, 1),
  //2 Notas consecutivas
  'goldif': Color.fromRGBO(255, 226, 140, 1),
  'silverif': Color.fromRGBO(242, 242, 243, 1),
  'bronzeif': Color.fromRGBO(221, 174, 130, 1),
  //Notas padrão
  'gold': Color.fromRGBO(70, 57, 12, 1),
  'silver': Color.fromRGBO(38, 41, 42, 1),
  'bronze': Color.fromRGBO(58, 39, 23, 1),
  'goldcommon': Color.fromRGBO(68, 58, 34, 1),
  'silvercommon': Color.fromRGBO(38, 41, 42, 1),
  'bronzecommon': Color.fromRGBO(43, 34, 23, 1),
};

final List<Portrait> allCards = [
  Portrait(name: 'bronzecommon', description: 'Esta é a carta padrão'),
  Portrait(name: 'bronze', description: 'Esta carta é concedida aos alunos com pontuação maior do que 60'),
  Portrait(name: 'silvercommon', description: 'Esta carta é concedida aos alunos com pontuação maior do que 70'),
  Portrait(name: 'silver', description: 'Esta carta é concedida aos alunos com pontuação maior do que 75'),
  Portrait(name: 'goldcommon', description: 'Esta carta é concedida aos alunos com pontuação maior do que 80'),
  Portrait(name: 'gold', description: 'Esta carta é concedida aos alunos com pontuação maior do que 85'),
  Portrait(
      name: 'bronzeif',
      description: 'Esta carta é concedida aos alunos que conseguiram 2 notas consecutivas maiores ou iguais a 7'),
  Portrait(
      name: 'silverif',
      description: 'Esta carta é concedida aos alunos que conseguiram 2 notas consecutivas maiores ou iguais a 8'),
  Portrait(
      name: 'goldif',
      description: 'Esta carta é concedida aos alunos que conseguiram 2 notas consecutivas maiores ou iguais a 9'),
  Portrait(
      name: 'headliners', description: 'Esta carta é concedida aos alunos que foram agraciados com a medalha garança'),
  Portrait(name: 'shapeshifter', description: 'Esta carta é concedida a todos os atletas.'),
  Portrait(
      name: 'flashback', description: 'Esta carta é concedida aos alunos que obtiveram o alamar ao fim do trimestre'),
  Portrait(name: 'motm', description: 'Esta carta é concedida aos alunos de destaque'),
  Portrait(
      name: 'ice',
      description:
          'Esta carta é concedida aos alunos que ficaram entre as 10 melhores médias de sua série no trimestre'),
  Portrait(
      name: 'fire',
      description:
          'Esta carta é concedida aos alunos que ficaram entre as 3 melhores médias de sua série no trimestre'),
  Portrait(
      name: 'tots2',
      description:
          'Esta carta é concedida aos alunos que ficaram entre as 10 melhores médias de sua série no colégio no ano'),
  Portrait(
      name: 'toty2',
      description:
          'Esta carta é concedida aos alunos que ficaram entre as 10 melhores médias de sua série no SCMB no ano'),
  Portrait(
      name: 'tots',
      description:
          'Esta carta é concedida aos alunos que ficaram entre as 3 melhores médias de sua série no colégio no ano'),
  Portrait(
      name: 'toty',
      description:
          'Esta carta é concedida aos alunos que ficaram entre as 3 melhores médias de sua série no SCMB no ano'),
];

final List<String> titulos = [
  'Aluno',
  'Mensalidade',
  'Vencimento',
  'Tipo',
  'Valor',
  'Desconto',
  'Data de pagamento',
  'Valor pago',
  'Tipo de pagamento',
];

final List<String> tipoMens = ['Selecione', 'QME', 'APM'];

final List<String> situacaoPagamento = ['Todos', 'Pago', 'Atrasado', 'Por pagar'];