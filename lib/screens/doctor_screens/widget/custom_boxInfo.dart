import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget myInfoBox({required IconData iconData, required String text,}) =>
    Container(
       padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
       margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
       decoration: BoxDecoration(
         border: Border.all(color: Colors.black),
    borderRadius: BorderRadius.circular(10),
  ),
        child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
         Icon(
          iconData,
          size: 16.0,
        ),
         SizedBox(
          width: 5.w,
        ),

         Text(
          text,
          style: const TextStyle(fontSize: 15.0),
        ),
      ],
    ),
  ),
);