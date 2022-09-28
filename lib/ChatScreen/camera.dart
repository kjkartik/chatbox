import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebasetestcrash/Function/function.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePicker extends StatefulWidget {
  const ImagePicker({Key? key}) : super(key: key);

  @override
  State<ImagePicker> createState() => _ImagePickerState();
}

class _ImagePickerState extends State<ImagePicker> {
  
 PlatformFile? pickedFile;

 void  uploadData(){
   
  final path = 'Image/${ pickedFile!.name}';
  final file = File(pickedFile!.path!);

  final ref = FirebaseStorage.instance.ref().child(path);
  ref.putFile(file);

  ToastClass.ToastShow("Done");
 }


  void getImage() async {
    var data = await FilePicker.platform.pickFiles();
    if (data == null) return;

    setState(() {
      pickedFile = data.files.first;
    });
    uploadData();
  }



  @override
  void initState() {
    getImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}
