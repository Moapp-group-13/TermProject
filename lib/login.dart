import 'package:flutter/material.dart';
import 'package:termproject/group.dart';
import 'main.dart';
import 'register.dart';
import 'server.dart';
import 'package:termproject/model/model.dart';
import 'selectgroup.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Log In';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const LoginPage(),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: ListView(
            children: <Widget>[
              Image.asset(
                'loginimage.PNG',
                width:190,
                height:300,
              ),

              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(0),
                  child: const Text(
                    'LOGIN',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 30),
                  )),

              const SizedBox(
                height: 15,
              ),

              Container(
                padding: const EdgeInsets.all(6),
                child: TextField(
                  controller: idController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'ID',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(6),
                child: TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'PASSWORD',
                  ),
                ),
              ),

              const SizedBox(
                height: 15,
              ),

            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: const Text('로그인', style: TextStyle(fontSize:18)),
                  onPressed: () {
                    setState(() async{
                      UserToken usertoken = await ServerApi.login(idController.text,passwordController.text);

                      //아이디, 비번 틀렸을 때
                      if(usertoken.token==null){
                        showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: 200,
                              color: Colors.white70,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    const Text('Invalid id or password! Try Again', style: TextStyle(fontSize: 20),),
                                    SizedBox(height: 20,),
                                    ElevatedButton(
                                      child: const Text('Retry', style: TextStyle(fontSize: 16)),
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                        print("Invalid id or pwd");
                      }
                      else{ //아이디, 비밀번호 맞게 쳤을 때

                        //String? InGroup = await ServerApi.storage.read(key: "groupid");
                        //사용자가 그룹등록을 아직 안한 상태라면
                        //print('Ingroup: ${InGroup}');
                        //Navigator.pushNamed(context, '/home');
                        //if(InGroup==null){
                          //Navigator.pushNamed(context, '/gc');
                          // Navigator.push(context,MaterialPageRoute(
                          // builder: (context)=>GroupChoicePage()));

                        //}
                        // else{
                           Navigator.pushNamed(context, '/gs');
                        //  }

                      }
                      //Navigator.pushNamed(context, '/gs');
                      idController.clear();
                      passwordController.clear();
                    });
                  },
                )
            ),
            const SizedBox(
              height: 15,
            ),
             

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextButton(
                    child: const Text(
                      '회원가입',
                      style: TextStyle(fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      setState(() async{
                        //Future<MyGroup> mg = ServerApi.getGroup();

                        Navigator.push(context,MaterialPageRoute(
                            builder: (context)=>RegisterPage()));
                      });

                      //signup screen
                    },
                  )
                ],
              ),
            ],
          )),
    );
  }
}

