import 'package:flutter/material.dart';
import 'package:termproject/selectgroup.dart';
import 'package:termproject/server.dart';
import 'main.dart';
import 'model/model.dart';


class GroupChoicePage extends StatefulWidget {
  const GroupChoicePage({Key? key}) : super(key: key);

  @override
  State<GroupChoicePage> createState() => _GroupChoicePageState();
}

class _GroupChoicePageState extends State<GroupChoicePage> {
  final _formKey=GlobalKey<FormState>();
  String groupCode = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('그룹 가입'),
        backgroundColor: Colors.white,
      ),
      body:Padding(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: groupCode,
                decoration: InputDecoration(
                  labelText: '그룹코드',

                ),
                validator: (value){
                  if(value == null || value.isEmpty){
                    return '그룹코드를 입력해주세요.';
                  }

                  return null;

                },
                onChanged: (value){
                  setState(() {
                    groupCode=value;
                  });
                },
              ),
              //해당 그룹이 있으면 ㅇㅇㅇ 그룹이 맞나요? -> yes 가입을 축하합니다
              //다시 그룹코드 입력하기 or
              //없는 그룹입니다. 그룹 생성 또는 다시 입력해주세요
              ElevatedButton (

                onPressed: () async{
                  setState(() async {

                    if(_formKey.currentState!.validate()){
                      await ServerApi.joingroup(groupCode);
                      Navigator.pushNamed(context, '/gs');
                    }






                  });
                },
                child: const Text('Enter',
                style: TextStyle(
                 // color: Colors.white
                ),),

              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(' '),
                  TextButton(
                    child:Text('그룹 생성하기'),
                    onPressed: (){
                      Navigator.pushNamed(context, '/gm');
                    },
                  )
                ],
              )
            ],

          ),
        ),
      ),
    );
  }
}
class GroupMakePage extends StatefulWidget {
  const GroupMakePage({Key? key}) : super(key: key);

  @override
  State<GroupMakePage> createState() => _GroupMakePageState();
}

class _GroupMakePageState extends State<GroupMakePage> {
  final _formKey=GlobalKey<FormState>();
  String groupCode = '';
  String groupName = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('그룹 생성'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: '그룹코드',
                ),
                onChanged: (value){
                  setState(() {
                    groupCode=value;
                  });
                },
                validator: (value){
                  if(value == null || value.isEmpty){
                    return '그룹코드를 입력해주세요.';
                  }
                  
                  return null;

                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: '그룹이름',
                ),

                onChanged: (value){
                  setState(() {
                    groupName=value;
                  });
                },
                validator: (value){
                  if(value == null || value.isEmpty){
                    return '그룹이름을 입력해주세요.';
                  }
                  else if(value.length>=10){
                    return '10글자 미만으로 입력해주세요.';
                  }
                  return null;

                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: '그룹 정원',//없어도되나?
                ),
                onChanged: (value){
                  setState(() {
                    //groupName=value;
                  });
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  setState(() async{

                    if(_formKey.currentState!.validate()){
                      await ServerApi.createGroup(groupCode, groupName);
                      Navigator.pushNamed(context, '/gc');
                    }

                  });

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