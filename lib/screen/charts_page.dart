import 'package:debits/controllers/home_controller.dart';
import 'package:debits/models/expenses.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class ChartPage extends StatefulWidget {
  const ChartPage({Key? key}) : super(key: key);

  @override
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  final _controller = HomeController();

  List<PieChartSectionData> _chartSections() {
    final List<PieChartSectionData> list = [];
    for (Expenses sector in _controller.listItems) {
      if (sector.type == MoneyType.GASTO) {
        const double radius = 40.0;
        final data = PieChartSectionData(
          color: sector.color,
          value: sector.value,
          radius: radius,
          title: sector.text,
        );
        list.add(data);
      }
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    if (_controller.listItems.isEmpty) return const CircularProgressIndicator();

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1.0,
              child: PieChart(
                PieChartData(
                  sectionsSpace: 2.0,
                  sections: _chartSections(),
                  centerSpaceRadius: 48.0,
                ),
              ),
            ),
            // ..._chartSections()
            //     .map((e) => ListTile(
            //           leading: Container(
            //             width: 50,
            //             height: 50,
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(50),
            //                 color: e.color),
            //           ),
            //           title: Text(e.title),
            //         ))
            //     .toList()
            SizedBox(
              height: MediaQuery.of(context).size.height * .5,
              child: showIncomeVSExpenseChart(),
            )
          ],
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    const Color leftBarColor = Color(0xff53fdd7);
    const Color rightBarColor = Color(0xffff5182);
    const double width = 7;

    return BarChartGroupData(barsSpace: 4, x: x, barRods: [
      BarChartRodData(
        y: y1,
        colors: [leftBarColor],
        width: width,
      ),
      BarChartRodData(
        y: y2,
        colors: [rightBarColor],
        width: width,
      ),
    ]);
  }

  Widget showIncomeVSExpenseChart() {
    final barGroup1 = makeGroupData(0, 5, 12);
    final barGroup2 = makeGroupData(1, 16, 12);
    final barGroup3 = makeGroupData(2, 18, 5);
    final barGroup4 = makeGroupData(3, 20, 16);
    final barGroup5 = makeGroupData(4, 17, 6);
    final barGroup6 = makeGroupData(5, 19, 1.5);
    final barGroup7 = makeGroupData(6, 10, 1.5);
    final items = [
      barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
      barGroup5,
      barGroup6,
      barGroup7,
    ];

    var showingBarGroups = List.of(items);
    return (BarChart(
      BarChartData(
        maxY: 20,
        barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
              tooltipBgColor: Colors.grey,
              getTooltipItem: (_a, _b, _c, _d) => null,
            ),
            touchCallback: (_, __) {}),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: SideTitles(
            showTitles: true,
            getTextStyles: (value, _) => const TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
            margin: 20,
            getTitles: (double value) {
              switch (value.toInt()) {
                case 0:
                  return '2015';
                default:
                  return '';
              }
            },
          ),
          leftTitles: SideTitles(
            showTitles: true,
            getTextStyles: (value, _) => const TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.bold,
                fontSize: 14),
            margin: 32,
            reservedSize: 11,
            getTitles: (value) {
              if (value == 0) {
                return '1K';
              } else if (value == 10) {
                return '5K';
              } else if (value == 19) {
                return '10K';
              } else {
                return '';
              }
            },
          ),
        ),
        borderData: FlBorderData(
          show: false,
        ),
        barGroups: showingBarGroups,
      ),
    ));
  }
}
