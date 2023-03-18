import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_box/utils/app_colors.dart';

Container homeContainer(String title, Icon subtitleIcon) {
  return Container(
    width: ScreenUtil().setWidth(345),
    height: ScreenUtil().setHeight(122),
    decoration: ShapeDecoration(
      color: Colours.listTileColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: BorderSide(color: Colors.grey.shade300, width: 1.0),
      ),
    ),
    child: Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(11, 11, 11, 0),
              child: Text(
                title,
                style: const TextStyle(
                    color: Colours.drawerColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w700),
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(11, 11, 11, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              subtitleIcon,
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.arrow_forward,
                  size: 40,
                  color: Colours.drawerColor,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
