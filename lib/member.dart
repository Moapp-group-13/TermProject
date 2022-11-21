import 'package:flutter/material.dart';

class MemberPage extends StatefulWidget {
  const MemberPage({Key? key}) : super(key: key);

  @override
  State<MemberPage> createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
        children: const [
          ListTile(
            leading: Icon(Icons.adb_sharp),
            title: Text('아빠',
              style: TextStyle(
                  fontSize: 20
              ),
            ),
            subtitle: Text('화장실 청소 해놨다',
            ),
            trailing: Text('2위'),
          ),
          ListTile(
            leading: Icon(Icons.adb_sharp),
            title: Text('엄마',
              style: TextStyle(
                  fontSize: 20
              ),
            ),
            subtitle: Text('공주님 왕자님~ 방 청소 좀 하세요^^',
            ),
            trailing: Text('1위'),
          ),
          ListTile(
            leading: Icon(Icons.adb_sharp),
            title: Text('딸',
              style: TextStyle(
                  fontSize: 20
              ),),
            subtitle: Text('시험공부중! 청소는 나중에',
            ),
            trailing: Text('3위'),
          ),ListTile(
            leading: Icon(Icons.adb_sharp),
            title: Text('아들',
              style: TextStyle(
                  fontSize: 20
              ),),
            subtitle: Text('집에 안들어가요',
            ),
            trailing: Text('4위'),
          ),


        ],

    );
  }
}


