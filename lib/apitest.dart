import 'package:flutter/material.dart';
import 'server.dart';
import 'model/model.dart';
import 'package:image_picker/image_picker.dart';
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
        child: Wrap(
          spacing: 10,
          children: [
            ElevatedButton(onPressed: (){
              setState(() {
                ServerApi.register("user9","pswd1234");
              });
            }, child: Text("register")),
            ElevatedButton(onPressed: (){
              setState(() {
                Future<UserToken> usertoken = ServerApi.login("user9","pswd1234");
              });
            }, child: Text("login")),
            ElevatedButton(onPressed: (){
              setState(() {
                ServerApi.changeprofile("바보똥꾸",2,"오늘 힘들다");
              });
            }, child: Text("changeProfile")),
            ElevatedButton(onPressed: (){
              setState((){
                Future<Profile> profile = ServerApi.getprofile(9);
                profile.then((profile)=>print("${profile.nickname}${profile.icon}${profile.user!.username}${profile.stateMessage}"));
              });
            }, child: Text("getProfile")),
            ElevatedButton(onPressed: (){
              setState((){
                ServerApi.logout();
              });
            }, child: Text("logout")),
            ElevatedButton(onPressed: (){
              setState((){
                ServerApi.createGroup("gnstjr12", "멋진 우리집");
              });
            }, child: Text("creategroup")),
            ElevatedButton(onPressed: (){
              setState((){
                ServerApi.getGroup();
              });
            }, child: Text("getgroup")),
            ElevatedButton(onPressed: (){
              setState((){
                ServerApi.inviterequest("gnstjr12");
              });
            }, child: Text("inviterequest")),
            ElevatedButton(onPressed: (){
              setState((){
                ServerApi.checkinviterequest(6);
              });
            }, child: Text("checkrequest")),
            ElevatedButton(onPressed: (){
              setState((){
                    ServerApi.addmember(5,9);
              });
            }, child: Text("addmember")),
            ElevatedButton(onPressed: (){
              setState((){
                ServerApi.getmember(6);
              });
            }, child: Text("getmember")),
            ElevatedButton(onPressed: (){
              setState((){
                ServerApi.addroom(6,9,"엄마방",2,4);
              });

            }, child: Text("addroom")),
            ElevatedButton(onPressed: (){
              setState(() {
                Future<GETROOMLIST> getroomlist= ServerApi.getRoom(6);
              });
            }, child: Text("getroom")),
            ElevatedButton(onPressed: (){
              setState((){
                Future<Statics> statics = ServerApi.getStatics(1,null);
              });
            }, child: Text("getStatics")),
            ElevatedButton(onPressed: (){
              setState((){
                ServerApi.updatestatics(6);
              });
            }, child: Text("updateStatics")),
            ElevatedButton(onPressed: (){
              setState(()async {
                final ImagePicker _picker = ImagePicker();
                XFile? selectImage = await _picker.pickImage(
                  //이미지를 선택
                  source: ImageSource.gallery, //위치는 갤러리
                  maxHeight: 75,
                  maxWidth: 75,
                  imageQuality: 30, // 이미지 크기 압축을 위해 퀄리티를 30으로 낮춤.
                );
                if (selectImage != null) {
                  dynamic sendData = selectImage.path;
                  ServerApi.posthistory(4,0,sendData,"방청소 했어요~ 용돈 올려주세요!! :>");
                }
              });
            }, child: Text("post history")),
            ElevatedButton(onPressed: (){
              setState((){
                ServerApi.gethistory(4);
              });
            }, child: Text("gethistory")),

    ],
        ),
      )
    );
  }
}
