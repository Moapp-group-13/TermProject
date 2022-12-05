import 'package:flutter/material.dart';
import 'package:termproject/main.dart';
import 'package:termproject/model/model.dart';
import 'package:termproject/server.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'register.dart';

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
                for(int i=0;i<5000;i++){
                  CircularProgressIndicator();
                }

                if(snapshot.hasData){
                  int? length = snapshot?.data!.groupList!.length as int;
                  return Flexible(
                    child: ListView.builder(
                      itemCount: length +1 ,
                      itemBuilder: (context,index){
                        if(index==length){
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              //side: BorderSide(width: 1.0)
                            ),
                            elevation: 4.0,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: ListTile(

                                subtitle: IconButton(
                                    splashRadius: 30,
                                    iconSize: 50,
                                    onPressed: () async{
                                      Navigator.pushNamed(context, '/gc');
                                    },
                                    icon: const Icon(
                                      Icons.add,
                                    )),
                                isThreeLine: true,
                              ),
                            ),
                          );
                        }
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
                                ).sublist(0,5<snapshot.data!.groupList![index].member!.length!?5:snapshot.data!.groupList![index].member!.length!),
                              ),
                              onTap: ()async{
                                await ServerApi.setGroup(snapshot!.data!.groupList![index].id!);
                                //  Navigator.pop(context);
                                 Navigator.pushNamed(context, '/home');
                                //  ScaffoldMessenger.of(context).showSnackBar(SnackBar(duration: const Duration(milliseconds: 500),
                                //    content: Text("현재그룹 ${snapshot.data!.groupList![index].title!}"),
                                // )
                                // );
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