import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

Widget buildCircleAvatar({context, icon, name, style, cirAv_bg, heading}) {
  TextStyle sub_style_F11 = TextStyle(
      fontWeight: FontWeight.w400,
      color: AppTheme.black.withOpacity(0.4),
      fontSize: 11);

  return Column(
    children: [
      SizedBox(
        height: 7,
      ),
      // Container(color:Colors.yellow ,child: Text(heading,style: sub_style_F11,),),
      CircleAvatar(
        radius: 14,
        backgroundColor: cirAv_bg == true ? AppTheme.fadeSky : AppTheme.white,
        child: Icon(icon, size: 20,color:AppTheme.skyBlue?.withOpacity(0.5) ),
      ),
      SizedBox(
        height: 5,
      ),
      Container(
          width: MediaQuery.of(context).size.width / 5,
          height: MediaQuery.of(context).size.height / 28,
          child: Text(name,
              style: TextStyle(color: AppTheme.black,fontSize: 9, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,))
    ],
  );
}
