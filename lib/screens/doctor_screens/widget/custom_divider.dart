import 'package:flutter/material.dart';




Widget divider()=> Padding(
  padding:const EdgeInsetsDirectional.only(end: 20.0),
  child: Container(
    width:double.infinity,
    height:1.0,
    color:Colors.grey[200] ,
  ),);


Widget myDivider()=> Padding(
  padding:const EdgeInsetsDirectional.only(start: 20.0),
  child: Container(
    width:double.infinity,
    height:1.0,
    color:Colors.grey[100] ,
  ),);

