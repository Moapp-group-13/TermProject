import 'package:flutter/material.dart';
import 'package:termproject/main.dart';
import 'register.dart';
/* 멤버페이지
a.둥근모서리
b.db연동 추가
c.사진추가
회원가입창
회원정보수정창
폰트추가



 */
class MemberPage extends StatefulWidget {
  const MemberPage({Key? key}) : super(key: key);

  @override
  State<MemberPage> createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //toolbarHeight: 80,
        backgroundColor: Colors.white,
        title: Text('Family Member'),
        actions: [
          IconButton(
            onPressed: (){
              setState(() {
                Navigator.push(context,MaterialPageRoute(
                    builder: (context)=>SecondPage()));
              });
            },
            icon: const Icon(Icons.account_circle),
          )
        ],

      ),
      body: ListView(
          children: [
            SizedBox(
              height: 20,
            ),
            /*
            ListTile(
              shape: StadiumBorder(
                side:BorderSide(color:Colors.black12,width:1),

              ),

              iconColor: Colors.blue,
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

       */
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

      ),
    );
  }
}
class SecondPage extends StatefulWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //toolbarHeight: 80,
          backgroundColor: Colors.white,
          title: Text('회원정보 수정'),
          actions: [
            
          ],

        ),
        body: Text('second'),
    );

  }
}


class ModifyPage extends StatefulWidget {
  const ModifyPage({Key? key}) : super(key: key);

  @override
  State<ModifyPage> createState() => _ModifyPageState();
}

class _ModifyPageState extends State<ModifyPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


