import 'package:flutter/material.dart';

Widget divider()=> Padding(
  padding:const EdgeInsetsDirectional.only(end: 20.0),
  child: Container(
    width:double.infinity,
    height:1.0,
    color:Colors.grey[200] ,
  ),);

////////////////////////////////////////
void navigateTo(context,Widget)
{
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Widget),
  );
}