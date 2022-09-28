import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';


import 'Widget/widget.dart';

class Home extends StatefulWidget {
  Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Home> {
    final remoteConfig = FirebaseRemoteConfig.instance;
  String appBarColor = '';
  String heading = "Here We Type some heading";
  int containerheigth = 3;
  String image = '';
  bool alignmnet = false;
  List imageList = ["https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_960_720.jpg"];

  void getdataRemote()async{
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 1),
      minimumFetchInterval: const Duration(seconds: 10),


    ),);
    await remoteConfig.fetchAndActivate();
    image = remoteConfig.getString("image");
    heading = remoteConfig.getString("test");
    alignmnet = remoteConfig.getBool("alignment");
    containerheigth = remoteConfig.getInt("height");
    imageList = image.split(",");


  }

  @override
  void initState() {
    getdataRemote();
    Future.delayed(Duration(seconds: 11),(){
      setState((){});
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {



    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Text("Remote Configure"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            imageList.isEmpty
                ? SizedBox()
                : alignmnet ?Container(child: ListView(),): Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.network(imageList[0],width: width/3,height: height/11,),
                      ),
                      Text(
                        '$heading',
                        style: TextStyle(fontSize: 17),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        height: height / containerheigth,
                        width: width,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.green,
                          ),
                        ),
                        child: Column(

                            crossAxisAlignment: alignmnet?CrossAxisAlignment.start:CrossAxisAlignment.end,
                            mainAxisAlignment:
                            MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                width: width / 2.7,
                                height: height / 31,
                                decoration: buildBoxDecoration(
                                  bordreclr: Colors.black45,
                                  innerColor: Colors.green.withOpacity(0.7),
                                ),
                              ),
                              Container(
                                width: width / 2.3,
                                height: height / 31,
                                decoration: buildBoxDecoration(
                                  bordreclr: Colors.black45,
                                  innerColor: Colors.green.withOpacity(0.7),
                                ),
                              ),
                              Container(
                                width: width / 2.1,
                                height: height / 31,
                                decoration: buildBoxDecoration(
                                  bordreclr: Colors.black45,
                                  innerColor: Colors.green.withOpacity(0.7),
                                ),
                              ),
                              Container(
                                width: width / 1.8,
                                height: height / 31,
                                decoration: buildBoxDecoration(
                                  bordreclr: Colors.black45,
                                  innerColor: Colors.green.withOpacity(0.7),
                                ),
                              ),
                              Container(
                                width: width / 1.3,
                                height: height / 31,
                                decoration: buildBoxDecoration(
                                  bordreclr: Colors.black45,
                                  innerColor: Colors.green.withOpacity(0.7),
                                ),
                              ),
                              Container(
                                width: width / 1.1,
                                height: height / 31,
                                decoration: buildBoxDecoration(
                                  bordreclr: Colors.black45,
                                  innerColor: Colors.green.withOpacity(0.7),
                                ),
                              )
                            ]),
                      ),
                    ],
                  ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
