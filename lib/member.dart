import 'package:flutter/material.dart';
import 'package:termproject/main.dart';
import 'register.dart';
//https://muhly.tistory.com/112

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

        backgroundColor: Colors.white,
        title: Text('Family Member'),
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
      body: ListView(
          children: [
            const Text(
              '   우리들의 순위',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),


            ListTile(

              shape: RoundedRectangleBorder(
                borderRadius:BorderRadius.circular(50) ,
                  //side: BorderSide(color: Colors.black),

                //테두리

            ),

              leading: CircleAvatar(
                radius:30,
                backgroundImage: AssetImage('1.PNG'),
              ),

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
              leading: CircleAvatar(
                radius:30,
                backgroundImage: AssetImage('2.PNG'),
              ),
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
              leading: CircleAvatar(
                radius:30,
                backgroundImage: AssetImage('4.PNG'),
              ),
              title: Text('딸',
                style: TextStyle(
                    fontSize: 20
                ),),
              subtitle: Text('시험공부중! 청소는 나중에',
              ),
              trailing: Text('3위'),
            ),ListTile(
              leading: CircleAvatar(
                radius:30,
                backgroundImage: AssetImage('3.PNG'),
              ),
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
