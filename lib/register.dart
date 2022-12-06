import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:termproject/server.dart';
import 'model/model.dart';
import 'package:termproject/providerclass.dart';
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
  int icon=0;

  @override
  Widget build(BuildContext context) {
    //int? args = ModalRoute.of(context)?.settings.arguments as int?;
    //print(context.read<Iconing>().icon);
    //if(args!=null) icon=args;
    icon = Provider.of<Iconing>(context).getCount();
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
                      children: [
                        CircleAvatar(
                          radius: 70,
                          backgroundImage: AssetImage(
                              '${context.read<Iconing>().icon.toString()}.PNG'),
                        ),
                        Positioned(
                            bottom: 5,
                            right: 5,
                            child: InkWell(

                              onTap: () {
                                Navigator.pushNamed(context, '/icr');

                              },
                              child: Icon(
                                Icons.camera_alt,
                                size: 40,
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

                    await ServerApi.changeprofile(alias,icon, message);
                    ServerApi.logout();
                    Navigator.of(context).popUntil((route) => route.isFirst);
                    Navigator.pushNamed(context, '/login');
                  },
                  child: const Text('Enter'),
                ),
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
  Future<Profile>? profile;

  @override
  void initState(){
    super.initState();
    profile = ServerApi.getprofile();

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
          future: profile,
          builder: (context,snapshot){
            if(snapshot.hasData) {
              var args = ModalRoute.of(context)?.settings.arguments;

              String? id = snapshot?.data?.user?.username;
              String? password = '********';
              String? message = snapshot?.data?.stateMessage;
              String? alias = snapshot?.data?.nickname;
              int? icon = snapshot?.data?.icon;
              if(args!=null) icon=args as int?;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: <Widget>[
                      Center(
                        child: Stack(
                            children: [
                              CircleAvatar(
                                radius: 70,
                                backgroundImage: AssetImage(
                                    '${icon}.PNG'),
                              ),
                              Positioned(
                                  bottom: 5,
                                  right: 5,
                                  child: InkWell(

                                    onTap: () {
                                      Navigator.pushNamed(context, '/icm');

                                    },
                                    child: Icon(
                                      Icons.camera_alt,
                                      size: 40,
                                      color: Colors.black12,
                                    ),

                                  ))
                            ]
                        ),
                      ),



                      TextFormField(

                        style: TextStyle(fontWeight: FontWeight.bold),
                        initialValue: id,
                        decoration: InputDecoration(
                            labelText: '아이디'
                        ),
                        onChanged: (value) {
                          id = value;
                        },
                      ),
                      TextFormField(

                        style: TextStyle(fontWeight: FontWeight.bold),
                        initialValue: password,
                        //obscureText: true,
                        decoration: InputDecoration(
                            labelText: '비밀번호'
                        ),
                        onChanged: (value) {
                          password = value;
                        },
                      ),
                      TextFormField(

                        style: TextStyle(fontWeight: FontWeight.bold),
                        initialValue: alias,
                        decoration: InputDecoration(
                            labelText: '닉네임'
                        ),
                        onChanged: (value) {
                          alias = value;
                        },
                      ),
                      TextFormField(

                        style: TextStyle(fontWeight: FontWeight.bold),
                        initialValue: message,
                        //obscureText: true,
                        decoration: InputDecoration(
                            labelText: '상태 메시지'
                        ),
                        onChanged: (value) {
                          message = value;
                        },
                      ),
                      /*
                      TextFormField(
                        initialValue: '그룹코드 입력',
                        //obscureText: true,
                        decoration: InputDecoration(
                            labelText: '그룹 코드'
                        ),
                        onChanged: (value) {
                          //message = value;


                        },
                      ),

                       */


                      ElevatedButton(
                        onPressed: () async{
                          setState(() async {
                            await ServerApi.changeprofile(alias, icon, message);
                            Navigator.popAndPushNamed(context, '/home');

                          });

                          },
                        child: const Text('수정'),


                      ),
                      ElevatedButton(
                        onPressed: () async{
                          setState(() async {
                            Navigator.popAndPushNamed(context, '/gs');

                          });

                        },
                        child: const Text('그룹 재선택'),

                      ),
                      ElevatedButton(
                        onPressed: () async{
                          ServerApi.logout();
                          //Navigator.pushNamed(context, '/h');
                          Navigator.pop(context);
                          Navigator.pushNamed(context, '/login');

                        },
                        child: const Text('로그아웃'),

                      ),

                    ],
                  ),

                ),

              );
            }
            return CircularProgressIndicator();
          },

        ),

    );
  }
}
class IconChoiceRegister extends StatefulWidget {
  const IconChoiceRegister({Key? key}) : super(key: key);

  @override
  State<IconChoiceRegister> createState() => _IconChoiceRegisterState();
}

class _IconChoiceRegisterState extends State<IconChoiceRegister> {

  @override
  Widget build(BuildContext context) {
    //int args = ModalRoute.of(context)?.settings.arguments as int;
    return Scaffold(
        appBar: AppBar(
          title: Text('아이콘 선택'),
          backgroundColor: Colors.white,
        ),
        body: GridView.count(
            crossAxisCount: 3,
            children: List.generate(6, (i) =>
                IconButton(
                  padding: EdgeInsets.all(10),
                  iconSize: 50,
                  onPressed: () {
                    setState(() {
                      context.read<Iconing>().changeIcon(i+1);
                      Navigator.pop(context);
                    });


                  },
                  icon: CircleAvatar(
                    backgroundImage: AssetImage('${i+1}.PNG'),
                    radius: 50,
                  ),
                )
            ).toList(),
          ),
    );
  }
}

class IconChoiceModify extends StatefulWidget {
  const IconChoiceModify({Key? key}) : super(key: key);

  @override
  State<IconChoiceModify> createState() => _IconChoiceModifyState();
}

class _IconChoiceModifyState extends State<IconChoiceModify> {

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments;
    return Scaffold(
        appBar: AppBar(
          title: Text('아이콘 선택'),
          backgroundColor: Colors.white,
        ),
        body:GridView.count(
          crossAxisCount: 3,
          children: List.generate(6, (i) =>
              IconButton(
                //selectedIcon: Icon(Icons.favorite),


                //splashRadius: 30,
                padding: EdgeInsets.all(10),
                iconSize: 50,
                onPressed: () {
                  setState(() {
                    args=i+1;
                    Navigator.pushNamed(context, '/m', arguments: args);
                  });


                },
                icon: CircleAvatar(
                  backgroundImage: AssetImage('${i+1}.PNG'),
                  radius: 50,
                ),

              )
          ).toList(),
        )
    );
  }
}