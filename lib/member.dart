import 'package:flutter/material.dart';
import 'package:termproject/main.dart';
import 'package:termproject/model/model.dart';
import 'package:termproject/server.dart';
import 'register.dart';


class MemberPage extends StatefulWidget {
  const MemberPage({Key? key}) : super(key: key);

  @override
  State<MemberPage> createState() => _MemberPageState();
}
class _MemberPageState extends State<MemberPage> {
  Future<InviteCheck>? getmember;
  Future<Map>? getscore;

  @override
  void initState() {
    super.initState();
    getmember = ServerApi.getmember();
    getscore =ServerApi.groupScore();
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
                '  우리들의 점수',
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
          FutureBuilder<List<dynamic>>(
            future: Future.wait([getmember!,getscore!]),
            builder: (context, snapshot) {
              if(snapshot.hasData){
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot?.data![0].memberList!.length,
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
                              backgroundImage: AssetImage('${snapshot.data![0].memberList![index].icon!}.PNG',),
                            ),
                            title: Text(snapshot.data![0].memberList![index].nickname!,
                              style: TextStyle(
                                fontSize: 25,
                                fontFamily: 'content7',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(snapshot.data![0].memberList![index].stateMessage!,
                              style: TextStyle(
                                fontSize: 17,
                                fontFamily: 'content7',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            trailing: CircleAvatar(
                              radius: 20,
                              //backgroundColor: Colors.grey,
                              child: Text('${snapshot.data![1][snapshot.data![0].memberList![index].user.id]??"0"}점',
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
