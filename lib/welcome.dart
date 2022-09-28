

import 'package:firebasetestcrash/Function/function.dart';
import 'package:flutter/material.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {


  void UserVerify(BuildContext context){
  FirebaseFunction.checkUserLogin(context);
  }

  void initState(){
    UserVerify(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Text("Welcome",style: TextStyle(fontSize: 26),)),
          ]),
    );
  }
}
