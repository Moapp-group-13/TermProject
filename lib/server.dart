import 'dart:io';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'model/model.dart';
import 'dart:core';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
/*
* 함수설명:
* register(아이디,비밀번호): 아이디 등록
* login(아이디,비밀번호): 로그인 token값 storage에 자동저장
* logout(): storage의 토큰과 userpk 삭제
* changeprofile(닉네임,아이콘 번호,상태메세지): 자기 프로필 변경
* getprofile(유저pk): 해당 유저 프로필 보기
* getStatics(룸pk,유저pk): 룸pk작성 유저 null ==> 룸에 따른 유저 기여내역 가져옴. 룸null ,유저pk => 유저별 방에 따른 기여내역
* createGroup(그룹id,그룹명): 그룹 생성
* getGroup(): 현재 자신이 속한 그룹들 정보 가져옴.
* inviterequest(그룹코드): 해당 그룹 코드를 지닌 그룹에게 초대 요청 보내기
* checkinviterequest(그룹id): 해당 그룹의 초대요청목록 확인하기
* addmember(그룹id,유저pk): 해당그룹에 유저 추가 시킴 (그룹장만 권한가지고 있음)
* getmember(그룹id): 해당그룹에 해당하는 유저 정보를 가져옴.
* addRoom(그룹id,담당유저id,방이름,크기(청소량),청소주기): 방 생성함 (그룹장만 권한 가지고 있음)
* getRoom(그룹pk): 해당 그룹 방 목록 + 방별 가장 최근 청소내역 가져옴.
* updatestatics(그룹id): 해당그룹 통계 업데이트
* posthistory(룸id,이벤트(0청소,1불만,2논의),사진경로,텍스트): history 업로드
* gethistory(룸id) 해당 룸id의 히스토리 배열 가져옴
*
* */

class ServerApi {

  static final storage = FlutterSecureStorage();

  static void storeToken(userpk,String Token) async{
    await storage.write(key:"user",value: userpk);
    await storage.write(key: "token", value: Token);
  }

  static Future<String?> getToken()async{
    return await storage.read(key: "token");
  }
  static Future<String?> getUser()async{
    return await storage.read(key: "user");
  }
  static Future<GETROOMLIST> getRoom(group) async {
    try {
      Response response;
      var dio = Dio();
      String? token = await getToken();
      dio.options.headers["authorization"] = "Token " + token!;
      response = await dio.get(
          'http://13.124.31.77/room/', queryParameters: {"group": group});

      // Map<String,dynamic> userMap = jsonDecode(response.data);
      var list = GETROOMLIST.fromJson(response.data);
      for (int i = 0; i < list.roomlist!.length; i++) {
        print("${list.roomlist![i].id} "
            "${list.roomlist![i].title} "
            "${list.roomlist![i].manager} "
            "${list.roomlist?[i].lastHistory?.author?.icon} "
            "${list.roomlist?[i].lastHistory?.author?.nickname} "
            "${list.roomlist?[i].lastHistory?.createDate} ");
      }
      return list;
    } on DioError catch (e) {
      return e.response!.data;
    }
  }

  static void register(username, password) async {
    Response response;
    try {
      var dio = Dio();
      var formData = FormData.fromMap({
        'username': username,
        'password': password,
      });

      response =
      await dio.post('http://13.124.31.77/users/register/', data: formData);
      print(response.data);
      print(response.data.toString());
    } on DioError catch (e) {
      print(e.response?.data.toString());
    }
  }

  static Future<UserToken> login(username, password) async {
    try {
      Response response;
      var dio = Dio();
      var formData = FormData.fromMap({
        'username': username,
        'password': password,
      });

      response =
      await dio.post('http://13.124.31.77/users/login/', data: formData);
      var usertoken = UserToken.fromJson(response.data);
      print("pk: ${usertoken.pk},token: ${usertoken.token}");

      storeToken(usertoken.pk.toString(),usertoken.token!);

      return usertoken;
      // Map<String,dynamic> userMap = jsonDecode(response.data);
    } on DioError catch (e) {
      print(e);
      return e.response!.data;
    }
  }
  static void logout(){
    storage.delete(key: "token");
    storage.delete(key: "userpk");
    print(storage.read(key: "token").runtimeType);
  }
  static void changeprofile(nickname, icon, state_message) async {
    try {
      Response response;
      var dio = Dio();
      String? token = await getToken();
      dio.options.headers["authorization"] = "Token " + token!;
      var formData = FormData.fromMap({
        'nickname': nickname,
        'icon': icon,
        'state_message': state_message
      });
      String? userpk = await getUser();
      response = await dio.put(
          'http://13.124.31.77/users/profile/${userpk!}/', data: formData);
      print(response.data.toString());
    }
    catch (e) {
      print(e);
    }
  }

  static Future<Profile> getprofile(userpk) async {
    try {
      Response response;
      var dio = Dio();
      String? token = await getToken();
      dio.options.headers["authorization"] = "Token " + token!;
      response = await dio.get('http://13.124.31.77/users/profile/${userpk}/');
      var profile = Profile.fromJson(response.data);
      return profile;
      // Map<String,dynamic> userMap = jsonDecode(response.data);

    } catch (e) {
      print(e);
    }
    return Profile();
  }

