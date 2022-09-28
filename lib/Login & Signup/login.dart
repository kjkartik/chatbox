import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Function/function.dart';
import '../Widget/widget.dart';
import 'create_new_account.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override



  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();




  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

   final height = MediaQuery.of(context).size.height;
   final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Login With Firebase"),
      ),
      body: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height/7,),
            Center(child:  Text(
              "Login",
              style: TextStyle(color: Colors.black,fontSize: 21),
            ),),
            SizedBox(height: height/21,),
            Text(
              "     Email",
              style: TextStyle(color: Colors.black),
            ),
            buildContainer(
                controller: _emailController, hint: "Enter The Email Id"),
            SizedBox(
              height: 10,
            ),
            Text(
              "     Password",
              style: TextStyle(color: Colors.black),
            ),
            buildContainer(
                controller: _passwordController, hint: "Enter The Password"),
            SizedBox(
              height:height/ 20,
            ),
            InkWell(
              child: Container(
                width: width,height: height/28,margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),border: Border.all(color: Colors.black45)),

                child: Center(child: Text("Login")),
              ),onTap: ()async{


              FirebaseFunction.loginUser(_emailController.text.toString(),_passwordController.text.toString(),context: context);
            },
            ),
            // Spacer(),
            InkWell(
              child: Container(
                width: width,height: height/28,margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),border: Border.all(color: Colors.black45)),

                child: Center(child: Text("Create New Account")),
              ),onTap: (){
             Navigator.of(context).push(MaterialPageRoute(builder: (_)=> CreateNewAccount()));
            },
            ),
          ]),
    );
  }

}
