import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //toolbarHeight: 80,
        backgroundColor: Colors.white,
        title: Text('회원가입'),
        actions: [
          IconButton(
            onPressed: (){
              setState(() {
                Navigator.push(context,MaterialPageRoute(
                    builder: (context)=>SecondPage()));
              });
            },
            icon: const Icon(Icons.account_circle),
          )
        ],

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(

          key:_formKey,
          child: ListView(
            children: <Widget>[

              SizedBox(
                height: 10,
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

              TextFormField(
                //obscureText: true,
                decoration: InputDecoration(
                    labelText: '구역'
                ),
                onChanged: (value){
                  //message=value;
                  //드롭다운으로 바꾸기
                },

              ),
              SizedBox(
                height: 20,
              ),

              ElevatedButton(
                onPressed: () {},
                child: const Text('Enter'),

              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  /*
                  Text('If you already registered your email, '),
                  TextButton(
                    child:Text('Login with your email.'),
                    onPressed: (
                        ){
                      Navigator.pop(context);
                    },
                  )
                  */

                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
