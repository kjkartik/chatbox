import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebasetestcrash/Login%20&%20Signup/login.dart';
import 'package:firebasetestcrash/home.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../ChatScreen/dashboard.dart';

class FirebaseFunction {

   static checkUserLogin(context) async {
  var data;
   data = await FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
        ToastClass.ToastShow("User is currently signed out!");
        Navigator.of(context).push(MaterialPageRoute(builder: (_)=> Login()));
      } else {
        print("user>>>> "+user.toString());

        Navigator.of(context).push(MaterialPageRoute(builder: (_)=> ChatListScreen(email: user.email.toString(),)));

        print('User is signed in!');
        ToastClass.ToastShow("User is signed in!");
      }
    });
  }

   static  loginUser(email,password, {context})async{
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.toString(),
        password: password.toString(),
      );
      if(credential !=null){
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ChatListScreen(email:email.toString())));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        ToastClass.ToastShow("No user found for that email.");
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        ToastClass.ToastShow("Wrong password provided for that user.");
      }
    }

  }

   static  createAccount(email,password ,{context,name,image})async{

     print("909090909  --------------${name.text.toString() +"   "+ " " +email.toString() + password.toString()  +image.toString()}----------");


    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text.toString(),
        password: password.text.toString(),
      );
      print("cre"+ credential.toString());
      if(credential != null){
        var db = FirebaseFirestore.instance;

        final chat = <String ,dynamic>{"Image":"Imahttps://picsum.photos/300","Name":name.text.toString(),"email":email.text.toString()};
        print("email "+email.text.toString());
        await  db.collection("AllUser").doc(email.text.toString()).set(chat);
        ToastClass.ToastShow("Account Create Sucessfully");

        ToastClass.ToastShow("Login Sucessfully");

  Navigator.of(context).push(MaterialPageRoute(builder: (_)=>ChatListScreen(email: email.toString(),)));
      }
    } on FirebaseAuthException catch (e) {
      print(e.code.toString());
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        ToastClass.ToastShow('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        ToastClass.ToastShow("The account already exists for that email.");

      }
    } catch (e) {
      print("e"+e.toString());
    }

  }

    static  Future<String> getImage_Storage()async{
     final ref = FirebaseStorage.instance.ref().child('Image/img.jpeg');

     var url = await ref.getDownloadURL();
     return url;
   }




}


class ToastClass {

  static void ToastShow(String ToastValue) {
    Fluttertoast.showToast(
        msg: ToastValue,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
         backgroundColor: Colors.lightBlueAccent,
        textColor:  Colors.white,
        fontSize: 16.0);
  }
}