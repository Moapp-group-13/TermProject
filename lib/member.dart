import 'package:flutter/material.dart';
import 'package:termproject/main.dart';
import 'register.dart';

class MemberPage extends StatefulWidget {
  const MemberPage({Key? key}) : super(key: key);

  @override
  State<MemberPage> createState() => _MemberPageState();
}
class _MemberPageState extends State<MemberPage> {
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
      body: ListView(
          children: [
            SizedBox(
              height: 20,
            ),

            ListTile(
              leading: CircleAvatar(
                radius:40,
                backgroundImage: AssetImage('loginimage.PNG'),
              ),
              title: Text('아빠',
                style: TextStyle(
                    fontSize: 20
                ),
              ),
              subtitle: Text('화장실 청소 해놨다',
              ),
              trailing: Text('2위'),
            ),
            ListTile(
              leading: CircleAvatar(
                radius:40,
                backgroundImage: AssetImage('loginimage.PNG'),
              ),
              title: Text('엄마',
                style: TextStyle(
                    fontSize: 20
                ),
              ),
              subtitle: Text('공주님 왕자님~ 방 청소 좀 하세요^^',
              ),
              trailing: Text('1위'),
            ),
            ListTile(
              leading: CircleAvatar(
                radius:40,
                backgroundImage: AssetImage('loginimage.PNG'),
              ),
              title: Text('딸',
                style: TextStyle(
                    fontSize: 20
                ),),
              subtitle: Text('시험공부중! 청소는 나중에',
              ),
              trailing: Text('3위'),
            ),ListTile(
              leading: CircleAvatar(
                radius:40,
                backgroundImage: AssetImage('loginimage.PNG'),
              ),
              title: Text('아들',
                style: TextStyle(
                    fontSize: 20
                ),),
              subtitle: Text('집에 안들어가요',
              ),
              trailing: Text('4위'),
            ),



          ],

      ),
    );
  }
}

class ModifyPage extends StatefulWidget {
  const ModifyPage({Key? key}) : super(key: key);

  @override
  State<ModifyPage> createState() => _ModifyPageState();
}

class _ModifyPageState extends State<ModifyPage> {

  final _formKey=GlobalKey<FormState>();
  String email='dkqk@gmail.com';
  String password='abcd1234';
  String userName='김아빠';
  String message='마음의 안식이 필요해';
  String alias='아빠다';
  final zone = ['거실','안방','주현이방','훈석이방'];
  var selectedZone = '안방';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //toolbarHeight: 80,
        backgroundColor: Colors.white,
        title: Text('회원정보수정'),

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key:_formKey,
          child: ListView(
            children: <Widget>[
              Center(
                child: Stack(
                    children:[
                      CircleAvatar(
                        radius: 70,
                        backgroundImage: AssetImage('default-image.png'),
                      ),
                      Positioned(
                          bottom:5,
                          right:5,
                          child: InkWell(
                            onTap:(){

                            },
                            child:Icon(
                              Icons.camera_alt,
                              size:40,
                              color: Colors.black12,
                            ),

                          ))
                    ]
                ),
              ),

              TextFormField(
                //obscureText: true,
                initialValue: userName,
                decoration: InputDecoration(
                    labelText: '이름'
                ),
                onChanged: (value){
                  userName=value;
                },
              ),
              TextFormField(
                initialValue: alias,
                decoration: InputDecoration(
                    labelText: '닉네임'
                ),
                onChanged: (value){
                  alias=value;
                },
              ),
              TextFormField(
                initialValue: email,
                decoration:InputDecoration(
                    labelText: '이메일'
                ),
                onChanged: (value){
                  email=value;
                },
              ),
              TextFormField(
                initialValue: password,
                obscureText: true,
                decoration: InputDecoration(
                    labelText: '비밀번호'
                ),
                onChanged: (value){
                  password=value;
                },
              ),
              TextFormField(
                initialValue: message,
                //obscureText: true,
                decoration: InputDecoration(
                    labelText: '상태 메시지'
                ),
                onChanged: (value){
                  message=value;
                },
              ),
              DropdownButtonFormField(

                  decoration:InputDecoration(

                    border:UnderlineInputBorder(),
                    labelText:selectedZone,
                  ),
                  items: zone.map(
                        (value){
                      return DropdownMenuItem(
                        value:value,
                        child: Text(value),
                      );
                    },
                  ).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedZone = value!;
                    });
                  }

              ),
              
              ElevatedButton(
                onPressed: () {},
                child: const Text('Enter'),

              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

