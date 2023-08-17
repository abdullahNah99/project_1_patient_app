import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_app/core/styles/app_colors.dart';

Widget defTextButton({required Function function,required String text,required Color color }) => TextButton(
       onPressed: (){
        function();
         },
          child: Text(
          text.toUpperCase(),
            style: TextStyle(
              fontSize: 11.0,
             color: color,
    ),),);

/*TextButton(
          style: TextButton.styleFrom(
             padding: EdgeInsets.zero,
             shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(10),
                 side: const BorderSide(
                 style: BorderStyle.solid,
                 color: Colors.black,
        ),
    ),
  ),
          onPressed: ()
          {
            function();
          },
           child: Padding(
             padding: const EdgeInsets.all(5.0),
             child: Text(
               text.toUpperCase(),
               style: TextStyle(
                 color: color,
                 fontSize: 12.0
               ),),
           ));*/
Widget defButton({
  double width = double.infinity,
  Color background = defaultColor,
  bool isUpperCase = true,
  double radius = 3.0,
  required Function function,
  required String text,
}) =>
    Container(
      width: width,
      height: 40.0,
      child:MaterialButton(
        onPressed: ()
        {
          function();
        },
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            fontSize: 11.0,
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );



Widget defMaterialButton({required String text, required IconData icon, required Function function}) =>   MaterialButton(
  onPressed: ()
  {
    function();
  },
  child:  Row(
  children: [
     Icon(icon),
    SizedBox(width: 15.w,),
    Text(
    text,
      style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.bold

      ),
    ),
  ],
),);