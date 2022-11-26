import 'package:flutter/material.dart';
import 'package:termproject/server.dart';
import 'member.dart';
class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: const RegisterForm(),
    );
  }
}


class RegisterForm extends StatefulWidget {//사진아이콘넣기
  const RegisterForm({Key? key}) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {

  final _formKey=GlobalKey<FormState>();
  String email='';
  String password='';
  String userName='';
  String message='';
  String alias='';
  final zone = ['거실','안방','주현이방','훈석이방'];
  var selectedZone = '미정';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //toolbarHeight: 80,
        backgroundColor: Colors.white,
        title: Text('회원가입'),

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
                      radius: 50,
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
                decoration: InputDecoration(
                    labelText: '이름'
                ),
                onChanged: (value){
                  userName=value;
                },
              ),
              TextFormField(
                //obscureText: true,
                decoration: InputDecoration(
                    labelText: '닉네임'
                ),
                onChanged: (value){
                  alias=value;
                },
              ),
              TextFormField(
                decoration:InputDecoration(
                    labelText: '이메일'
                ),
                onChanged: (value){
                  email=value;
                },
              ),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                    labelText: '비밀번호'
                ),
                onChanged: (value){
                  password=value;
                },
              ),
              TextFormField(
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
                  labelText:'담당 구역을 정해주세요',
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
                onPressed: () async{
                  await ServerApi.register(userName, password);
                  await ServerApi.login(userName, password);
                  await ServerApi.changeprofile(alias,1,message);
                  ServerApi.logout();
                },
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