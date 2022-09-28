import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import '../Utils/Icon/app_icon.dart';
import '../Utils/Widget/widget.dart';
import '../Utils/decoration/app_decoration.dart';
import '../Utils/theme/app_theme.dart';

class Patym extends StatefulWidget {
  const Patym({Key? key}) : super(key: key);

  @override
  State<Patym> createState() => _PatymState();
}

class _PatymState extends State<Patym> {

  
  bool _visible = false;
  String image = '';
 List imageList = [];

     void getdataRemote()async{
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 10),
      minimumFetchInterval: const Duration(seconds: 10),
    ),);
    await remoteConfig.fetchAndActivate();

    // setState((){
    _visible = remoteConfig.getBool("patymui");
    image = remoteConfig.getString("image");
    imageList = image.split(",");

    print("object"+_visible.toString());
    Future.delayed(Duration(seconds: 10),() async{
      setState((){});
    });
    // });

  }
  
  @override
  void initState(){
    getdataRemote();
  }
  @override
  Widget build(BuildContext context) {
    TextStyle heading = TextStyle(
        fontWeight: FontWeight.w600, color: AppTheme.darkBlue, fontSize: 15);
    TextStyle sub_style_F11 = TextStyle(
        fontWeight: FontWeight.w400,
        color: AppTheme.black.withOpacity(0.4),
        fontSize: 11);

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
                height: height / 9,
                padding: EdgeInsets.symmetric(horizontal: 10),
                color: AppTheme.appBar_theme,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                        radius: 13, backgroundColor: AppTheme.darkBlue),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Pay",
                              style: heading,
                            ),
                            Text("tm",
                                style: heading.copyWith(
                                  color: AppTheme.skyBlue,
                                )),
                          ],
                        ),
                        Text(
                          "-UPI -",
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Icon(AppIcon.search, size: 19),
                        SizedBox(
                          width: width / 15,
                        ),
                        AppIcon.message,
                      ],
                    )
                  ],
                )),
            ListView(
              padding: EdgeInsets.symmetric(horizontal: 1),
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: height / 9.9,
                    ),
                    Container(
                      decoration: AppDecoration.card_deco,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            height: height / 31,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 4),
                            padding: EdgeInsets.all(10),
                            // height: height / 8,
                            width: width,
                            decoration: AppDecoration.card_deco.copyWith(
                              border:
                                  Border.all(color: AppTheme.grey, width: 0.5),
                            ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 14),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Plan of 19 expire on sep 06",
                                          style: heading.copyWith(
                                              color: AppTheme.red, fontSize: 9),
                                        ),
                                        Spacer(),
                                        Icon(
                                          AppIcon.cancle,
                                          size: 13,
                                        )
                                      ],
                                    ),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      buildCircleAvatar(
                                          context: context,
                                          icon: Icons
                                              .account_balance_wallet_rounded,
                                          name: "Scan & Pay",
                                          cirAv_bg: true),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Mobile Recharge",
                                            style: heading.copyWith(
                                                fontSize: 10,
                                                color: AppTheme.black),
                                          ),
                                          Text(
                                            "123456782",
                                            style: heading.copyWith(
                                                fontSize: 10,
                                                color: AppTheme.black,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 21,
                                      ),
                                      Container(
                                        decoration: AppDecoration.card_deco
                                            .copyWith(
                                                border: Border.all(
                                                    color: AppTheme.skyBlue1)),
                                        child: Text(
                                          "  Recharge Now  ",
                                          style: heading.copyWith(
                                              fontSize: 10,
                                              color: AppTheme.skyBlue),
                                        ),
                                      )
                                    ],
                                  ),
                                ]),
                          ),
                          if(_visible ==true)  Container(
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            padding: EdgeInsets.all(10),
                            // height: height / 8,
                            width: width,
                            decoration: AppDecoration.card_deco.copyWith(
                              border:
                                  Border.all(color: AppTheme.grey, width: 0.5),
                            ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 14),
                                    child: Text(
                                      "UPI Money Transfer",
                                      style: heading.copyWith(
                                          color: AppTheme.black, fontSize: 15),
                                    ),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      buildCircleAvatar(context: context, icon: Icons.account_balance_wallet_rounded, name: "Scan & Pay", cirAv_bg: true),
                                      buildCircleAvatar(context: context, icon: Icons.mobile_friendly, name: "To Mobile",cirAv_bg: true),
                                      buildCircleAvatar(context: context, icon: Icons.perm_identity_rounded, name: "To Self", cirAv_bg: true),
                                      buildCircleAvatar(context: context, icon: Icons.account_balance, name: "To Bank A/C", cirAv_bg: true),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      buildCircleAvatar(context: context, icon: Icons.account_balance_wallet_rounded, name: "Scan & Pay", cirAv_bg: false),
                                      buildCircleAvatar(context: context, icon: Icons.mobile_friendly, name: "To Mobile",cirAv_bg: false),
                                      buildCircleAvatar(context: context, icon: Icons.perm_identity_rounded, name: "To Self", cirAv_bg: false),
                                      buildCircleAvatar(context: context, icon: Icons.account_balance, name: "To Bank A/C", cirAv_bg: false),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      buildCircleAvatar(context: context, icon: Icons.account_balance_wallet_rounded, name: "Scan & Pay", cirAv_bg: false),
                                      buildCircleAvatar(context: context, icon: Icons.mobile_friendly, name: "To Mobile",cirAv_bg: false),
                                      buildCircleAvatar(context: context, icon: Icons.perm_identity_rounded, name: "To Self", cirAv_bg: false),
                                      buildCircleAvatar(context: context, icon: Icons.account_balance, name: "To Bank A/C", cirAv_bg: false),
                                    ],
                                  ),
                                ]),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            padding: EdgeInsets.all(10),
                            // height: height / 8,
                            width: width,
                            decoration: AppDecoration.card_deco.copyWith(
                              border:
                                  Border.all(color: AppTheme.grey, width: 0.5),
                            ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 14),
                                    child: Text(
                                      "Offer for you",
                                      style: heading.copyWith(
                                          color: AppTheme.black, fontSize: 15),
                                    ),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      buildCircleAvatar(
                                          context: context,
                                          icon: Icons.wallet,
                                          name: "Add Money to Wallet"),
                                      buildCircleAvatar(
                                          context: context,
                                          icon: Icons.local_play_rounded,
                                          name: "Send Money Offer"),
                                      buildCircleAvatar(
                                          context: context,
                                          icon: Icons.arrow_forward,
                                          name: "view More Offer",
                                          cirAv_bg: true),
                                      buildCircleAvatar(
                                          context: context,
                                          icon: Icons.mobile_screen_share_sharp,
                                          name: "Recharge Offer"),
                                    ],
                                  ),
                                  // Container(color: Colors.red,child: Text("Choose any offer & 10-100 chashback"),)
                                ]),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            padding: EdgeInsets.all(10),
                            // height: height / 8,
                            width: width,
                            decoration: AppDecoration.card_deco.copyWith(
                              border:
                                  Border.all(color: AppTheme.grey, width: 0.5),
                            ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 14),
                                    child: Row(
                                      children: [
                                        Text(
                                          "My Paytm",
                                          style: heading.copyWith(
                                              color: AppTheme.black,
                                              fontSize: 15),
                                        ),
                                        Spacer(),
                                        Container(
                                          decoration: AppDecoration.card_deco
                                              .copyWith(
                                                  color: AppTheme.grey
                                                      .withOpacity(0.2)),
                                          height: height / 31,
                                          child: Center(
                                            child: Text(
                                              "  UPI ID:45454545@paytm  ",
                                              style: sub_style_F11,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        children: [
                                          buildCircleAvatar(
                                            context: context,
                                            icon: Icons.wallet,
                                            name: "Balance & History",
                                          ),
                                        ],
                                      ),
                                      buildCircleAvatar(
                                          context: context,
                                          icon: Icons.shopping_bag_outlined,
                                          name: "Personal Loan"),
                                      buildCircleAvatar(
                                          context: context,
                                          icon: Icons.wallet_membership,
                                          name: "Paytm Wallet"),
                                      buildCircleAvatar(
                                          context: context,
                                          icon: Icons
                                              .account_balance_wallet_rounded,
                                          name: "Paytm Postpaid"),
                                    ],
                                  ),
                                ]),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 5),
                                  height: height / 9,
                                  width: width,
                                  child:imageList.isNotEmpty?Image.network(imageList[0],fit: BoxFit.fitHeight,):Image.asset(
                                    "assets/2.png",
                                  ),
                                  // color: AppTheme.skyBlue,
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 5),
                                  height: height / 7,
                                  width: width,
                                  child:imageList.isNotEmpty?Image.network(imageList[1],fit: BoxFit.fitWidth,): Image.asset("assets/1.png",
                                      fit: BoxFit.fitWidth),
                                  // color: AppTheme.skyBlue,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            padding: EdgeInsets.all(10),
                            // height: height / 8,
                            width: width,
                            decoration: AppDecoration.card_deco.copyWith(
                              border:
                                  Border.all(color: AppTheme.grey, width: 0.5),
                            ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 14),
                                    child: Text(
                                      "Recharge & Bill Payments",
                                      style: heading.copyWith(
                                          color: AppTheme.black, fontSize: 15),
                                    ),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      buildCircleAvatar(
                                          context: context,
                                          icon: Icons.mobile_screen_share_sharp,
                                          name: "Mobile Recharge"),
                                      buildCircleAvatar(
                                          context: context,
                                          icon: Icons.card_membership,
                                          name: "Rent via Credit Card"),
                                      buildCircleAvatar(
                                          context: context,
                                          icon: Icons.cabin_rounded,
                                          name: "Dth Recharge"),
                                      buildCircleAvatar(
                                          context: context,
                                          icon: Icons.lightbulb,
                                          name: "Electricity Bill"),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      buildCircleAvatar(
                                          context: context,
                                          icon: Icons.card_membership,
                                          name: "Credit Card Payment"),
                                      buildCircleAvatar(
                                          context: context,
                                          icon: Icons.play_arrow_outlined,
                                          name: "Google Play"),
                                      buildCircleAvatar(
                                          context: context,
                                          icon:
                                              Icons.local_gas_station_outlined,
                                          name: "Book Gas Cylinder"),
                                      buildCircleAvatar(
                                          context: context,
                                          icon: Icons.arrow_forward,
                                          name: "View More"),
                                    ],
                                  ),
                                ]),
                          ),
                          Container(
                            // margin: EdgeInsets.symmetric(horizontal: 5),
                            padding: EdgeInsets.only(top: 10),
                            // height: height / 8,
                            width: width,
                            decoration: AppDecoration.card_deco.copyWith(
                              border:
                                  Border.all(color: AppTheme.grey, width: 0.5),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 14),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Loan & Credit Card",
                                              style: heading.copyWith(
                                                  color: AppTheme.black,
                                                  fontSize: 15),
                                            ),
                                            Text(
                                              "instant Approvals",
                                              style: sub_style_F11,
                                            )
                                          ],
                                        ),
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          buildCircleAvatar(
                                              context: context,
                                              icon: Icons
                                                  .account_balance_wallet_rounded,
                                              name: "Paytm Postpaid"),
                                          buildCircleAvatar(
                                              context: context,
                                              icon: Icons
                                                  .account_balance_wallet_rounded,
                                              name: "Personal Laon"),
                                          buildCircleAvatar(
                                              context: context,
                                              icon: Icons
                                                  .account_balance_wallet_rounded,
                                              name: "Free Credit Score"),
                                          buildCircleAvatar(
                                              context: context,
                                              icon: Icons
                                                  .account_balance_wallet_rounded,
                                              name: "Credit Card"),
                                        ],
                                      ),
                                    ]),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 9, top: 7),
                                  height: height / 31,
                                  width: width,
                                  color: Color(0xfff7fbff),
                                  child: Text(
                                    textAlign: TextAlign.start,
                                    "You Can Save upto 10,000 per annum",
                                    style: sub_style_F11.copyWith(
                                        fontSize: 9, color: AppTheme.black),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // SizedBox(height: height/2,)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
