import 'package:flutter/material.dart';
import 'package:termproject/main.dart';
import 'package:termproject/model/model.dart';
import 'package:termproject/server.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'register.dart';
//https://muhly.tistory.com/112
//폰트 상수 관련 https://darrengwon.tistory.com/388
//라우트 관련 애니메이션
// https://velog.io/@enoch1118/%ED%94%8C%EB%9F%AC%ED%84%B0%EB%A5%BC-%ED%94%8C%EB%9F%AC%ED%84%B0%EC%8A%A4%EB%9F%BD%EC%A7%80%EC%95%8A%EA%B2%8C%EB%9D%BC%EC%9A%B0%ED%8A%B8


class GroupSelectPage extends StatefulWidget {
  const GroupSelectPage({Key? key}) : super(key: key);

  @override
  State<GroupSelectPage> createState() => _GroupSelectPageState();
}
class _GroupSelectPageState extends State<GroupSelectPage> {
  Future<MyGroup>? _mygroup;


  @override
  void initState() {
    super.initState();
    _mygroup = ServerApi.getGroup();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Colors.white,
        title: Text('그룹 선택창',
        style: const TextStyle(
          //fontFamily: "content7",
          //fontSize: 25,
          fontWeight: FontWeight.bold,
        ),),
      ),
      body: Column(
        children: [
          const SizedBox(
            height:15,
          ),

          FutureBuilder<MyGroup>(
            future: _mygroup,
            builder: (context, snapshot) {
              if(snapshot.hasData){
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot?.data!.groupList!.length,
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
                            title: Text(snapshot.data!.groupList![index].title!,
                              style: TextStyle(
                                fontSize: 25,
                                fontFamily: 'content7',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Row(
                              children:List<Text>.generate(snapshot.data!.groupList![index].member!.length!,(i)=>Text(snapshot.data!.groupList![index].member![i].nickname!,
                                style: const TextStyle(
                                fontFamily: "content7",
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),)
                            ).sublist(0,5<snapshot.data!.groupList![index].member!.length!?4:snapshot.data!.groupList![index].member!.length!),
                            ),
                            onTap: ()async{
                              await ServerApi.setGroup(snapshot!.data!.groupList![index].id!);
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(duration: const Duration(milliseconds: 500),
                                content: Text("현재그룹 ${snapshot.data!.groupList![index].title!}"),
                              ));
                              // Navigator.pop(context);
                            },


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
