import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';

InputDecoration inputDecoration(String hintText) {
  return InputDecoration(
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0.r)),
      borderSide: BorderSide(
        width: 2.w,
        color: Colours.borderColor,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0.r)),
      borderSide: BorderSide(
        width: 1.w,
        color: Colours.borderColor,
      ),
    ),
    focusColor: Colors.green,
    hintText: hintText,
    contentPadding: EdgeInsets.fromLTRB(20.w, 17.h, 184.w, 14.h),
    //errorText: "The Email is not correct",
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.r)),
      borderSide: BorderSide(
        color: Colors.green,
        width: 2.0.w,
      ),
    ),
  );
}
