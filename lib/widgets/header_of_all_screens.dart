import 'package:flutter/material.dart';
import 'package:medical_box/utils/app_colors.dart';

Row header(context, String text, Icon icons) {
  return Row(
    children: [
      IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back,
          color: Colours.themeColor,
          size: 26,
        ),
      ),
      Text(
        text,
        style: const TextStyle(
            fontSize: 20,
            color: Colours.themeColor,
            fontWeight: FontWeight.w400),
      ),
      const SizedBox(width: 6),
      icons,
    ],
  );
}
