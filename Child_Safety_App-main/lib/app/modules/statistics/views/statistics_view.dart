import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/statistics_controller.dart';


class StatisticsView extends GetView<StatisticsController> {
    StatisticsView({Key? key}) : super(key: key);
   List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  @override
  Widget build(BuildContext context) {
    List<List<double>> points=[[0,0],[4,5],[6,7],[6,3],[7,5],[8,6]];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(right: 10.0,left: 10.0, top: 40),
        child: SingleChildScrollView(
          child: Center(
            child: Align(
              alignment: Alignment.topCenter,
              child:Column (
                   children: [
                     SizedBox(
                       height:2*Get.height/3 ,
                       width: 400,
                       child: RadarChartSample(),
                     ),
                     SizedBox(
                       height: 100,
                     ),
                     Text(
                       'System Screen Time'.toUpperCase(),
                       style: TextStyle(
                         fontSize: 24,
                         color: Colors.indigo
                       ),
                     ),

                     SizedBox(
                       height: Get.height/2,
                       width: 375,
                       child:LineGraph(points:points )
                     )


                     // LineGraph(points: points),

                  ],


              ),
            ),
          ),
        ),
      ),
    );
  }
}



class LineGraph extends StatefulWidget {
  List<List<double>> points;
  LineGraph({Key? key, required this.points}) : super(key: key);

  @override
  State<LineGraph> createState() => _LineGraphState();
}

class _LineGraphState extends State<LineGraph> {
  @override
  Widget build(BuildContext context) {
    return LineChart(
        LineChartData(
            borderData: FlBorderData(
                show: true,
                border: Border.all(color: Colors.black26 , width: 2)
            ),
            gridData: FlGridData(
              show: true,
              getDrawingHorizontalLine: (value) {
                return FlLine(
                    color: Colors.black26,
                    strokeWidth: 1
                );
              },
              drawVerticalLine: true,
              getDrawingVerticalLine: (value) {
                return FlLine(
                    color: Colors.black26,
                    strokeWidth: 1
                );
              },
            ),
            titlesData: FlTitlesData(
              show: true,
              bottomTitles: AxisTitles(sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 35,
                // getTextStyles: (context, value) {
                //   return const TextStyle(
                //       color: Color(0xff68737d),
                //       fontSize: 16,
                //       fontWeight: FontWeight.bold
                //   );
                // },
                // getTitles: (value) {
                //   switch(value.toInt()){
                //     case 0 :
                //       return 'Sep 19';
                //     case 4 :
                //       return 'Oct 10';
                //     case 8 :
                //       return 'Nov 16';
                //   }
                //   return '';
                // },
                // margin: 8
              )),
              rightTitles: AxisTitles(sideTitles: SideTitles()),
              topTitles: AxisTitles(sideTitles: SideTitles()),
              leftTitles: AxisTitles(sideTitles: SideTitles()),
            ),
            maxX: 8,
            maxY: 8,
            minY: 0,
            minX: 0,
            lineBarsData: [
              LineChartBarData(
                  spots: widget.points.map((e) => FlSpot(e[0], e[1])).toList(),
                  isCurved: true,
                  color:Colors.blueAccent,
                  barWidth: 5,
                  belowBarData: BarAreaData(
                      show: true,
                      color:Colors.transparent
                  )
              )
            ]
        ),
        swapAnimationDuration: const Duration(milliseconds: 7000), // Optional
        swapAnimationCurve: Curves.linear, // Optional
    );
  }
}

class RadarChartSample extends StatefulWidget {
  RadarChartSample({super.key});

  final gridColor = Colors.black26;
  final titleColor = Colors.black;
  final fashionColor = Colors.blueAccent;
  final artColor = Colors.cyan;
  final boxingColor = Colors.green;
  final entertainmentColor = Colors.blue;
  final offRoadColor = Colors.amberAccent;

  @override
  State<RadarChartSample> createState() => _RadarChartSampleState();
}

