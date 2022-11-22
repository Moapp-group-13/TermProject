import 'package:flutter/material.dart';
import 'main.dart';
import 'register.dart';

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
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Image.asset(
              'loginimage.PNG',
              width:200,
              height:300,
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'LOGIN',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )),

            const SizedBox(
              height: 30,
            ),

            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: idController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'ID',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
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
              height: 30,
            ),

            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: const Text('LOGIN', style: TextStyle(fontSize:18)),
                  onPressed: () {
                    print(idController.text);
                    print(passwordController.text);
                  },
                )
            ),
            const SizedBox(
              height: 30,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextButton(
                  child: const Text(
                    '회원가입',
                    style: TextStyle(fontSize: 15),
                  ),
                  onPressed: () {
                    setState(() {
                      Navigator.push(context,MaterialPageRoute(
                          builder: (context)=>RegisterPage()));
                    });

                    //signup screen
                  },
                )
              ],
            ),
          ],
        ));
  }
}