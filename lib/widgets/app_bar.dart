import 'package:flutter/material.dart';
import 'package:medical_box/utils/app_colors.dart';

final appBar = AppBar(
  backgroundColor: Colors.transparent,
  elevation: 0.0,
  centerTitle: true,
  title: const Text(
    'Medical Box',
    style: TextStyle(color: Colours.themeColor),
  ),
  iconTheme: const IconThemeData(color: Colours.drawerColor),
);
