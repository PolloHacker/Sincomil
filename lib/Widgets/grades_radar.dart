
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../Constants/constants.dart';

const gridColor = Color(0xff68739f);
const titleColor = Color(0xff8c95db);
const fashionColor = Color(0xffff001c);
const artColor = Color(0xff06a6a2);
const boxingColor = Color(0xff1f772a);
const entertainmentColor = Color(0xffeebf50);
const offRoadColor = Color(0xFFF6760D);

final List<Color> clrs = [
  fashionColor,
  artColor,
  boxingColor,
  entertainmentColor,
  offRoadColor
];

class RadarGraph extends StatefulWidget {
  final Future<List<List<List<double>>>> orgAllGrades;
  final List<String> list;

  const RadarGraph({super.key, required this.orgAllGrades, required this.list});

  @override
  State<RadarGraph> createState() =>
      _RadarGraphState(orgAllGrades, list);
}

class _RadarGraphState extends State<RadarGraph> {
  final Future<List<List<List<double>>>> orgAllGrades;
  final List<String> list;

  int selectedDataSetIndex = -1;
  double angleValue = 0;
  bool relativeAngleMode = false;

  _RadarGraphState(this.orgAllGrades, this.list);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: orgAllGrades,
        builder: (context, AsyncSnapshot<List<List<List<double>>>> data) {
          if (data.hasData) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedDataSetIndex = -1;
                      });
                    },
                    child: Text(
                      'Alunos'.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: rawDataSets(data.data!)
                        .asMap()
                        .map((index, value) {
                          final isSelected = index == selectedDataSetIndex;
                          return MapEntry(
                            index,
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedDataSetIndex = index;
                                });
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                margin: const EdgeInsets.symmetric(vertical: 2),
                                height: 26,
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? gridColor.withOpacity(0.5)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(46),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 4,
                                  horizontal: 6,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 400),
                                      curve: Curves.easeInToLinear,
                                      padding:
                                          EdgeInsets.all(isSelected ? 8 : 6),
                                      decoration: BoxDecoration(
                                        color: value.color,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    AnimatedDefaultTextStyle(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeInToLinear,
                                      style: TextStyle(
                                        color: isSelected
                                            ? value.color
                                            : Theme.of(context).textTheme.bodyMedium?.color,
                                      ),
                                      child: Text(value.title),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        })
                        .values
                        .toList(),
                  ),
                  AspectRatio(
                    aspectRatio: 1.3,
                    child: RadarChart(
                      RadarChartData(
                        radarTouchData: RadarTouchData(
                          touchCallback: (FlTouchEvent event, response) {
                            if (!event.isInterestedForInteractions) {
                              setState(() {
                                selectedDataSetIndex = -1;
                              });
                              return;
                            }
                            setState(() {
                              selectedDataSetIndex =
                                  response?.touchedSpot?.touchedDataSetIndex ??
                                      -1;
                            });
                          },
                        ),
                        dataSets: showingDataSets(data.data!),
                        radarBackgroundColor: Colors.transparent,
                        borderData: FlBorderData(show: false),
                        radarBorderData:
                            const BorderSide(color: Colors.transparent),
                        titlePositionPercentageOffset: 0.2,
                        titleTextStyle:
                            const TextStyle(fontSize: 14),
                        getTitle: (index, angle) {
                          final usedAngle = relativeAngleMode
                              ? angle + angleValue
                              : angleValue;
                          switch (index) {
                            case 0:
                              return RadarChartTitle(
                                text: 'Ciências Exatas',
                                angle: usedAngle,
                              );
                            case 2:
                              return RadarChartTitle(
                                text: 'Ciências Humanas',
                                angle: usedAngle,
                              );
                            case 1:
                              return RadarChartTitle(
                                  text: 'Ciências Biológicas',
                                  angle: usedAngle);
                            default:
                              return const RadarChartTitle(text: '');
                          }
                        },
                        tickCount: 1,
                        ticksTextStyle: const TextStyle(
                            color: Colors.transparent, fontSize: 10),
                        tickBorderData:
                            const BorderSide(color: Colors.transparent),
                        gridBorderData:
                            const BorderSide(color: gridColor, width: 2),
                      ),
                      swapAnimationDuration: const Duration(milliseconds: 400),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Padding(
                padding: EdgeInsets.all(16),
                child: Center(
                  child: SpinKitDualRing(color: buttonColor),
                ));
          }
        });
  }

  List<RadarDataSet> showingDataSets(List<List<List<double>>> data) {
    return rawDataSets(data).asMap().entries.map((entry) {
      final index = entry.key;
      final rawDataSet = entry.value;

      final isSelected = index == selectedDataSetIndex
          ? true
          : selectedDataSetIndex == -1
              ? true
              : false;

      return RadarDataSet(
        fillColor: isSelected
            ? rawDataSet.color.withOpacity(0.2)
            : rawDataSet.color.withOpacity(0.05),
        borderColor:
            isSelected ? rawDataSet.color : rawDataSet.color.withOpacity(0.25),
        entryRadius: isSelected ? 3 : 2,
        dataEntries:
            rawDataSet.values.map((e) => RadarEntry(value: e)).toList(),
        borderWidth: isSelected ? 2.3 : 2,
      );
    }).toList();
  }

  List<RawDataSet> rawDataSets(List<List<List<double>>> data) {
    final dataSets = [RawDataSet(title: 'Grau máximo', color: titleColor.withOpacity(0.5), values: [10, 10, 10])];
    dataSets.addAll(list.asMap().entries.map((e) {
      List<double> humanas = [];
      List<double> exatas = [];
      List<double> bio = [];
      humanas.addAll(data[e.key][0]);
      bio.addAll(data[e.key][1]);
      humanas.addAll(data[e.key][2]);
      humanas.addAll(data[e.key][3]);
      exatas.addAll(data[e.key][4]);
      humanas.addAll(data[e.key][5]);
      humanas.addAll(data[e.key][6]);
      humanas.addAll(data[e.key][7]);
      exatas.addAll(data[e.key][8]);
      exatas.addAll(data[e.key][9]);
      humanas.addAll(data[e.key][10]);
      humanas.addAll(data[e.key][11]);

      return RawDataSet(title: e.value, color: clrs[e.key], values: [
        (exatas.fold(0, (a, b) => (a + b).round()) / exatas.length),
        (humanas.fold(0, (a, b) => (a + b).round()) / humanas.length),
        (bio.fold(0, (a, b) => (a + b).round()) / bio.length)
      ]);
    }).toList());
    return dataSets;
  }
}

class RawDataSet {
  RawDataSet({
    required this.title,
    required this.color,
    required this.values,
  });
  final String title;
  final Color color;
  final List<double> values;
}
