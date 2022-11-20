import 'dart:io';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'model/model.dart';
import 'dart:core';


/*
* 함수설명:
* getRoom:
* 
*
*
*
*
*
*
* */
Future<GETROOMLIST> getRoom(token,group) async {
  print("is this working?");
  try {
    Response response;
    var dio = Dio();
    dio.options.headers["authorization"] = "Token "+token;
    response = await dio.get('http://13.124.31.77/room/',queryParameters: {"group":group});

    // Map<String,dynamic> userMap = jsonDecode(response.data);
    var list = GETROOMLIST.fromJson(response.data);
    for(int i=0;i<list.roomlist!.length;i++){
      print("${list.roomlist![i].id} "
          "${list.roomlist![i].title} "
          "${list.roomlist![i].manager} "
          "${list.roomlist?[i].lastHistory?.author?.icon} "
          "${list.roomlist?[i].lastHistory?.author?.nickname} "
          "${list.roomlist?[i].lastHistory?.createDate} ");
    }
    return list;
  }on DioError catch (e) {
    return e.response!.data;
  }
}

void register(username,password) async {
  print("is this working?");
  Response response;
  try {
    var dio = Dio();
    var formData = FormData.fromMap({
      'username': username,
      'password': password,
    });

    response = await dio.post('http://13.124.31.77/users/register/',data: formData);
    print(response.data);
    print(response.data.toString());
  }on DioError catch (e) {
    print(e.response?.data.toString());
  }
}

Future<UserToken> login(username,password) async {
  print("is this working?");
  try {
    Response response;
    var dio = Dio();
    var formData = FormData.fromMap({
      'username': username,
      'password': password,
    });

    response = await dio.post('http://13.124.31.77/users/login/',data: formData);
    var usertoken=UserToken.fromJson(response.data);
    print("pk: ${usertoken.pk},token: ${usertoken.token}");
    return usertoken;
    // Map<String,dynamic> userMap = jsonDecode(response.data);
  }on DioError catch (e) {
    print(e);
    return e.response!.data;
  }
}

void changeprofile(nickname,icon,state_message,userpk,token) async{
  try{
    Response response;
    var dio = Dio();
    dio.options.headers["authorization"] = "Token "+token;
    var formData = FormData.fromMap({
      'nickname': nickname,
      'icon': icon,
      'state_message':state_message
    });

    response = await dio.put('http://13.124.31.77/users/profile/${userpk}/',data: formData);
    print(response.data.toString());
  }
  catch(e){
    print(e);
  }
}

Future<Profile> getprofile(userpk,token) async {
  print("is this working?");
  try {
    Response response;
    var dio = Dio();
    dio.options.headers["authorization"] = "Token "+token;
    response = await dio.get('http://13.124.31.77/users/profile/${userpk}/');
    var profile = Profile.fromJson(response.data);
    return profile;
    // Map<String,dynamic> userMap = jsonDecode(response.data);

  } catch (e) {
    print(e);
  }
  return Profile();
}

Future<Statics> getStatics(room,user) async {
  print("is this working?");
  try {
    Response response;
    var dio = Dio();
    response = await dio.get('http://13.124.31.77/statics/',queryParameters: {"room":room,"user":user});

    var statics = Statics.fromJson(response.data);
    for(int i=0;i<statics.liststatics!.length;i++){
      print("${statics.liststatics![i].user} ${statics.liststatics![i].room} ${statics.liststatics![i].score}");
    }
    return statics;

  }on DioError catch (e) {
    return e.response!.data;
  }
}
