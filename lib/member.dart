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
        title: Text('가족 구성원',
        style: TextStyle(
          fontFamily: "content7",
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),),
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
      body: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '  우리들의 순위',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,


                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 4,
                itemBuilder: (context,index){
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  //side: BorderSide(width: 1.0)
                  ),
                  elevation: 4.0,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage('1.PNG',),
                      ),
                      title: Text('아빠',
                        style: TextStyle(
                            fontSize: 25,
                          fontFamily: 'content7',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text('화장실 청소 해놨다',
                        style: TextStyle(
                          fontSize: 17,
                          fontFamily: 'content7',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: CircleAvatar(
                        radius: 20,
                        //backgroundColor: Colors.grey,
                        child: Text('2위',
                          style: TextStyle(
                            fontSize: 22,
                            fontFamily: 'content7',
                            fontWeight: FontWeight.bold,
                            color: Colors.pink,
                          ),
                        ),
                      ),

                    ),
                  ),
                );
                },

            ),
          ),
        ],
      ),
    );
  }
}
