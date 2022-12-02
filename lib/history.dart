import 'package:flutter/material.dart';
import 'package:termproject/main.dart';
import 'register.dart';
import 'server.dart';
import 'model/model.dart';
import 'package:bubble/bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:photo_view/photo_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:image_picker/image_picker.dart';

class HistoryPage extends StatefulWidget {
  HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();

}

class _HistoryPageState extends State<HistoryPage> with TickerProviderStateMixin {

  Future<GETROOMLIST>? roomlist;
  List<AssetImage> IconList=[AssetImage("loginimage.PNG"),AssetImage("loginimage.PNG"),AssetImage("loginimage.PNG")];
  int roomid=0;
  late TabController _tabController;
  XFile? selectImage;
  List<Widget>? _pagelist;
  int _init_index=0;
  @override
  void initState(){
    roomlist = ServerApi.getRoom();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return
    FutureBuilder(future: roomlist,builder: (context,snapshot) {
      if (snapshot.hasData) {
      _pagelist =List<Widget>.generate(snapshot.data!
          .roomlist!.length, (i) =>
          RoomHistory(snapshot.data!.roomlist![i].id!));
        _tabController = new TabController(vsync: this, length: snapshot.data!.roomlist!.length,initialIndex: _init_index);
        return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Text('History',style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
              ),),
              bottom: ButtonsTabBar(
                controller: _tabController,
                  backgroundColor: Colors.green[600],
                  unselectedBackgroundColor: Colors.white,
                  labelStyle:
                  TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  unselectedLabelStyle: TextStyle(
                      color: Colors.green[600],
                      fontWeight: FontWeight.bold),
                  borderWidth: 3,
                  unselectedBorderColor: Colors.green[600]!,
                  radius: 100,
                  tabs: List<Tab>.generate(
                      snapshot.data!.roomlist!.length, (i) =>
                      Tab(text: snapshot.data!.roomlist![i].title!))
              ),

              actions: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      Navigator.pushNamed(context, '/modify');
                    });
                  },
                  icon: const Icon(Icons.account_circle),
                )
              ],
            ),
            body: TabBarView(
              controller: _tabController,
              children: _pagelist!,
            ),

            floatingActionButton: FloatingActionButton(
            onPressed: () {
              showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  final ImagePicker _picker = ImagePicker();
                  return Padding(
                    padding: EdgeInsets.only(bottom: MediaQuery
                        .of(context)
                        .viewInsets
                        .bottom),
                    child: Container(
                      height: 70,
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: MessageBar(
                              replying: false,
                              onSend: (text) async{
                                if (selectImage != null) {
                                  dynamic sendData = selectImage!.path;
                                  await ServerApi.posthistory(snapshot.data!.roomlist![_tabController.index].id,0,sendData,text);
                                  selectImage=null;
                                }
                                else await ServerApi.posthistory(snapshot.data!.roomlist![_tabController.index].id, 0, null, text);
                                _init_index=_tabController.index;
                              },
                              actions: [
                                InkWell(
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.black,
                                    size: 24,
                                  ),
                                  onTap: () async{
                                      selectImage = await _picker.pickImage(
                                      //이미지를 선택
                                      source: ImageSource.gallery, //위치는 갤러리
                                      maxHeight: 480,
                                      maxWidth: 640,
                                      imageQuality: 100, // 이미지 크기 압축을 위해 퀄리티를 30으로 낮춤.
                                    );
                                  },
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 8, right: 8),
                                  child: InkWell(
                                    child: Icon(
                                      Icons.camera_alt,
                                      color: Colors.green,
                                      size: 24,
                                    ),
                                    onTap: () {
                                      print('index${_tabController.index}');
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ).then((value) {
                setState(() {});
              });
            },
            backgroundColor: Colors.green,
            child: const Icon(Icons.mail),
          ),
          );
      }
      else if (snapshot.hasError) {
        return Text("error");
      }
      return CircularProgressIndicator();
    }
    );
  }
}



class RoomHistory extends StatefulWidget {
  int id=4;
  RoomHistory(this.id,{Key? key}) : super(key: key);
  @override
  State<RoomHistory> createState() => _RoomHistoryState();
}

class _RoomHistoryState extends State<RoomHistory> {
  Future<Historylist>? history;
  List<AssetImage> IconList=[AssetImage('rabitIcon.PNG'),AssetImage('rabitIcon.PNG'),AssetImage("loginimage.PNG")];


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    history = ServerApi.gethistory(widget.id);
    return
      FutureBuilder<Historylist>(
        future: history,
        builder: (context,snapshot){
          if(snapshot.hasData){
            return
              Column(
                children: [
                  Expanded(
                      child:ListView.builder(
                          itemCount: snapshot.data!.listhistory!.length,

                          itemBuilder: (context,index){
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius:30,
                                  backgroundImage: IconList[snapshot.data!.listhistory![index].author!.icon!],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10.0),
                                      child: Text(snapshot.data!.listhistory![index].author!.nickname!,
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold
                                        ),textAlign: TextAlign.center,
                                      ),
                                    ),

                                    Bubble(
                                        margin: BubbleEdges.only(top: 10),
                                        color: Color.fromRGBO(246, 249, 254, 1.0),
                                        nip: BubbleNip.leftBottom,
                                        child: Column(
                                          children: [
                                            Visibility(

                                              child: snapshot.data!.listhistory![index].image!=null?
                                              GestureDetector(

                                                  child: 
                                                  ClipRRect (borderRadius: BorderRadius.circular(20),child: Image.network(snapshot.data!.listhistory![index].image!,fit: BoxFit.fitHeight,width: 250,)
                                                  ),
                                                  onTap: (){

                                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailPage(snapshot.data!.listhistory![index].image!)));}
                                              ): Text("no image"),
                                              visible: snapshot.data!.listhistory![index].image!=null?true:false,
                                            ),

                                            Text(snapshot.data!.listhistory![index].text!,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold
                                              ),textAlign: TextAlign.center,),
                                          ],
                                        )
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10.0,top: 10.0),
                                      child: Text(snapshot.data!.listhistory![index].modifyDate!.substring(5,10),
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: CupertinoColors.inactiveGray,
                                        ),textAlign: TextAlign.center,
                                      ),
                                    ),
                                    SizedBox(height: 20,),
                                    // FloatingActionButton(onPressed: (){
                                    //   setState(() {
                                    //     super.initState();
                                    //   });
                                    // })
                                  ],
                                ),
                              ],
                            );
                          }
                      )
                  ),
                ],
              );
          }else if (snapshot.hasError){
            return Text("error");
          }
          return CircularProgressIndicator();
        }
    );
  }
}
class DetailPage extends StatefulWidget {
  String url="";
  DetailPage(this.url,{Key? key}) : super(key: key);
  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: PhotoView(
        imageProvider: CachedNetworkImageProvider(widget.url),
        )
    );
  }
}