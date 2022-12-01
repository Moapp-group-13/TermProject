import 'package:flutter/material.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:termproject/model/model.dart';
import 'package:termproject/server.dart';
import 'history.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Statistics';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: Scaffold(
        body: ChartPage(),
      ),
    );
  }
}


class ChartPage extends StatefulWidget {
  const ChartPage({Key? key}) : super(key: key);

  @override
  _ChartPage createState() => _ChartPage();
}

class _ChartPage extends State<ChartPage> with TickerProviderStateMixin {
  // late final List<PlutoMenuItem> whiteHoverMenus;
  Future<GETROOMLIST>? roomlist;
  int roomid=0;
  late TabController _tabController;
  List<Widget>? _pagelist;
  @override
  void initState(){
    roomlist = ServerApi.getRoom();
    super.initState();

  }
  void message(context, String text) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    final snackBar = SnackBar(
      content: Text(text),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return
      FutureBuilder(future: roomlist,builder: (context,snapshot) {
        if (snapshot.hasData) {
          _tabController = TabController(vsync: this, length: snapshot.data!.roomlist!.length,);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Text('Statistics',style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
              ),),
              bottom: ButtonsTabBar(
                  controller: _tabController,
                  backgroundColor: Colors.green[600],
                  unselectedBackgroundColor: Colors.white,
                  labelStyle:
                  TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  unselectedLabelStyle: TextStyle(
                      color: Colors.green[600],
                      fontWeight: FontWeight.bold),
                  borderWidth: 3,
                  unselectedBorderColor: Colors.green[600]!,
                  radius: 100,
                  tabs: List<Tab>.generate(
                      snapshot.data!.roomlist!.length, (i) =>
                      Tab(text: snapshot.data!.roomlist![i].title!))
              ),

              actions: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      Navigator.pushNamed(context, '/modify');
                    });
                  },
                  icon: const Icon(Icons.account_circle),
                )
              ],
            ),
            body: TabBarView(
              controller: _tabController,
              children: List<SfCircularChart>.generate(snapshot.data!.roomlist!.length,
                      (i) => SfCircularChart(
                    title: ChartTitle(text: 'Statistics of'),
                    legend: (Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap)),
                    series: <CircularSeries>[
                      PieSeries<InviteCheck , String>(
                        // dataSource: _charData,
                        // xValueMapper: (CleaningChart data,_)=> data.name,
                        // yValueMapper: (CleaningChart data,_)=> data.cleaning,
                        //dataLabelSettings: const DataLabelSettings(isVisible: true)   //숫자 말고 이름으로
                      )
                    ],
                  )
              ),
            ),

          );
        }
        else if (snapshot.hasError) {
          return Text("error");
        }
        return CircularProgressIndicator();
      });
  }

//
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


