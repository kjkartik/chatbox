import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebasetestcrash/Login%20&%20Signup/login.dart';
import 'package:flutter/material.dart';

import '../Function/function.dart';
import '../Widget/widget.dart';

class CreateNewAccount extends StatefulWidget {
  const CreateNewAccount({Key? key}) : super(key: key);

  @override
  State<CreateNewAccount> createState() => _CreateNewAccountState();
}

class _CreateNewAccountState extends State<CreateNewAccount> {
  @override

  var DpImage = "null";

    PlatformFile? pickedFile;
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();



  void getImage() async {
    var data = await FilePicker.platform.pickFiles();
    if (data == null) return;

    setState(() {
      pickedFile = data.files.first;
      print("----------pickedfile-------"+pickedFile.toString());
    });
    uploadData();

  }
  void  uploadData()async{
    final path = 'Dp/${ pickedFile!.name}';
    final file = File(pickedFile!.path!);

    final ref =  await FirebaseStorage.instance.ref().child(path);
    ref.putFile(file).whenComplete(()async {

    /// download image
      FirebaseStorage.instance.ref("Dp/");

      var url = await ref.getDownloadURL();
      print("ioio "+url.toString());
      DpImage = url.toString();

      ToastClass.ToastShow("Image Selected");
      setState((){});

    });



  }


  @override
  void initState(){

    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("SignUp With Firebase"),
      ),
      body: ListView(

        // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height/9,),

            Center(child:  Text(
              "Create New Account",
              style: TextStyle(color: Colors.black,fontSize: 21),
            ),),
            InkWell(
              child: Stack(alignment: Alignment.center,
                children: [
                  CircleAvatar(radius: 31,child:DpImage == "null"? Icon(Icons.add):Text(""),backgroundImage: DpImage != "null"? NetworkImage(DpImage):null),

                  Padding(
                    padding: const EdgeInsets.only(left: 50,top: 20),
                    child: Icon(Icons.camera),
                  ),
                ],
              ),onTap: (){
              getImage();
            },
            ),
            SizedBox(height: height/21,),
            Text(
              "     Name",
              style: TextStyle(color: Colors.black),
            ),
            buildContainer(
                controller: _nameController, hint: "Enter The Name"),
            SizedBox(
              height: 10,
            ),    Text(
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

            // Spacer(),
            InkWell(
              child: Container(
                width: width,height: height/28,margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),border: Border.all(color: Colors.black)),

                child: Center(child: Text("Create New Account")),
              ),onTap: ()async{
        await      FirebaseFunction.createAccount(_emailController, _passwordController,context:
        context,name: _nameController,image: DpImage.toString());



            },
            ),
            InkWell(
              child: Container(
                width: width,height: height/28,margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),border: Border.all(color: Colors.black45)),

                child: Center(child: Text("Already Have  Account ? "),),
              ),onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (_)=> Login()));
            },
            ),
          ]),
    );
  }
}