  static Future<Statics> getStatics(room, user) async {
    try {
      Response response;
      var dio = Dio();
      response = await dio.get('http://13.124.31.77/statics/',
          queryParameters: {"room": room, "user": user});

      var statics = Statics.fromJson(response.data);
      for (int i = 0; i < statics.liststatics!.length; i++) {
        print("${statics.liststatics![i].user} ${statics.liststatics![i]
            .room} ${statics.liststatics![i].score}");
      }
      return statics;
    } on DioError catch (e) {
      return e.response!.data;
    }
  }
  static void createGroup(groupcode, title) async{
    Response response;
    try {
      var dio = Dio();
      String? token = await getToken();
      dio.options.headers["authorization"] = "Token " + token!;
      var formData = FormData.fromMap({
        'groupcode': groupcode,
        'title': title,
      });
      response =
          await dio.post('http://13.124.31.77/group/', data: formData);
      print(response.data);
    } on DioError catch (e) {
      print(e.response?.data.toString());
    }
  }
  static Future<MyGroup> getGroup() async{
    Response response;
    try {
      var dio = Dio();
      String? token = await getToken();
      dio.options.headers["authorization"] = "Token " + token!;
      response = await dio.get('http://13.124.31.77/group/');
      var myGroup = MyGroup.fromJson(response.data);
      for (int i = 0; i < myGroup.groupList!.length; i++) {
        print("${myGroup.groupList![i].groupcode}${myGroup.groupList![i].title}");
      }
      return myGroup;
    }on DioError catch(e){
      return e.response!.data;
    }
}

  static void inviterequest(groupcode) async{
    Response response;
    try {
      var dio = Dio();
      String? token = await getToken();
      dio.options.headers["authorization"] = "Token " + token!;
      var formData = FormData.fromMap({
        'groupcode': groupcode,
      });

      response =
      await dio.post('http://13.124.31.77/requestinvite/', data: formData);
      print(response.data);
    } on DioError catch (e) {
      print(e.response?.data.toString());
    }
  }


  static Future<InviteCheck> checkinviterequest(groupid) async{
    Response response;
    try {
      var dio = Dio();
      String? token = await getToken();
      dio.options.headers["authorization"] = "Token " + token!;
      response = await dio.get('http://13.124.31.77/showmeminvite/',queryParameters: {"group":groupid});
      var invitecheck = InviteCheck.fromJson(response.data);
      for (int i = 0; i < invitecheck.memberList!.length; i++) {
        print("${invitecheck.memberList![i].nickname}");
      }
      return invitecheck;
    }on DioError catch(e){
      return e.response!.data;
    }
  }


  static void addmember(groupid, memberid) async{
    Response response;
    try {
      var dio = Dio();
      String? token = await getToken();
      dio.options.headers["authorization"] = "Token " + token!;
      var formData = FormData.fromMap({
        'group': groupid,
        'newmember': memberid,
      });
      response =
      await dio.post('http://13.124.31.77/addmember/', data: formData);
      print(response.data);
    } on DioError catch (e) {
      print(e.response?.data.toString());
    }
  }
  static Future<InviteCheck> getmember(groupid) async {
    try {
      Response response;
      var dio = Dio();
      String? token = await getToken();
      dio.options.headers["authorization"] = "Token " + token!;
      response = await dio.get('http://13.124.31.77/showmem/',queryParameters: {"group":groupid});
      var getMember = InviteCheck.fromJson(response.data);
      for (int i = 0; i < getMember.memberList!.length; i++) {
        print("${getMember.memberList![i].nickname}");
      }
      return getMember;
      // Map<String,dynamic> userMap = jsonDecode(response.data);

    } on DioError catch (e) {
      return e.response!.data;
    }
  }


  static void addroom(group, manager, title, size, period) async {
    Response response;
    try {
      var dio = Dio();
      String? token = await getToken();
      dio.options.headers["authorization"] = "Token " + token!;
      var formData = FormData.fromMap({
        'group': group,
        'manager': manager,
        'title': title,
        'size': size,
        'period':period
      });

      response =
      await dio.post('http://13.124.31.77/room/', data: formData);
      print(response.data);
    } on DioError catch (e) {
      print(e.response?.data.toString());
    }
  }
  static void updatestatics(groupid) async {
    Response response;
    try {
      var dio = Dio();
      String? token = await getToken();
      dio.options.headers["authorization"] = "Token " + token!;
      var formData = FormData.fromMap({
        'group': groupid,
      });

      response =
      await dio.post('http://13.124.31.77/updatestatic/', data: formData);
      print(response.data);
    } on DioError catch (e) {
      print(e.response?.data.toString());
    }
  }

  static void posthistory(roomid,event,dynamic image,text) async {
    Response response;
    try {

      var dio = Dio();

      String? token = await getToken();
      dio.options.contentType = 'multipart/form-data';
      dio.options.maxRedirects.isFinite;
      dio.options.headers["authorization"] = "Token " + token!;
      var formData = FormData.fromMap({
        'room': roomid,
        'event':event,
        'image':await MultipartFile.fromFile(image),
        'text':text
      });

      response =
      await dio.post('http://13.124.31.77/history/', data: formData);
      print(response.data);
    } on DioError catch (e) {
      print(e.response?.data.toString());
    }
  }
  static Future<Historylist> gethistory(roomid) async {
    try {
      Response response;
      var dio = Dio();
      String? token = await getToken();
      dio.options.headers["authorization"] = "Token " + token!;
      response = await dio.get('http://13.124.31.77/history/',queryParameters: {"room":roomid});
      var histroylist = Historylist.fromJson(response.data);
      for (int i = 0; i < histroylist.listhistory!.length; i++) {
        print("${histroylist.listhistory![i].id}${histroylist.listhistory![i].author!.nickname}${histroylist.listhistory![i].text}");
      }
      return histroylist;

    } on DioError catch (e) {
      return e.response!.data;
    }
  }

}


