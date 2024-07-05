import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget info_card(String title, String info) {
  return Expanded(
    child: Container(
      margin: EdgeInsets.all(22.sp),
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 22.0),
      decoration: BoxDecoration(
        color: Color(0xFFE55870),
      ),
      child: (ScreenUtil().orientation == Orientation.landscape)
          ? Row(
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(
                  width: 12.0,
                ),
                Text(
                  info,
                  style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            )
          : Column(
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 6.0,
                ),
                Text(
                  info,
                  style: TextStyle(
                      fontSize: 34.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            ),
    ),
  );
}
