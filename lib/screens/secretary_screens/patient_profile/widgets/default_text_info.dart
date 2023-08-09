import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DefaultTextInfo extends StatelessWidget {
  final String caption;
  final String text;
  final IconData icon;

  const DefaultTextInfo({
    super.key,
    required this.caption,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
        start: 2.h,
        end: 2.h,
      ),      child: Material(
        shadowColor: Colors.grey.shade50,
        //elevation: .5,
        elevation: 2.0,
        borderRadius: BorderRadiusDirectional.all(Radius.circular(10.r)),
        color: Colors.white,
        child: Container(
          height: 60.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.all(Radius.circular(10.r)),
            //border: const Border.fromBorderSide(BorderSide.none),
            border: Border.all(
                width: 1,
                color: Colors.grey.shade500
            ),
          ),
          padding: EdgeInsetsDirectional.only(
            start: 6.h,
            //top: 6.h
          ),
          child: Align(
            alignment: AlignmentDirectional.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.only(
                    end: 10.w,
                    //top: 6.h,
                  ),
                  child: Icon(
                    icon,
                    size: 25.h,
                    color: Colors.purple.shade300,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        caption,
                        style: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 12.w,
                          fontWeight: FontWeight.w400,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        text,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13.5.w,
                          fontWeight: FontWeight.w400,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}