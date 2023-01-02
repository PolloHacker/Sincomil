import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class GradesDialog extends StatefulWidget {
  final Future<List<List<double>>> organizeGrades;
  final String title;
  final int index;

  const GradesDialog({super.key, required this.organizeGrades, required this.title, required this.index});

  @override
  State<StatefulWidget> createState() => _GradesDialogState(this.organizeGrades, this.title, this.index);
}

class _GradesDialogState extends State<GradesDialog> {
  final Future<List<List<double>>> organizeGrades;
  final String title;
  final int index;

  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  bool showAvg = false;

  _GradesDialogState(this.organizeGrades, this.title, this.index);

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
        body: Stack(
          children: [
            AspectRatio(
                  aspectRatio: 1.70,
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(18)), color: Color(0xff232d37)),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(12, 24, 18, 12),
                      child: FutureBuilder(
                        future: organizeGrades,
                        builder: (context, AsyncSnapshot<List<List<double>>> data) {
                          if (data.hasData) {
                            return LineChart(
                              showAvg ? avgData() : mainData(data.data!),
                              swapAnimationDuration: const Duration(milliseconds: 250), // Optional
                              swapAnimationCurve: Curves.linear,
                            );
                          } else {
                            return const Material(
                              elevation: 0,
                              borderOnForeground: false,
                              child: Center(child: CircularProgressIndicator()),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ),
            SizedBox(
              width: 60,
              height: 34,
              child: TextButton(
                onPressed: () {
                  setState(() {
                    showAvg = !showAvg;
                  });
                },
                child: Text(
                  'avg',
                  style: TextStyle(
                    fontSize: 12,
                    color: showAvg ? Colors.white.withOpacity(0.5) : Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
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
    return Text(value.toString(), style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData(List<List<double>> data) {
    return LineChartData(
        clipData: FlClipData.all(), // add here
        lineBarsData: [
          LineChartBarData(
            spots: data[index].asMap().entries.map((e) => FlSpot(e.key.toDouble(), e.value)).toList(),
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
          )
        ],
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d)),
        ),
        minX: 0,
        maxX: 11,
        minY: 0,
        maxY: 6,
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
            bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: bottomTitleWidgets)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: leftTitleWidgets))),
        lineTouchData: LineTouchData(enabled: true));
  }

  LineChartData avgData() {
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
            reservedSize: 42,
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
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 6),
            FlSpot(1, 6),
            FlSpot(2, 6),
            FlSpot(3, 6),
            FlSpot(4, 6),
            FlSpot(5, 6),
            FlSpot(6, 6),
            FlSpot(7, 6),
            FlSpot(8, 6),
            FlSpot(9, 6),
          ],
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
