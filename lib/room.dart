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
      Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height:20,
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
          height:20,
        ),
        Expanded(child: ListView(
          children: [
            const Card(
              child: ListTile(
                leading: CircleAvatar(
                  radius:50,
                  backgroundImage: AssetImage('father.PNG'),
                ),
                title: Text('거실',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                )),
                subtitle: Text(
                    '\n마지막으로 치운 사람: Daddy'
                ),
                trailing: Icon(Icons.more_vert),
                isThreeLine: true,
              ),
            ),
            const Card(
              child: ListTile(
                leading: CircleAvatar(
                  radius:50,
                  backgroundImage: AssetImage('mom.PNG'),
                ),
                title: Text('안방',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    )),
                subtitle: Text(
                    '\n마지막으로 치운 사람: Mom'
                ),
                trailing: Icon(Icons.more_vert),
                isThreeLine: true,
              ),
            ),
            const Card(
              child: ListTile(
                leading: CircleAvatar(
                  radius:50,
                  backgroundImage: AssetImage('son.PNG'),
                ),
                title: Text('부엌',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    )),
                subtitle: Text(
                    '\n마지막으로 치운 사람: Hyejun'
                ),
                trailing: Icon(Icons.more_vert),
                isThreeLine: true,
              ),
            ),
            const Card(
              child: ListTile(
                leading:  CircleAvatar(
                  radius:50,
                  backgroundImage: AssetImage('daughter.PNG'),
                ),
                title: Text('베란다',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    )),
                subtitle: Text(
                    '\n마지막으로 치운 사람: Joohyun'
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
    );
  }
}
