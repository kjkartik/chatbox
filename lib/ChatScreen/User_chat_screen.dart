
import 'dart:ui';

import  'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../Const/const.dart';

class UserChatScreen extends StatefulWidget {
  var you;
var other;
  UserChatScreen({Key? key, required this.you, required this.other}) : super(key: key);

  @override
  State<UserChatScreen> createState() => _UserChatScreenState();
}

class _UserChatScreenState extends State<UserChatScreen> {
  final    FirebaseFirestore _firestore = FirebaseFirestore.instance;



  final _sendMessage = TextEditingController();

  final ScrollController _scrollController = ScrollController();

  // getCollectionData() async {
  //   var db = FirebaseFirestore.instance;
  //   await db
  //       .collection("chat")
  //       .orderBy("timestamp", descending: false)
  //       .get()
  //       .then(
  //     (event) {
  //       UserData.clear();
  //       for (var doc in event.docs) {
  //         UserData.add(
  //           UserModelClass(
  //             message: doc["message"].toString(),
  //             email: doc["email"].toString(),
  //             timeStamp: doc["timestamp"],
  //           ),
  //         );
  //       }
  //     },
  //   );
  // }

  sendMessage() {
    var db = FirebaseFirestore.instance;
    final userData = <String, dynamic>{
      "message": _sendMessage.text.toString(),
      "email": widget.you.toString(),
      "timeStamp": DateTime.now().millisecondsSinceEpoch.toString(),
      "messageType": "",
      "name": "",
    };
    db
        .collection("chat")
        .doc(widget.you.toString())
        .collection("withChat")
        .doc(widget.other.toString()).collection("chating").doc()
        .set(userData);
    db
        .collection("chat")
        .doc(widget.other.toString())
        .collection("withChat")
        .doc(widget.you.toString()).collection("chating").doc()
        .set(userData);
  }

  // getChatUserName() async {
  //   UserData.clear();
  //   print("email------" + widget.email.toString().toString());
  //   var db = FirebaseFirestore.instance;
  //
  //   /// new
  //   final dataSnap = await db
  //       .collection('chat')
  //       .doc(widget.email.toString())
  //       .collection('kartiksharm123@gmail.com')
  //       .get();
  //   List data1 = [];
  //   var data = dataSnap.docs.map(
  //     (e) {
  //       data1.add(e.id);
  //       e.id;
  //     },
  //   );
  call() {}

  //   print("@@@ " + data.toString());
  //   for (var i = 0; i < data1.length; i++) {
  //     var FinalData = await db
  //         .collection('chat')
  //         .doc(widget.email.toString())
  //         .collection('kartiksharm123@gmail.com')
  //         .doc(data1[i])
  //         .get()
  //         .then((value) {
  //       print("final00" + value.data().toString());
  //       UserData.add(
  //                 UserModelClass(
  //                   message: value["message"].toString(),
  //                   email: value["email"].toString(),
  //                   timeStamp:1,
  //                 ),
  //               );
  //       print("final00dsd" +UserData.length.toString());
  //
  //
  //       return "";
  //     });
  //   }
  //
  //   // print("------------------"+ FinalData.toString());

  //   // final sfDocRef = db
  //   //     .collection("chat")
  //   //     .doc(widget.email.toString(),)
  //   //     .collection("kartiksharm123@gmail.com")
  //   //     .orderBy("timesstamp", descending: false)
  //   //     .get()
  //   //     .then((event) {
  //   //   print("event" + event.toString());
  //   //   UserData.clear();
  //   //   for (var doc in event.docs) {
  //   //     UserData.add(
  //   //       UserModelClass(
  //   //         message: doc["message"].toString(),
  //   //         email: doc["email"].toString(),
  //   //         timeStamp: doc["timestamp"],
  //   //       ),
  //   //     );
  //   //   }
  //   //   print("00000" + UserData.toString());
  //   // });
  //   // print("sfDocRef>>>> " + sfDocRef.toString());
  // }

  Messages() async {
    var db = FirebaseFirestore.instance;
    final city = <String, String>{
      "name": "name",
      "message": "message",
      "country": "country"
    };

    db
        .collection("Chatting_DB")
        .doc("Kartik")
        .collection("Ram")
        .doc("Chat")
        .collection("All")
        .doc("Msg")
        .set(city);
  }

