import 'package:flutter/material.dart';
import 'package:termproject/selectgroup.dart';
import 'server.dart';
import 'model/model.dart';
import 'package:image_picker/image_picker.dart';
import 'history.dart';
import 'chart.dart';
class APItestPage extends StatefulWidget {
  const APItestPage({Key? key}) : super(key: key);

  @override
  State<APItestPage> createState() => _APItestPageState();
}

class _APItestPageState extends State<APItestPage> {

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
                ServerApi.register("user9@gmail.com","pswd1234");
              });
            }, child: Text("register")),
            ElevatedButton(onPressed: () {
              setState(() async{
                UserToken usertoken = await ServerApi.login("user2","pswd1234");
                if(usertoken.token==null){
                  print("token null");
                }
                if(usertoken.pk==null){
                  print("pk null");
                }
              });
            }, child: Text("login")),
            ElevatedButton(onPressed: (){
              setState(() async{
                print(await ServerApi.getUser());

                ServerApi.changeprofile("바보똥꾸",2,"오늘 1234");
              });
            }, child: Text("changeProfile")),
            ElevatedButton(onPressed: (){
              setState((){
                Future<Profile> profile = ServerApi.getprofile();
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
              setState(() {
                ServerApi.getGroup();
              });
              setState(()async{
                await ServerApi.getGroup();
              });
            }, child: Text("getgroup")),

            ElevatedButton(onPressed: (){
              setState((){
                ServerApi.inviterequest("gnstjr12");
              });
            }, child: Text("inviterequest")),
            ElevatedButton(onPressed: (){
              setState((){
                ServerApi.checkinviterequest();
              });
            }, child: Text("checkrequest")),
            ElevatedButton(onPressed: (){
              setState((){
                    ServerApi.addmember(2);
              });
            }, child: Text("addmember")),
            ElevatedButton(onPressed: (){
              setState(()async {

                ServerApi.getmember();
              });
            }, child: Text("getmember")),
            ElevatedButton(onPressed: (){
              setState((){
                ServerApi.addroom(9,"엄마방",2,3);
              });

            }, child: Text("addroom")),
            ElevatedButton(onPressed: (){
              setState(() {
                Future<GETROOMLIST> getroomlist= ServerApi.getRoom();
              });
            }, child: Text("getroom")),
            ElevatedButton(onPressed: (){
              setState((){
                Future<Statics> statics = ServerApi.getStatics(1,null);
              });
            }, child: Text("getStatics")),
            ElevatedButton(onPressed: (){
              setState((){
                ServerApi.updatestatics();
              });
            }, child: Text("updateStatics")),
            ElevatedButton(onPressed: (){
              setState(()async {
                final ImagePicker _picker = ImagePicker();
                XFile? selectImage = await _picker.pickImage(
                  //이미지를 선택
                  source: ImageSource.gallery, //위치는 갤러리
                  maxHeight: 480,
                  maxWidth: 640,
                  imageQuality: 100, // 이미지 크기 압축을 위해 퀄리티를 30으로 낮춤.
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


            ElevatedButton(onPressed: (){
              setState((){
                //ServerApi.joingroup('gc02');
              });
            }, child: Text("joinGroup")),
            
            ElevatedButton(onPressed: (){
              setState((){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>HistoryPage(0)));
              });
            }, child: Text("gotoHistory")),
            ElevatedButton(onPressed: (){
              setState((){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>GroupSelectPage()));
              });
            }, child: Text("groupselect")),
            ElevatedButton(onPressed: (){
              setState((){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ChartListPage()));
              });
            }, child: Text("chartlistpage")),
            ElevatedButton(onPressed: (){
              setState((){
                ServerApi.groupScore();
              });
            }, child: Text("groupScore")),

          ],
        ),
      )
    );
  }
}
