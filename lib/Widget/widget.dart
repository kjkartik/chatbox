
import 'package:flutter/material.dart';

Widget buildContainer({controller, hint}) => Container(
    margin: EdgeInsets.all(10),
    child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
            hintText: hint,
            contentPadding: EdgeInsets.all(10),
            border: OutlineInputBorder(),),),);

BoxDecoration buildBoxDecoration({innerColor,bordreclr}) => BoxDecoration(color: innerColor,borderRadius: BorderRadius.circular(10),border: Border.all(color:bordreclr));
