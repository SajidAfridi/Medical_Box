import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_box/features/authentication/login_page.dart';
import 'package:medical_box/utils/app_colors.dart';
import 'package:medical_box/utils/app_sizebox.dart';
import 'package:medical_box/utils/dividers.dart';

class DrawerButtons extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  const DrawerButtons({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  State<DrawerButtons> createState() => _DrawerButtonsState();
}

class _DrawerButtonsState extends State<DrawerButtons> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if(widget.text == "Box"){
          Navigator.pushNamed(context, 'home_screen');
        }
        else if(widget.text == "User"){
          Navigator.pushNamed(context, 'users_screen');
        }
        else if(widget.text == "Map"){
          Navigator.pushNamed(context, 'map_screen');
        }
        else if(widget.text == "Temperature"){
          Navigator.pushNamed(context, 'temperature_screen');
        }
        else if(widget.text == 'SignOut'){
          Navigator.pushReplacementNamed(context, 'login_screen');
        }
      },
      child: SizedBox(
        height: ScreenUtil().setHeight(82),
        width: ScreenUtil().setWidth(42),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  widget.text,
                  style: const TextStyle(
                    color: Colours.whiteBackgroundColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              fixSizedBox10,
              SizedBox(
                  width: ScreenUtil().setWidth(130.0), child: drawerDivider),
            ],
          ),
        ),
      ),
    );
  }
}
