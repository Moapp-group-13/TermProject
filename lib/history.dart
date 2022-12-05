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
import 'package:image_picker/image_picker.dart';
import 'package:camera/camera.dart';
import 'dart:io';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';


class HistoryPage extends StatefulWidget {
  int idx=0;
  HistoryPage(this.idx,{Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();

}

class _HistoryPageState extends State<HistoryPage> with TickerProviderStateMixin {
  Future<GETROOMLIST>? roomlist;
  List<AssetImage> TypeIconList=[AssetImage('c0.PNG'),AssetImage('c1.PNG'),AssetImage("c2.PNG")];
  int roomid=0;
  late TabController _tabController;
  XFile? selectImage;
  List<Widget>? _pagelist;
  int selectedIcon=0;
  int _init_index=0;

  @override
  void initState(){
    roomlist = ServerApi.getRoom();
    _init_index=widget.idx;
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
              title: Text('히스토리',style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
              ),),

              bottom: ButtonsTabBar(
                controller: _tabController,
                  backgroundColor: Colors.grey,
                  unselectedBackgroundColor: Colors.white,
                  labelStyle:
                  TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  unselectedLabelStyle: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold),
                  borderWidth: 3,
                  unselectedBorderColor: Colors.grey!,
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
              selectImage = null;
              showMaterialModalBottomSheet(
                backgroundColor: Colors.transparent,
                context: context,
                builder: (BuildContext context) {
                  return StatefulBuilder(builder: (BuildContext context, StateSetter bottomState) {
                  // selectImage=null;
                  final ImagePicker _picker = ImagePicker();
                  return Padding(
                    padding: EdgeInsets.only(bottom: MediaQuery
                        .of(context)
                        .viewInsets
                        .bottom),
                    child: Wrap(
                        children: <Widget>[
                            Row(
                              children: [
                                DropdownButton<int>(
                                  value: selectedIcon,
                                  items: List<DropdownMenuItem<int>>.generate(3, (index) => DropdownMenuItem<int>(
                                      value: index,
                                      child:  ClipRRect(
                                        borderRadius: BorderRadius.all(Radius.circular(10.0)),//add border radius here
                                        child: Image( image:TypeIconList[index]),//add image location here
                                      )
                                  )),
                                  onChanged: (value){
                                    bottomState(() {
                                      selectedIcon = value!;
                                      print(selectedIcon);
                                    });
                                  },
                                ),
                                selectImage!=null?Center(
                                    child: Opacity(
                                      opacity: 0.8,
                                      child: Container(
                                        color: Colors.orange.withOpacity(0.0),
                                        height: 200,
                                      child: Image.file(File(selectImage!.path)),
                                      ),
                                    ),
                                ):SizedBox.shrink(),
                              ],
                            ),
                          Expanded(
                            child: MessageBar(
                              replying: false,
                              onSend: (text) async{
                                if (selectImage != null) {
                                  dynamic sendData = selectImage!.path;
                                  await ServerApi.posthistory(snapshot.data!.roomlist![_tabController.index].id,selectedIcon,sendData,text);
                                }
                                else await ServerApi.posthistory(snapshot.data!.roomlist![_tabController.index].id, selectedIcon, null, text);
                                _init_index=_tabController.index;
                                Navigator.pop(context);
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
                                      bottomState(() {

                                      });
                                  },
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 8, right: 8),
                                  child: FloatingActionButton(
                                    onPressed: ()async {
                                      selectImage = await ImagePicker().pickImage(source: ImageSource.camera);
                                      bottomState((){
                                      });
                                      },
                                    child: Icon(Icons.camera_alt),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],

                    ),
                  );
                  }
                  );
                }
              ).then((value) {
                setState(() {});
              });

            },
            backgroundColor: Colors.grey,
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
  List<AssetImage> IconList=[AssetImage('1.PNG'),AssetImage('2.PNG'),AssetImage("3.PNG"),AssetImage("4.PNG"),AssetImage("5.PNG"),AssetImage("6.PNG")];
  List<AssetImage> TypeIconList=[AssetImage('c0.PNG'),AssetImage('c1.PNG'),AssetImage("c2.PNG")];
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
                  SizedBox(height: 30,)
                  ,Expanded(
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
                                    Row(
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
                                        Padding(
                                          padding: const EdgeInsets.only(left:10.0),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(Radius.circular(10.0)),//add border radius here
                                            child: Image( height: 45,image:TypeIconList[snapshot.data!.listhistory![index].event!]),//add image location here
                                          ),
                                        ),
                                      ],
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


//Yaml으로 쓰려다가 수정할 부분이 있어서 그냥 다 끌고 옴

class MessageBar extends StatefulWidget {
  final bool replying;
  final String replyingTo;
  final List<Widget> actions;
  final Color replyWidgetColor;
  final Color replyIconColor;
  final Color replyCloseColor;
  final Color messageBarColor;
  final Color sendButtonColor;
  final void Function(String)? onTextChanged;
  final void Function(String)? onSend;
  final void Function()? onTapCloseReply;

  /// [MessageBar] constructor
  ///
  ///
  MessageBar({
    this.replying = false,
    this.replyingTo = "",
    this.actions = const [],
    this.replyWidgetColor = const Color(0xffF4F4F5),
    this.replyIconColor = Colors.blue,
    this.replyCloseColor = Colors.black12,
    this.messageBarColor = const Color(0xffF4F4F5),
    this.sendButtonColor = Colors.blue,
    this.onTextChanged,
    this.onSend,
    this.onTapCloseReply,
  });

  @override
  State<MessageBar> createState() => _MessageBarState();
}

class _MessageBarState extends State<MessageBar> {
  final TextEditingController _textController = TextEditingController();

  /// [MessageBar] builder method
  ///
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            widget.replying
                ? Container(
                color: widget.replyWidgetColor,
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.reply,
                      color: widget.replyIconColor,
                      size: 24,
                    ),
                    Expanded(
                      child: Container(
                        child: Text(
                          'Re : ' + widget.replyingTo,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: widget.onTapCloseReply,
                      child: Icon(
                        Icons.close,
                        color: widget.replyCloseColor,
                        size: 24,
                      ),
                    ),
                  ],
                ))
                : Container(),
            widget.replying
                ? Container(
              height: 1,
              color: Colors.grey.shade300,
            )
                : Container(),
            Container(
              color: widget.messageBarColor,
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 16,
              ),
              child: Row(
                children: <Widget>[
                  ...widget.actions,
                  Expanded(
                    child: Container(
                      child: TextField(
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'content7',
                          fontWeight: FontWeight.bold
                        ),
                        controller: _textController,
                        keyboardType: TextInputType.multiline,
                        textCapitalization: TextCapitalization.sentences,
                        minLines: 1,
                        maxLines: 3,
                        onChanged: widget.onTextChanged,
                        decoration: InputDecoration(
                          hintText: "Type your message here",
                          hintMaxLines: 1,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 10),
                          hintStyle: TextStyle(
                            fontSize: 16,
                            fontFamily: 'content7'
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: const BorderSide(
                              color: Colors.white,
                              width: 0.2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: const BorderSide(
                              color: Colors.black26,
                              width: 0.2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: InkWell(
                      child: Icon(
                        Icons.send,
                        color: widget.sendButtonColor,
                        size: 24,
                      ),
                      onTap: () {
                        if (_textController.text.trim() != '') {
                          if (widget.onSend != null) {
                            widget.onSend!(_textController.text.trim());
                          }
                          _textController.text = '';
                        }
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
  }
}
