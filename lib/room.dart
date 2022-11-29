import 'package:flutter/material.dart';

class RoomPage extends StatefulWidget {
  const RoomPage({Key? key}) : super(key: key);

  @override
  State<RoomPage> createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'room',
          style: TextStyle(
            fontSize:30.0,
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
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: AppBar(
          title: Text('Room',
            style: TextStyle(
              fontFamily: "title2",
              fontSize: 30,
              //fontWeight: FontWeight.bold,
            ),),
          backgroundColor: Colors.white,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height:18,
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
            height:18,
          ),
          Expanded(child: ListView(
            children: [
              const Card(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius:30,
                      backgroundImage: AssetImage('1.PNG',),
                    ),
                    title: Text('거실',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        )),
                    subtitle: Text(
                        '마지막으로 치운 사람: Daddy',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        )

                    ),
                    trailing: Icon(Icons.more_vert),
                    isThreeLine: true,
                  ),
                ),
              ),
              const Card(
                child: ListTile(
                  leading: CircleAvatar(
                    radius:30,
                    backgroundImage: AssetImage('2.PNG'),
                  ),
                  title: Text('안방',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      )),
                  subtitle: Text(
                      '마지막으로 치운 사람: Mom',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      )
                  ),
                  trailing: Icon(Icons.more_vert),
                  isThreeLine: true,
                ),
              ),
              const Card(
                child: ListTile(
                  leading: CircleAvatar(
                    radius:30,
                    backgroundImage: AssetImage('3.PNG'),
                  ),
                  title: Text('부엌',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      )),
                  subtitle: Text(
                      '마지막으로 치운 사람: Hyejun',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      )
                  ),
                  trailing: Icon(Icons.more_vert),
                  isThreeLine: true,
                ),
              ),
              const Card(
                child: ListTile(
                  leading:  CircleAvatar(
                    radius:30,
                    backgroundImage: AssetImage('4.PNG'),
                  ),
                  title: Text('베란다',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      )),
                  subtitle: Text(
                      '마지막으로 치운 사람: Joohyun',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      )
                  ),
                  trailing: Icon(Icons.more_vert),
                  isThreeLine: true,
                ),
              ),
              Card(
                child: ListTile(
                  subtitle: IconButton(
                      splashRadius: 30,
                      iconSize: 50,
                      onPressed: (){},
                      icon: const Icon(
                        Icons.add,
                      )),
                  isThreeLine: true,
                ),
              ),
            ],

          )
          ),

        ],
    ),
      );
  }
}
