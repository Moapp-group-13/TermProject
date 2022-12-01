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
      ),
      body: const RoomListPage(),
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
          appBar: AppBar(
            title: Text('Room',
              style: TextStyle(
                //fontFamily: "title2",
                //fontSize: 20,
                //fontWeight: FontWeight.bold,
              ),),
            backgroundColor: Colors.white,
            actions: [
              IconButton(
                onPressed: () {
                  setState(() {
                    Navigator.pushNamed(context, '/modify');
                  });
                },
                icon: const Icon(Icons.account_circle),
              )
            ],
          ),
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
                                  backgroundImage: IconList[snapshot!.data!.roomlist![index].lastHistory?.author!.icon??4], // 가장 최근 정보 사진 가져오기
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
                                        .nickname??"없음"}', //마지막으로 치운 사람
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
              Card(
                child: ListTile(
                  subtitle: IconButton(
                      splashRadius: 30,
                      iconSize: 50,
                      onPressed: () {},
                      icon: const Icon(
                        Icons.add,
                      )),
                  isThreeLine: true,
                ),
              ),
            ],

          )
      );
  }
}