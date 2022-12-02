import 'package:flutter/material.dart';

class Cleaning with ChangeNotifier{
  //room page 에 필요한 정보들
  List<String> Room = [];
  List<String> LastPerson = [];

}
class Iconing with ChangeNotifier{
  int icon=0;
  void changeIcon(int key){
    this.icon=key;
  }
}
