import 'package:flutter/material.dart';
import 'server.dart';
import 'model/model.dart';
class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {

  // Future<Post> post;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: (){
              setState(() {
                Future<GETROOMLIST> getroomlist= getRoom("487eb37ad394842829f014b967ee62e545609834",4);
              });
            }, child: Text("roomlist")),
            ElevatedButton(onPressed: (){
              setState(() {
                register("user9","pswd1234");
              });
            }, child: Text("register")),
            ElevatedButton(onPressed: (){
              setState(() {
                Future<UserToken> usertoken = login("user9","pswd1234");
              });
            }, child: Text("login")),
            ElevatedButton(onPressed: (){
              setState(() {
                changeprofile("바보똥꾸",2,"오늘 힘들다",9,"07b59254506b235725a9c4bd554dbcbe0b30c932");
              });
            }, child: Text("changeProfile")),
            ElevatedButton(onPressed: (){
              setState((){
                Future<Profile> profile = getprofile(9,"07b59254506b235725a9c4bd554dbcbe0b30c932");
                profile.then((profile)=>print("${profile.nickname}${profile.icon}${profile.user!.username}${profile.stateMessage}"));
              });
            }, child: Text("getProfile")),
            ElevatedButton(onPressed: (){
              setState((){
                Future<Statics> statics = getStatics(1,null);
              });
            }, child: Text("getStatics")),
          ],
        ),
      )
    );
  }
}
