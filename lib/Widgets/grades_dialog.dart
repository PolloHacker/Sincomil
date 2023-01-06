import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../Constants/constants.dart';

class GradesDialog extends StatefulWidget {
  final Future<List<List<double>>> organizeGrades;
  final String title;
  final int index;

  const GradesDialog(
      {super.key,
      required this.organizeGrades,
      required this.title,
      required this.index});

  @override
  State<GradesDialog> createState() =>
      _GradesDialogState(organizeGrades, title, index);
}

class _GradesDialogState extends State<GradesDialog> {
  final Future<List<List<double>>> organizeGrades;
  final String title;
  final int index;

  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  bool showAvg = true;

  _GradesDialogState(this.organizeGrades, this.title, this.index);

  double media(List<List<double>> data) {
    double media = 0;
    for (var i = 0; i < data[index].length; i++) {
      media += data[index][i];
    }

    media /= data[index].length;

    return media;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () {
            Navigator.of(context).pop('Closed');
          },
        ),
      ),
      body: FutureBuilder(
          future: organizeGrades,
          builder: (context, AsyncSnapshot<List<List<double>>> data) {
            if (data.hasData) {
              double avg = media(data.data!);
              Future.delayed(const Duration(seconds: 1), () {
                if (!mounted) return;
                setState(() {
                  showAvg = false;
                });
              });
              return Material(
                  elevation: 0,
                  borderOnForeground: false,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      const Text(
                        'Sua média atual é ',
                        style: TextStyle(fontSize: 22),
                      ),
                      Text(avg.toStringAsPrecision(2),
                          style: const TextStyle(
                              fontSize: 32, fontWeight: FontWeight.bold))
                        ],
                      ),
                      AspectRatio(
                        aspectRatio: 1.70,
                        child: DecoratedBox(
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(18)),
                              color: Color(0xff232d37)),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(12, 24, 18, 12),
                            child: LineChart(
                              showAvg
                                  ? avgData(data.data!, avg)
                                  : mainData(data.data!),
                              swapAnimationDuration:
                                  const Duration(milliseconds: 250), // Optional
                              swapAnimationCurve: Curves.linear,
                            ),
                          ),
                        ),
                      ),

                    ],
                  ));
            } else {
              return const Material(
                elevation: 0,
                borderOnForeground: false,
                child: Center(child: CircularProgressIndicator(color: buttonColor)),
              );
            }
          }),
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

    return SideTitleWidget(
        axisSide: meta.axisSide, child: Text(text, style: style));
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

  LineChartData mainData(List<List<double>> data) {
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
          spots: data[index]
              .asMap()
              .entries
              .map((e) => FlSpot(e.key.toDouble(), e.value))
              .toList(),
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
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData avgData(List<List<double>> data, double avg) {
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
          spots: [
            FlSpot(0, avg),
            FlSpot(1, avg),
            FlSpot(2, avg),
            FlSpot(3, avg),
            FlSpot(4, avg),
            FlSpot(5, avg),
            FlSpot(6, avg),
            FlSpot(7, avg),
            FlSpot(8, avg),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: [
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
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
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
