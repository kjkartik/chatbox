import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetestcrash/ChatScreen/status.dart';
import 'package:firebasetestcrash/Const/const.dart';
import 'package:firebasetestcrash/Login%20&%20Signup/login.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'User_chat_screen.dart';
import 'camera.dart';

class ChatListScreen extends StatefulWidget {
  var email;

  ChatListScreen({Key? key, required this.email}) : super(key: key);

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return DefaultTabController(
      length: 4,
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff075e55),
          title: Row(
            children: [
              const Text(
                '  Cshat',
                style: TextStyle(fontSize: 20),
              ),
              Spacer(),
              Row(
                children: [
                  Icon(Icons.search),
                  SizedBox(
                    width: 17,
                  ),
                  Icon(Icons.message),
                  PopupMenuButton(itemBuilder: (context) {
                    return [
                      PopupMenuItem(child: Text("New group")),
                      PopupMenuItem(child: Text("Setting")),
                      PopupMenuItem(
                        child: InkWell(
                          child: Text("LogOut"),
                          onTap: () {
                            FirebaseAuth.instance.signOut();
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (_) => Login()));
                          },
                        ),
                      ),
                    ];
                  })
                ],
              ),
            ],
          ),
          bottom: TabBar(
            padding: EdgeInsets.only(bottom: .8),
            indicatorColor: Colors.white,
            tabs: [
              Icon(Icons.camera_alt, size: 19),
              Text("Chat"),
              Text("Status"),
              Text("Call")
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            ImagePicker(),
            chat(),
            Status(),
            Center(
              child: Text(""),
            ),
          ],
        ),
      ),
    );
  }

  Widget chat() {
    List chatList = [];
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection("AllUser")
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          chatList.clear();
          AllChatList.clear();
          var ChatList = snapshot.data!.docs.map((e) {
            var data = e.data().toString();
            print("00000077"+e.toString());
            AllChatList.add(AllChatListModel(email: e["email"],image: e["Image"].toString(),name: e["Name"]));
            chatList.add(e.id.toString());
          });
          
          print("snapshot-------" + ChatList.toString());
          return ListView.builder(
              itemCount: AllChatList.length,
              itemBuilder: (context, index) {
                print(AllChatList[index].email.toString());
            // var messageTime =    DateTime.fromMillisecondsSinceEpoch(
            //       int.parse(AllChatList[index].time.toString())
            //     );
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 21, vertical: 10),
                  child: Column(
                    children: [
                      InkWell(
                        child: Row(
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CircleAvatar(
                                  backgroundColor: Colors.purpleAccent,
                                  child: Image.network(AllChatList[index].image.toString() ),
                                )),
                            SizedBox(
                              width: 15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 150,
                                  child: SingleChildScrollView(scrollDirection: Axis.horizontal,
                                    child: Text(
                                      AllChatList[index].name.toString(),
                                      style: TextStyle(color: Colors.black,),maxLines: 1,
                                    ),
                                  ),
                                ),
                                Text(
                               "hello---",   // AllChatList[index].lastmessage.toString(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w300),
                                )
                              ],
                            ),
                            Spacer(),
                            Column(
                              children: [
                                Text(
                          "9/8/2022" ,    // DateFormat('MM/dd/yyyy,').format(),,
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w400),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.volume_mute, size: 18),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    CircleAvatar(
                                      child: Text("1",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white)),
                                      backgroundColor: Color(0xff00d55b),
                                      radius: 9,
                                    )
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                        onTap: () {
                          print(chatList[index].toString());
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => UserChatScreen(
                                  you: widget.email,
                                  other: AllChatList[index].email.toString())));
                        },
                      ),
                    ],
                  ),
                );
              });
        });
  }
}

class AllChatListModel{

  final String? email;
  final String? lastmessage;
  final String? time;
  final String? id;
  final String?image;
  final String?name;

  AllChatListModel({this.email, this.lastmessage, this.time,this.id,this.image,this.name});
}