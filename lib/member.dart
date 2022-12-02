import 'package:flutter/material.dart';
import 'package:termproject/main.dart';
import 'package:termproject/model/model.dart';
import 'package:termproject/server.dart';
import 'register.dart';
//https://muhly.tistory.com/112
//폰트 상수 관련 https://darrengwon.tistory.com/388
//라우트 관련 애니메이션
// https://velog.io/@enoch1118/%ED%94%8C%EB%9F%AC%ED%84%B0%EB%A5%BC-%ED%94%8C%EB%9F%AC%ED%84%B0%EC%8A%A4%EB%9F%BD%EC%A7%80%EC%95%8A%EA%B2%8C%EB%9D%BC%EC%9A%B0%ED%8A%B8


class MemberPage extends StatefulWidget {
  const MemberPage({Key? key}) : super(key: key);

  @override
  State<MemberPage> createState() => _MemberPageState();
}
class _MemberPageState extends State<MemberPage> {
  Future<InviteCheck>? getmember;


  @override
  void initState() {
    super.initState();
    getmember = ServerApi.getmember();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Colors.white,
        title: Text('가족 구성원',
        style: const TextStyle(
          //fontFamily: "content7",
          //fontSize: 25,
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
          const SizedBox(
            height:15,
          ),
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
            height: 5,
          ),
          FutureBuilder<InviteCheck>(
            future: getmember,
            builder: (context, snapshot) {
              if(snapshot.hasData){
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot?.data!.memberList!.length,
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
                              backgroundImage: AssetImage('${snapshot.data!.memberList![index].icon!}.PNG',),
                            ),
                            title: Text(snapshot.data!.memberList![index].nickname!,
                              style: TextStyle(
                                fontSize: 25,
                                fontFamily: 'content7',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(snapshot.data!.memberList![index].stateMessage!,
                              style: TextStyle(
                                fontSize: 17,
                                fontFamily: 'content7',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            // trailing: CircleAvatar(
                            //   radius: 20,
                            //   //backgroundColor: Colors.grey,
                            //   child: Text('2위',
                            //     style: TextStyle(
                            //       fontSize: 22,
                            //       fontFamily: 'content7',
                            //       fontWeight: FontWeight.bold,
                            //       color: Colors.pink,
                            //     ),
                            //   ),
                            // ),

                          ),
                        ),
                      );
                    },

                  ),
                );
              }
              else if(snapshot.hasError){
                return Text("error");
              }
              return CircularProgressIndicator();

            }
          ),
        ],
      ),
    );
  }
}
