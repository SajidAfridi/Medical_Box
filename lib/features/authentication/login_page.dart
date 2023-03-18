import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_box/utils/app_colors.dart';
import 'package:medical_box/utils/app_sizebox.dart';
import 'package:medical_box/widgets/button_style.dart';
import 'package:medical_box/utils/dividers.dart';
import 'package:medical_box/widgets/input_decoration.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _formkey = GlobalKey<FormState>();
  String error = '';
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colours.whiteBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 114.h,
          ),
          Center(
            child: Image(
              image: const AssetImage("assets/images/firstaidIcon.png"),
              width: 190.w,
              height: 100.h,
            ),
          ),
          SizedBox(
            height: 60.h,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(30.w, 5.h, 30.w, 5.h),
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  SizedBox(
                    width: 290.w,
                    height: 50.h,
                    child: TextFormField(
                      onChanged: (val) {
                        setState(() {
                          email = val;
                        });
                      },
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp,
                      ),
                      decoration: inputDecoration("Email"),
                    ),
                  ),
                  SizedBox(height: 13.h),
                  SizedBox(
                    width: 290.w,
                    height: 50.h,
                    child: TextFormField(
                      obscureText: true,
                      onChanged: (val) {
                        setState(() {
                          password = val;
                        });
                      },
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp,
                      ),
                      decoration: inputDecoration("Password"),
                    ),
                  ),
                  fixSizedBox20,
                  SizedBox(
                    width: 200.w,
                    height: 40.h,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, 'home_screen');
                      },
                      style: buttonStyle,
                      child: const Text(
                        "Log In",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  fixSizedBox10,
                  SizedBox(
                    width: 200.w,
                    height: 40.h,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, 'home_screen');
                      },
                      style: buttonStyle,
                      child: Center(
                        child: Text(
                          "Login As Admin",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 18.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                  fixSizedBox20,
                  divider4,
                  fixSizedBox10,
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'register_screen');
                    },
                    style: outlinedButtonStyle,
                    child: Text(
                      "Not Registered?",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 18.sp,
                          color: Colours.themeColor),
                    ),
                  ),
                  SizedBox(height: 15.h),
                  SizedBox(
                    width: 180.w,
                    height: 40.h,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "Forgot Registration?",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontSize: 14.sp,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
