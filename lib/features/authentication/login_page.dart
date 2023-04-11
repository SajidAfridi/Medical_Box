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

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool logginPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colours.whiteBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
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
                    SingleChildScrollView(
                      child: SizedBox(
                        width: 290.w,
                        height: logginPressed? 70.h: 50.h,
                        child: TextFormField(
                          // autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: email,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16.sp,
                          ),
                          decoration: inputDecoration("Email"),
                          validator: (value) {
                            final RegExp emailRegExp =
                                RegExp(r'^[\w-]+@([\w-]+\.)+[\w-]{2,4}$');
                            if (value == null || value.isEmpty) {
                              return 'Please enter an email address';
                            } else if (!emailRegExp.hasMatch(value)) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 13.h),
                    SizedBox(
                      width: 290.w,
                      height: logginPressed? 70.h: 50.h,
                      child: TextFormField(
                        obscureText: true,
                        controller: password,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16.sp,
                        ),
                        decoration: inputDecoration("Password"),
                        validator: (value) {
                          final RegExp passwordRegExp =
                              RegExp(r'^(?=.*[A-Za-z\d])[A-Za-z\d]{6,}$');
                          if (value == null || value.isEmpty) {
                            return 'Please enter a password';
                          } else if (!passwordRegExp.hasMatch(value)) {
                            return 'Password must be at least 6 characters long';
                          }
                          return null;
                        },
                      ),
                    ),
                    fixSizedBox20,
                    SizedBox(
                      width: 200.w,
                      height: 40.h,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            logginPressed = true;
                            if (_formkey.currentState!.validate()) {
                              Navigator.pushReplacementNamed(
                                  context, 'home_screen');
                            }
                            return;
                          });
                        },
                        style: buttonStyle,
                        child: Text(
                          "Log In",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 18.sp,
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
                          setState(() {
                            // if (_formkey.currentState!.validate()) {
                            //
                            // }
                            // else {
                            //   logginPressed = true;
                            // }
                            // return;
                            Navigator.pushReplacementNamed(
                                context, 'home_screen');

                          });
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
      ),
    );
  }
}
