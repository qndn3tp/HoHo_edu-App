import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/models/book_data.dart';
import 'package:get/get.dart';
import '../../style.dart' as style;


//////////////////////
// 독서클리닉3 차트  //
//////////////////////

class BookChart extends StatefulWidget {
  const BookChart({super.key});

  @override
  State<BookChart> createState() => _BookChartState();
}

class _BookChartState extends State<BookChart> {
  // 컨트롤러 생성
  YMBookCountDataController ymBookCountDataController = Get.put(YMBookCountDataController());

  // 색상값
  List<Color> gradientColors = [
    Colors.white,
    style.PRIMARY_GREEN,
  ];

  // 평균값
  bool showAvg = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // 차트 비율
        AspectRatio(
          aspectRatio: 1.50,
          child: Padding(
            padding: const EdgeInsets.only(
              right: 18,
              // left: 0,
              top: 50,
              // bottom: 12,
            ),
            child: LineChart(
              showAvg ? avgData() : mainData(),
            ),
          ),
        ),
        Positioned(
          left: MediaQuery.of(context).size.width - 100,
          child: Container(
            color: Colors.amber,
            width: 60,
            height: 34,
            // 평균값 버튼
            child: TextButton(
              onPressed: () {
                setState(() {
                  showAvg = !showAvg;
                });
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(const Color(0xfff8f8ed)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                )),
              child: Text(
                '평균',
                style: TextStyle(
                  fontSize: 15,
                  color: showAvg ? Colors.black.withOpacity(0.5) : Colors.black,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // x좌표 제목
  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const bottomtitleStyle = TextStyle(
      color: style.DEEP_GREY,
      fontSize: 15,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('1', style: bottomtitleStyle);
        break;
      case 1:
        text = const Text('2', style: bottomtitleStyle);
        break;
      case 2:
        text = const Text('3', style: bottomtitleStyle);
        break;
      case 3:
        text = const Text('4', style: bottomtitleStyle);
        break;
      case 4:
        text = const Text('5', style: bottomtitleStyle);
        break;
      case 5:
        text = const Text('6', style: bottomtitleStyle);
        break;
      case 6:
        text = const Text('7', style: bottomtitleStyle);
        break;
      case 7:
        text = const Text('8', style: bottomtitleStyle);
        break;
      case 8:
        text = const Text('9', style: bottomtitleStyle);
        break;
      case 9:
        text = const Text('10', style: bottomtitleStyle);
        break;
      case 10:
        text = const Text('11', style: bottomtitleStyle);
        break;
      default:
        text = const Text('12', style: bottomtitleStyle);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }


  // y좌표 제목
  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const leftTitleStyle = TextStyle(
      color: style.DEEP_GREY,
      fontSize: 15,
    );
    String text;
    switch (value.toInt()) {
      case 5:
        text = '5권';
        break;
      case 10:
        text = '10권';
        break;
      default:
        return Container();
    }

    return Text(text, style: leftTitleStyle, textAlign: TextAlign.left);
  }

  // 메인그래프
  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        horizontalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: style.GREY,
            strokeWidth: 0.5,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
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
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      // x, y 좌표 개수 
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 11,
      // 각 데이터의 x,y 좌표값
      lineBarsData: [
        LineChartBarData(
          spots: List.generate(
            12, 
            (index) => FlSpot(index.toDouble(), ymBookCountDataController.bookCountList[index].toDouble())
          ),
          isCurved: true,
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: gradientColors.map((color) => color.withOpacity(0.5))
                  .toList(),
          ),
            // gradient: LinearGradient(
            //   colors: gradientColors
                  // .map((color) => color.withOpacity(0.3))
                  // .toList(),
            // ),
          ),
        ),
      ],
    );
  }

  // 평균값 그래프
  LineChartData avgData() {
    return LineChartData(
      lineTouchData: const LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        horizontalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: style.GREY,
            strokeWidth: 0.5,
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
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      // x, y 좌표 개수
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 11,
      // 각 데이터의 x,y 좌표 값
      lineBarsData: [
        LineChartBarData(
          spots: List.generate(
            12, 
            (index) => FlSpot(index.toDouble(), ymBookCountDataController.meanCountList[index])),
          isCurved: true,
          color: const Color(0xff1c70cd),
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: const FlDotData(
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