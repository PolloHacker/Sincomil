import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class GradesDialog extends StatefulWidget {
  final String title;
  final List<double> notas;

  const GradesDialog({super.key, required this.title, required this.notas});

  @override
  State<GradesDialog> createState() => _GradesDialogState();
}

class _GradesDialogState extends State<GradesDialog> {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];
  List<double> toAvg = List.empty(growable: true);
  List<Widget> stats = List.empty(growable: true);

  double last = 0;
  double avg = 0;

  String betterment = 'down';
  bool showAvg = true;

  double media(List<double> data) {
    double media = 0;
    for (var i = 0; i < data.length; i++) {
      media += data[i];
    }

    media /= data.length;

    return media;
  }

  @override
  void initState() {
    getStats();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => Future.delayed(const Duration(seconds: 1), () {
          setState(() {
            showAvg = false;
          });
        }));
  }

  void getStats() {
    toAvg = List.of(widget.notas);
    toAvg.removeWhere((value) => value == -1);
    widget.notas.removeWhere((value) => value == -1);
    avg = media(toAvg);

    double before = 0;

    last = widget.notas.last;
    if (widget.notas.indexOf(last) > 0) {
      before = widget.notas[widget.notas.indexOf(last) - 1];
    } else {
      before = widget.notas[0];
    }
    if (last > before) {
      betterment = 'up';
    } else if (last == before) {
      betterment = 'no';
    } else {
      betterment = 'down';
    }

    stats = [
      Row(
        children: [
          const Spacer(),
          Icon(betterment == 'up'
              ? Icons.arrow_upward_rounded
              : betterment == 'down'
                  ? Icons.arrow_downward_rounded
                  : Icons.unfold_less_double_rounded),
          Text(
              "${betterment == 'up' ? ((last * 100) / before - 100).toStringAsPrecision(3) : ((before * 100) / last - 100).toStringAsPrecision(3)}%",
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
          const Spacer(),
        ],
      ),
      Text(betterment == 'up'
          ? "Melhora em relação à última prova"
          : betterment == 'down'
              ? "Decréscimo em relação à última prova"
              : "Estabilidade em relação à última prova")
    ];

    double passouAno = 60.0 - widget.notas.reduce((a, b) => a + b);

    stats.addAll([
      Row(
        children: [
          const Spacer(flex: 1),
          Column(children: [
            Text((widget.notas.length * 10).toString(),
                style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            const Padding(padding: EdgeInsets.all(5), child: Text("Pontos distribuidos"))
          ]),
          const Spacer(flex: 1),
          const Spacer(flex: 1),
          Column(
            children: [
              Text(widget.notas.reduce((a, b) => a + b).toString(),
                  style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
              const Padding(padding: EdgeInsets.all(5), child: Text("Pontos Obtidos"))
            ],
          ),
          const Spacer(flex: 1),
        ],
      ),
      Row(
        children: [
          const Spacer(),
          !passouAno.isNegative
              ? Text(passouAno.toStringAsPrecision(3),
                  style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold))
              : Container(),
          const Spacer()
        ],
      ),
      passouAno.isNegative
          ? const Text("Você passou de ano nesta disciplina",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
          : const Text("Pontos para passar de ano")
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          leading: IconButton(
            icon: const Icon(Icons.close_rounded),
            onPressed: () {
              Navigator.of(context).pop('Closed');
            },
          ),
        ),
        body: Material(
            elevation: 0,
            borderOnForeground: false,
            child: ListView(
              shrinkWrap: true,
              children: [
                AspectRatio(
                  aspectRatio: 1.70,
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(18)), color: Color(0xff232d37)),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(12, 24, 18, 12),
                      child: LineChart(
                        showAvg ? avgData(widget.notas, avg) : mainData(widget.notas),
                        swapAnimationDuration: const Duration(milliseconds: 250), // Optional
                        swapAnimationCurve: Curves.linear,
                      ),
                    ),
                  ),
                ),
                Card(
                  elevation: 3,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Sua média atual é ',
                            style: TextStyle(fontSize: 22),
                          ),
                          Text(avg.toStringAsPrecision(2),
                              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold))
                        ],
                      ),
                      infoGrades(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: stats,
                      )
                    ],
                  ),
                ),
              ],
            )));
  }

  Widget infoGrades() {
    return Row(
      children: [
        const Spacer(flex: 1),
        Column(children: [
          Text(widget.notas.reduce(min).toString(), style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
          const Padding(padding: EdgeInsets.all(5), child: Text("Pior Nota"))
        ]),
        const Spacer(flex: 1),
        const Spacer(flex: 1),
        Column(
          children: [
            Text(widget.notas.reduce(max).toString(),
                style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            const Padding(padding: EdgeInsets.all(5), child: Text("Melhor Nota"))
          ],
        ),
        const Spacer(flex: 1),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff68737d),
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    String text = '';
    switch (value.toInt()) {
      case 0:
        text = 'A1';
        break;
      case 1:
        text = 'A2';
        break;
      case 2:
        text = 'A3';
        break;
      case 3:
        text = 'A4';
        break;
      case 4:
        text = 'A5';
        break;
      case 5:
        text = 'A6';
        break;
      case 6:
        text = 'A7';
        break;
      case 7:
        text = 'A8';
        break;
      case 8:
        text = 'A9';
        break;
    }

    return SideTitleWidget(axisSide: meta.axisSide, child: Text(text, style: style));
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff67727d),
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = '0';
        break;
      case 2:
        text = '2';
        break;
      case 4:
        text = '4';
        break;
      case 6:
        text = '6';
        break;
      case 8:
        text = '8';
        break;
      case 10:
        text = '10';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData(List<double> data) {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 30,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 8,
      minY: 0,
      maxY: 10,
      lineBarsData: [
        LineChartBarData(
          spots: data.asMap().entries.map((e) => FlSpot(e.key.toDouble(), e.value)).toList(),
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors.map((color) => color.withOpacity(0.3)).toList(),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData avgData(List<double> data, double avg) {
    return LineChartData(
      lineTouchData: LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        verticalInterval: 1,
        horizontalInterval: 1,
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: bottomTitleWidgets,
            interval: 1,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 30,
            interval: 1,
          ),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 8,
      minY: 0,
      maxY: 10,
      lineBarsData: [
        LineChartBarData(
          spots: data.asMap().entries.map((e) => FlSpot(e.key.toDouble(), avg)).toList(),
          isCurved: true,
          gradient: LinearGradient(
            colors: [
              ColorTween(begin: gradientColors[0], end: gradientColors[1]).lerp(0.2)!,
              ColorTween(begin: gradientColors[0], end: gradientColors[1]).lerp(0.2)!,
            ],
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                ColorTween(begin: gradientColors[0], end: gradientColors[1]).lerp(0.2)!.withOpacity(0.1),
                ColorTween(begin: gradientColors[0], end: gradientColors[1]).lerp(0.2)!.withOpacity(0.1),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
