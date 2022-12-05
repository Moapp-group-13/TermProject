import 'package:flutter/material.dart';
import 'server.dart';
import 'model/model.dart';
class RoomTestPage extends StatefulWidget {
  const RoomTestPage({Key? key}) : super(key: key);

  @override
  State<RoomTestPage> createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomTestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'room',
          style: TextStyle(
            fontSize:20.0,
            fontWeight: FontWeight.bold,

          ),
        ),
        // actions: [
        //   IconButton(
        //     onPressed: (){
        //       setState(() {
        //         Navigator.pushNamed(context, '/roomadd');
        //       });
        //     },
        //     icon: const Icon(Icons.account_circle),
        //   )
        // ],
      ),
      body: const RoomListPage(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/roomadd');
        },
        backgroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class User {
  const User(this.name);
  final String name;
}
//
// class AddId extends StatefulWidget {
//   State createState() => AddIdState();
// }
//
// class AddIdState extends State<AddId> {
//   Future<InviteCheck>? getmember;
//
//
//   @override
//   void initState() {
//     super.initState();
//     getmember = ServerApi.getmember();
//   }
//
//   String id='1';
//   //User selectedUser;
//   List<User> users = <User>[User('Foo'), User('Bar')];
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: FutureBuilder<InviteCheck>(
//             future: getmember,
//             builder: (context, snapshot) {
//               if(snapshot.hasData){
//                 return Expanded(
//                     child: ListView.builder(
//                         itemCount: snapshot.data!.memberList!.length,
//                         itemBuilder: (context, index) {
//                           return Center(
//                             child: DropdownButton(
//                               hint: Text("Select a user"),
//                               value: id,
//                               onChanged: (newValue) {
//                                 setState(() {
//                                   id = newValue as String;
//                                 });
//                               },
//                               items: snapshot.data!.memberList?.map(
//                                       (Member member) {
//                                     return DropdownMenuItem(
//                                         value: member.user?.id,
//                                         child: Text(member.nickname!)
//                                     );
//                                   }
//                               ).toList(),
//                             ),
//                           );
//                         }));
//               }
//               else if(snapshot.hasError){
//                 return Text("error");
//               }
//               return CircularProgressIndicator();
//
//             }
//         ),
//
//       ),
//     );
//   }
// }

class AddRoomPage extends StatefulWidget {
  const AddRoomPage({Key? key}) : super(key: key);

  @override
  State<AddRoomPage> createState() => _AddRoomPageState();
}

class _AddRoomPageState extends State<AddRoomPage> {
  //addRoom(담당유저id,방이름,크기(청소량),청소주기): 방 생성함
  Member? SelectedMember;       //담당유저id
  String roomname = ''; //방이름
  int amount = 0;       //청소량
  int cycle = 0;        //청소주기
  Future<InviteCheck>? getmember;

  @override
  void initState() {
    super.initState();
    getmember = ServerApi.getmember();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      appBar: AppBar(
        title: const Text('TextField'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                // AddId(),
                FutureBuilder<InviteCheck>(
                    future: getmember,
                    builder: (context, snapshot) {


                      if(snapshot.hasData){
                        return DropdownButton(
                            value: SelectedMember,
                            //배열 이용
                            items: snapshot.data!.memberList?.map(
                                    (Member member) {
                                  return DropdownMenuItem<Member>(
                                      value: member,
                                      child: Text("${member.nickname!}")
                                  );
                                }
                            ).toList(),
                            onChanged: (value){
                              setState(() {
                                SelectedMember = value!;
                                print(SelectedMember);
                              });
                            },
                          );
                      }
                      else if(snapshot.hasError){
                        return Text("error");
                      }
                      return CircularProgressIndicator();

                    }
                    ),
                Container(
                  width: 300.0,
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: '방 이름 ',
                    ),
                    onChanged: (value){
                      roomname=value;
                    },
                  ),
                ),
                Container(
                  width: 300.0,
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: '청소량 ',
                    ),
                    onChanged: (value){
                      amount=int.parse(value);
                    },
                  ),
                ),
                Container(
                  width: 300.0,
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: '청소주기 ',
                    ),
                    onChanged: (value){
                      cycle=int.parse(value);
                    },
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton (
                    onPressed: () async{
                      //addRoom(담당유저id,방이름,크기(청소량),청소주기): 방 생성함
                      // ServerApi.addroom(9,"엄마방",2,3);
                      await ServerApi.addroom(SelectedMember!.user!.id!,roomname,amount,cycle);
                      // Navigator.pop(context);
                    },
                    child: const Text('Enter')),
              ],
            ),
          ),

        ),
      ),
    );
  }
}


//청소해야 할 구역을 지정
class RoomListPage extends StatefulWidget {
  const RoomListPage({Key? key}) : super(key: key);

  @override
  State<RoomListPage> createState() => _RoomListPageState();
}

class _RoomListPageState extends State<RoomListPage> {
  Future<GETROOMLIST>? roomlist; //룸리스트 퓨쳐 변수로 정의
  List<AssetImage> IconList=[AssetImage('1.PNG'),AssetImage('2.PNG'),AssetImage("3.PNG"),AssetImage("4.PNG"),AssetImage("loginimage.PNG")];
  @override
  void initState() {
    roomlist = ServerApi.getRoom(); //퓨쳐값 서버에서 받아오기
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15,
              ),
              const Text(
                '     청소해야할 구역을 지정해주세요',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              FutureBuilder(future: roomlist,
                builder: (context, snapshot) { //퓨처빌더로 퓨처값 가져오기
                  if (snapshot.hasData) {
                    return Expanded(child: ListView.builder( //리스트뷰 빌더로 리스트 생성
                        itemCount: snapshot.data!.roomlist!.length!,
                        //데이터 길이 가져오기
                        itemBuilder: (context, index) {
                          return Card(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                              child: ListTile(
                                leading: CircleAvatar(
                                  radius: 30,
                                  backgroundImage: IconList[snapshot!.data!.roomlist![index].manager!.icon!], // 가장 최근 정보 사진 가져오기
                                ),
                                title: Text(
                                    snapshot.data!.roomlist![index].title!,
                                    //방이름 가져오기
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    )),
                                subtitle: Text(
                                    '마지막으로 치운 사람: ${snapshot.data!
                                        .roomlist![index].lastHistory?.author!
                                        .nickname??"없음"} 담당: ${snapshot.data!
                                    .roomlist![index].manager!.nickname!}', //마지막으로 치운 사람
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    )

                                ),
                                trailing: Icon(Icons.more_vert),
                                isThreeLine: true,
                              ),
                            ),);
                        }
                    )
                    );
                  } else if (snapshot.hasError) {
                    return Text("error");
                  }
                  return CircularProgressIndicator();
                },
              ),
            ],

          )
      );
  }
}