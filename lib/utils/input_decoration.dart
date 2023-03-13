import 'package:flutter/material.dart';

import 'app_colors.dart';

InputDecoration inputDecoration(String hintText) {
  return InputDecoration(
    focusedBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(
        width: 1,
        color: Colours.borderColor,
      ),
    ),
    enabledBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(
        width: 1,
        color: Colours.borderColor,
      ),
    ),
    focusColor: Colors.green,
    hintText: hintText,
    //errorText: "The Email is not correct",
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(
        color: Colors.green,
        width: 2.0,
      ),
    ),
  );
}
