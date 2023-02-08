class PaymentsEntity {
  final int id;
  final String aluno;
  final String mensalidade;
  final String vencimento;
  final String tipo;
  final String valor;
  final String desconto;
  final String dtPagamento;
  final String valorPg;
  final String tipoPg;

  PaymentsEntity(
      {required this.id,
      required this.aluno,
      required this.mensalidade,
      required this.vencimento,
      required this.tipo,
      required this.valor,
      required this.desconto,
      required this.dtPagamento,
      required this.valorPg,
      required this.tipoPg});

  factory PaymentsEntity.fromJson(Map<String, dynamic> json) {
    return PaymentsEntity(
        id: json['id'],
        aluno: json['aluno'],
        mensalidade: json['mensalidade'],
        vencimento: json['vencimento'],
        tipo: json['tipo'],
        valor: json['valor'],
        desconto: json['desconto'],
        dtPagamento: json['dtPagamento'],
        valorPg: json['valorPg'],
        tipoPg: json['tipoPg']);
  }

  Map<int, String> asMap() {
    return {
      0: aluno,
      1: mensalidade,
      2: vencimento,
      3: tipo,
      4: valor,
      5: desconto,
      6: dtPagamento,
      7: valorPg,
      8: tipoPg
    };
  }
}
