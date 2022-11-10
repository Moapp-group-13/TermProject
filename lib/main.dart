import 'package:flutter/material.dart';
import 'package:termproject/member.dart';

final List<Widget> pages = <Widget>[
  MemberPage(),
  SecondPage(),
  ThirdPage(),
  LastPage(),
];
/* 페이지 실행시 2~4번째 지우고 본인 페이지 넣어주세요 */
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cleaning Guide',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        primaryColor: Colors.lightBlue[100],
        //primaryColor: Color(0xe8eaf6),


      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);


  final String title='';




  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  static int _selectedTabIndex =0;
  /* static 변수 나중에 라우터로 변경할 예정 */

  void _changeIndex(int index) {
    setState(() {
      _selectedTabIndex = index;
      //print('${_selectedTabIndex}');
    });






  }
  @override
  Widget build(BuildContext context) {

     return Scaffold(
      appBar: AppBar(
        title: Text(''),
        actions: [
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.account_circle),
          )
        ],

      ),
      body: pages.elementAt(_selectedTabIndex),



      bottomNavigationBar:BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedTabIndex,
          onTap: _changeIndex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
            BottomNavigationBarItem(icon: Icon(Icons.location_on_outlined), label: 'room'),
            BottomNavigationBarItem(icon: Icon(Icons.access_time_outlined), label: 'history'),
            BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'statistics'),
    ],
        selectedItemColor: Colors.blueAccent,
      )
    );

  }
}

