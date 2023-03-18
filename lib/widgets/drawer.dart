import 'package:flutter/material.dart';
import 'package:medical_box/features/OtherScreens/temperature_screen.dart';
import 'package:medical_box/utils/app_colors.dart';
import 'package:medical_box/utils/app_sizebox.dart';
import 'package:medical_box/utils/drawer_buttons.dart';

Drawer drawer(_context) {
  return Drawer(
    elevation: 1,
    backgroundColor: Colours.drawerColor,
    child: SafeArea(
      child: ListView(
        children: [
          fixSizedBox30,
          SizedBox(
            height: 20,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(_context);
                    },
                    icon: const Icon(Icons.arrow_back),
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
          fixSizedBox10,
          const SizedBox(
            width: 85,
            height: 46,
            child: Placeholder(
              child: Center(
                child: Text(
                  'LOGO',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ),
            ),
          ),
          fixSizedBox40,
          DrawerButtons(
            text: 'Box',
            onPressed: () {
              Navigator.pop(_context);
            },
          ),
          DrawerButtons(
            text: 'User',
            onPressed: () {},
          ),
          DrawerButtons(
            text: 'Map',
            onPressed: () {},
          ),
          DrawerButtons(
            text: 'Temperature',
            onPressed: () {},
          ),
          DrawerButtons(
            text: 'SignOut',
            onPressed: () {},
          ),
        ],
      ),
    ),
  );
}
