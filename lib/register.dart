import 'package:flutter/material.dart';
import 'package:termproject/server.dart';
import 'member.dart';
import 'model/model.dart';
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
  String id='';
  String password='';
  String userName='';
  String message='';
  String alias='';

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
                decoration:InputDecoration(
                    labelText: '아이디'
                ),
                onChanged: (value){
                  id=value;
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
                    labelText: '닉네임'
                ),
                onChanged: (value){
                  alias=value;
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


              ElevatedButton (
                onPressed: () async{
                  await ServerApi.register(id, password);
                  await ServerApi.login(id, password);
                  await ServerApi.changeprofile(alias, '2', message);
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

class ModifyPage extends StatefulWidget {
  const ModifyPage({Key? key}) : super(key: key);

  @override
  State<ModifyPage> createState() => _ModifyPageState();
}

class _ModifyPageState extends State<ModifyPage> {

  final _formKey=GlobalKey<FormState>();
  Future<Profile>? getprofile;

  //late final String? userpk;

  //List<AssetImage> IconList=[AssetImage('rabitIcon.PNG'),AssetImage('rabitIcon.PNG'),AssetImage("loginimage.PNG")];

  @override
  void initState() async{
    super.initState();
    String? userpk = await ServerApi.getUser();
    //userpk = await ServerApi.getUser();
    getprofile = ServerApi.getprofile(userpk);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //toolbarHeight: 80,
        backgroundColor: Colors.white,
        title: Text('회원정보수정'),

      ),
      body: FutureBuilder<Profile>(
        future: getprofile,
        builder: (context,snapshot){
          String email='dkqk@gmail.com';
          String password='abcd1234';
          //String userName=snapshot.data!.user! as String;
          String userName='name';
          String message='마음의 안식이 필요해';
          String alias=snapshot.data!.nickname!;
          return Padding(
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
            );
            return Text('');

        },
      )
    );
  }
}

