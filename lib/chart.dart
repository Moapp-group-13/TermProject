import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'main.dart';
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Log Isn';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(
            title: const Text(_title),
          actions: [
            IconButton(
              onPressed: (){

                  Navigator.pushNamed(context, '/api');

              },
              icon: const Icon(Icons.account_circle),
            )
          ],
        ),

        body: const ChartPage(),
      ),
    );
  }
}


class ChartPage extends StatefulWidget {
  const ChartPage({Key? key}) : super(key: key);

  @override
  _ChartPage createState() => _ChartPage();
}

class _ChartPage extends State<ChartPage> {
  late List<CleaningChart> _charData;
  @override
  void initState(){
    _charData = getChartData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('통계'),
        actions: [
          IconButton(
            onPressed: (){

              setState(() {
                Navigator.pushNamed(context, '/modify');
              });

            },
            icon: const Icon(Icons.account_circle),
          )
        ],
      ),
      body: SafeArea(
          child: Scaffold(
            body: SfCircularChart(
              title: ChartTitle(text: 'Statistics'),
              legend: (Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap)),
              series: <CircularSeries>[
                PieSeries<CleaningChart , String>(
                    dataSource: _charData,
                    xValueMapper: (CleaningChart data,_)=> data.name,
                    yValueMapper: (CleaningChart data,_)=> data.cleaning,
                    //dataLabelSettings: const DataLabelSettings(isVisible: true)   //숫자 말고 이름으로
                )
              ],),
          )),
    );
  }

  List<CleaningChart> getChartData(){
    final List<CleaningChart> chartData = [
      CleaningChart('Mom', 8),
      CleaningChart('Father', 3),
      CleaningChart('Sister', 4),
    ];
    return chartData;
  }
}

class CleaningChart{
  CleaningChart(this.name, this. cleaning);
  final String name;
  final int cleaning;
}

//Dynamic update 구현
