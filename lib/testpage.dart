import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:termproject/main.dart';
import 'register.dart';
import 'server.dart';
import 'model/model.dart';


class TestMemberPage extends StatefulWidget {
  const TestMemberPage({Key? key}) : super(key: key);

  @override
  State<TestMemberPage> createState() => _MemberPageState();
}

class _MemberPageState extends State<TestMemberPage> {

  Future<InviteCheck>? getmember;
  List<AssetImage> IconList=[AssetImage('rabitIcon.PNG'),AssetImage('rabitIcon.PNG'),AssetImage("loginimage.PNG")];


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
      body: FutureBuilder<InviteCheck>(
        future: getmember,
        builder: (context,snapshot){
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data!.memberList!.length,
                itemBuilder: (context,index){
                  return ListTile(
                          leading: CircleAvatar(
                            radius:40,
                            backgroundImage: IconList[snapshot.data!.memberList![index].icon!],
                          ),
                          title: Text(snapshot.data!.memberList![index].nickname!,
                            style: TextStyle(
                                fontSize: 20
                            ),
                          ),
                          subtitle: Text(snapshot.data!.memberList![index].stateMessage!,
                          ),
                          trailing: Text('2위'),
                  );

                }
                );
          }else if (snapshot.hasError){
            return Text("error");
          }
          return CircularProgressIndicator();
        }
      )
    );
  }
}