
import 'dart:developer';

import 'package:firebasetestcrash/Function/function.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Status extends StatefulWidget {
  const Status({Key? key}) : super(key: key);

  @override
  State<Status> createState() => _StatusState();
}

class _StatusState extends State<Status> {

List<FirebaseFile> ImagesList = [];
  String dpimg = "https://picsum.photos/300";
  late Future<List<FirebaseFile>> futureFiles;



   static Future<List<String>> _getDownloadLinks(List<Reference> refs) =>
       Future.wait(refs.map((ref) => ref.getDownloadURL()).toList());



Future<List<FirebaseFile>>  getImaelistAll(String path) async {


    final ref = FirebaseStorage.instance.ref(path);
    final result = await ref.listAll();

    final urls = await _getDownloadLinks(result.items);



    return urls.asMap().map((index, url) {
      final ref = result.items[index];
      final name = ref.name;
      final file = FirebaseFile(ref: ref, name: name, url: url);

    ImagesList.add(FirebaseFile(ref: ref, name: name, url: url));
    setState((){});
      return MapEntry(index, file);
    })
        .values
        .toList();
  }



   getDpImage()async{
     dpimg =   await FirebaseFunction.getImage_Storage();
     log("img   "+dpimg.toString());
   setState((){});
   }



  @override
  void initState(){
    getDpImage();
    futureFiles = getImaelistAll('Image/');
    FirebaseFunction.getImage_Storage();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 13,
          ),
          Row(
            children: [
              CircleAvatar(backgroundImage:NetworkImage(dpimg.toString()),
                radius: 25,
              ),
              SizedBox(
                width: 13,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "My Status",
                    style: GoogleFonts.abel(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Tap To add Status Update",
                    style: GoogleFonts.abel(
                        color: Colors.grey.shade900,
                        fontWeight: FontWeight.w300),
                  )
                ],
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Recent Updates",
            style: GoogleFonts.abel(
                color: Colors.grey.shade900,
                fontSize: 16,
                fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 20,),
          Expanded(
            child: ListView.builder(shrinkWrap: true,itemCount:ImagesList.length,itemBuilder: (context,index){return
              Padding(
                padding: const EdgeInsets.only(bottom: 13),
                child: Row(
                  children: [

                    CircleAvatar(
                      radius: 25,backgroundImage: NetworkImage(ImagesList[index].url.toString()),
                    ),
                    SizedBox(
                      width: 13,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                         ImagesList[index].name[0],
                          style: GoogleFonts.abel(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "TIME ZONE",
                          style: GoogleFonts.abel(
                              color: Colors.grey.shade900,
                              fontWeight: FontWeight.w300),
                        )
                      ],
                    )
                  ],
                ),
              );
         }),
          )
        ],
      ),
    );
  }
}




class FirebaseFile {
  final Reference ref;
  final String name;
  final String url;

  const FirebaseFile({
    required this.ref,
    required this.name,
    required this.url,
  });
}