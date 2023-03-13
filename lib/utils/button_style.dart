import 'package:flutter/material.dart';
import 'app_colors.dart';

ButtonStyle buttonStyle = ButtonStyle(
  backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
  elevation: MaterialStateProperty.all<double>(1.0),
  maximumSize: MaterialStateProperty.all(const Size(200, 40)),
  minimumSize: MaterialStateProperty.all(const Size(200, 40)),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
      side: BorderSide(color: Colours.borderColor),
    ),
  ),
);