class _RadarChartSampleState extends State<RadarChartSample> {
  int selectedDataSetIndex = -1;
  double angleValue = 0;
  bool relativeAngleMode = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // const Text(
          //   'Complete Screen Time',
          //   style: TextStyle(
          //     color: Colors.lightGreen,
          //   ),
          // ),
          // Row(
          //   children: [
          //     const Text(
          //       'Angle',
          //       style: TextStyle(
          //         color: Colors.green,
          //       ),
          //     ),
          //     Slider(
          //       value: angleValue,
          //       max: 360,
          //       onChanged: (double value) => setState(() => angleValue = value),
          //     ),
          //     // Checkbox(
          //     //   value: relativeAngleMode,
          //     //   onChanged: (v) => setState(() => relativeAngleMode = v!),
          //     // ),
          //     const Text('Relative'),
          //   ],
          // ),
          GestureDetector(
            onTap: () {
              setState(() {
                selectedDataSetIndex = -1;
              });
            },
            child: Text(
              'App Screen Time'.toUpperCase(),
              style: const TextStyle(

                fontSize: 24,
                fontWeight: FontWeight.w300,
                color: Colors.indigo,
              ),
            ),
          ),
          const SizedBox(height: 4),

          AspectRatio(
            aspectRatio: 1.4,
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
                          response?.touchedSpot?.touchedDataSetIndex ?? 0;
                    });
                  },
                ),
                dataSets: showingDataSets(),
                radarBackgroundColor: Colors.transparent,
                borderData: FlBorderData(show: false),
                radarBorderData: const BorderSide(color: Colors.transparent),
                titlePositionPercentageOffset: 0.2,
                titleTextStyle:
                TextStyle(color: widget.titleColor, fontSize: 14),
                getTitle: (index, angle) {
                  final usedAngle =
                  relativeAngleMode ? angle + angleValue : angleValue;
                  // switch (index) {
                  //   case 0:
                  //     return RadarChartTitle(
                  //       text: 'Mobile or Tablet',
                  //       angle: usedAngle,
                  //     );
                  //   case 2:
                  //     return RadarChartTitle(
                  //       text: 'Desktop',
                  //       angle: usedAngle,
                  //     );
                  //   case 1:
                  //     return RadarChartTitle(text: 'TV', angle: usedAngle);
                  //   default:
                  //     return const RadarChartTitle(text: '');
                  // }

                  for(var i=0;i<6;i++){
                   if(i==index){
                     return RadarChartTitle(
                       text: '${i*4}',
                       angle: usedAngle,

                     );}
                  }
                  return  RadarChartTitle(text: '0');



                },
                tickCount: 1,
                ticksTextStyle:
                const TextStyle(color: Colors.transparent, fontSize: 10),
                tickBorderData: const BorderSide(color: Colors.transparent),
                gridBorderData: BorderSide(color: widget.gridColor, width: 2),
              ),
              swapAnimationDuration: const Duration(milliseconds: 400),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: rawDataSets()
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
                    duration: const Duration(milliseconds: 700),
                    margin: const EdgeInsets.symmetric(vertical: 2),
                    height: 24,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.white
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
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInToLinear,
                          padding: EdgeInsets.all(isSelected ? 8 : 6),
                          decoration: BoxDecoration(
                            color: value.color,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInToLinear,
                          style: TextStyle(
                            color:
                            isSelected ? value.color : widget.gridColor,
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
         ],
      ),
    );
  }

  List<RadarDataSet> showingDataSets() {
    return rawDataSets().asMap().entries.map((entry) {
      final index = entry.key;
      final rawDataSet = entry.value;

      final isSelected = index == selectedDataSetIndex
          ? true
          : selectedDataSetIndex == -2
          ? true
          : false;

      return RadarDataSet(
        fillColor: isSelected
            ? rawDataSet.color.withOpacity(0.2)
            : rawDataSet.color.withOpacity(0.05),
        borderColor:
        isSelected ? rawDataSet.color : rawDataSet.color.withOpacity(0.1),
        entryRadius: isSelected ? 3 : 2,
        dataEntries:
        rawDataSet.values.map((e) => RadarEntry(value: e)).toList(),
        borderWidth: isSelected ? 3 : 2,
      );
    }).toList();
  }

  List<RawDataSet> rawDataSets() {
    List<RawDataSet> points=[];

    for (int i=0;i<6;i++) {
      points.add(RawDataSet(
        title: '$i',
        color: widget.fashionColor,
        values: [
          i + 3, i + 4, i + 2,i+1,i+0,i+5
        ],
      ));



  }
    return points;







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