  // getChatList() async {
  //   print("-00000000--- "+widget.email.toString());
  //   var db = FirebaseFirestore.instance;
  //   var data1 = db.collection("chat").doc(widget.email.toString()).collection("withChat").snapshots();
  //
  //
  //   var data2 = data1.map((event) => null)
  //     print("--"+data2.toString());
  //   }

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
          title: Row(
            children: [
              SizedBox(
                  width: width / 2,
                  child: SingleChildScrollView(
                    child: Text(widget.other.toString()),
                    scrollDirection: Axis.horizontal,
                  )),
              Spacer(),
              ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CircleAvatar(
                    backgroundColor: Colors.purpleAccent,
                    child: Image.network(
                        "https://oyepaglu.com/wp-content/uploads/2020/07/i-never-apologize-i-am-sorry.jpg",
                        errorBuilder: (BuildContext, Object, StackTrace) {
                      return Text("----");
                    }),
                  )),
            ],
          ),
          backgroundColor: Colors.pink),
      body: StreamBuilder<QuerySnapshot>(

          stream:  _firestore.collection("chat")
          .doc(widget.you.toString())
          .collection("withChat")
          .doc(widget.other.toString()).collection("chating").orderBy("timeStamp",descending: false)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }


            UserData.clear();
            final datat = snapshot.data!.docs.map((e) {
              print("00000000_____"+e.data().toString());
              UserData.add(
                UserModelClass(
                  message: e['message'],
                  email: e['email'],
                  timeStamp: double.parse(e["timeStamp"].toString()).toInt(),
                ),
              );
              e.data();
            });
            print('snapshot id>> '+datat.toString());

            UserData = UserData.reversed.toList();
            // UserData.clear();
            // final messages = snapshot.data!.docs.map((e) {
            //   print("--0-0-0"+e.data().toString());
            //   UserData.add(
            //     UserModelClass(
            //       message: e['message'],
            //       email: e['email'],
            //       timeStamp: double.parse(e["timeStamp"].toString()).toInt(),
            //     ),
            //   );
            //   e;
            // });


            return Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/backgroung.png"),
                      fit: BoxFit.cover)),
              child: ListView.builder(
                itemCount: UserData.length,
                controller: _scrollController,
                reverse: true,
                padding: EdgeInsets.only(bottom: 60),
                itemBuilder: (context, index) {
                  var timestamp = DateTime.fromMillisecondsSinceEpoch(
                    UserData[index].timeStamp,
                  );
                  var finaltime = DateFormat('hh:mm a').format(timestamp);
                  var time24 = DateFormat('MM/dd/yyyy,').format(timestamp);

                  return Row(
                    mainAxisAlignment:
                        UserData[index].email != widget.you.toString()
                            ? MainAxisAlignment.start
                            : MainAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color:
                              UserData[index].email == widget.you.toString()
                                  ? Colors.pink.shade100
                                  : Colors.green.shade100,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                              topRight: Radius.circular(10)),
                        ),
                        padding: EdgeInsets.all(5),
                        margin:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        child: FractionallySizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                constraints: BoxConstraints(
                                  maxWidth: width * 0.80,
                                  minWidth: width * 0.20,
                                ),
                                child: Text(UserData[index].message.toString(),
                                    style: GoogleFonts.actor(
                                        fontSize: 11,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500)),
                              ),
                              Text(
                                finaltime,
                                style: GoogleFonts.asap(
                                    fontStyle: FontStyle.normal,
                                    color: Colors.black,
                                    fontSize: 7),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          }),
      bottomSheet: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
        child: Row(
          children: [
            Flexible(
              child: ConstrainedBox(
                constraints: new BoxConstraints(
                  minWidth: width,
                  maxWidth: width,
                  minHeight: 10.0,
                  maxHeight: 100.0,
                ),
                child: new Scrollbar(
                  child: new TextFormField(
                    cursorColor: Colors.red,
                    keyboardType: TextInputType.multiline,
                    controller: _sendMessage,
                    maxLines: null,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      fillColor: Colors.white,
                      prefixIcon: Icon(Icons.emoji_emotions_outlined,
                          color: Colors.grey, size: 21),
                      suffixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.attach_file_rounded,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Icon(
                            Icons.camera_alt,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                        ],
                      ),
                      filled: true,
                      isDense: true,
                      contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 3),
                      hintText: "Type your message",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            InkWell(
                onTap: () {

                  sendMessage();
                  _sendMessage.clear();
                  FocusManager.instance.primaryFocus?.unfocus();

                },
                child: CircleAvatar(
                  radius: 18,
                  child: Center(
                    child: Icon(
                      Icons.send,
                    ),
                  ),
                  backgroundColor: Colors.pink,
                ))
          ],
        ),
      ),
    );
  }
}

class UserModelClass {
  final String? userName;
  final String email;
  final String? id;
  final String message;
  final int? date;
  final int? time;
  final int timeStamp;
  final String? messagtype;

  UserModelClass(
      {this.userName,
      required this.email,
      this.id,
      required this.message,
      this.date,
      this.time,
      required this.timeStamp,
      this.messagtype});
}
