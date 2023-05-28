import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:medical_box/utils/app_colors.dart';
import 'package:medical_box/utils/app_sizebox.dart';
import 'package:medical_box/utils/dividers.dart';
import 'package:medical_box/widgets/input_decoration.dart';
import 'package:medical_box/widgets/button_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../OtherScreens/home_screen.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _formkey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool loginPressed = false;

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  Future<void> _showErrorSnackbar(String errorMessage) async {
    final snackBar = SnackBar(content: Text(errorMessage));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colours.whiteBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 114.h),
            Center(
              child: Image(
                image: const AssetImage("assets/images/firstaidIcon.png"),
                width: 190.w,
                height: 100.h,
              ),
            ),
            SizedBox(height: 60.h),
            Padding(
              padding: EdgeInsets.fromLTRB(30.w, 5.h, 30.w, 5.h),
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    SizedBox(
                      width: 290.w,
                      height: loginPressed ? 70.h : 50.h,
                      child: TextFormField(
                        controller: email,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16.sp,
                          color: Colors.black,
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
                    SizedBox(height: 13.h),
                    SizedBox(
                      width: 290.w,
                      height: loginPressed ? 70.h : 50.h,
                      child: TextFormField(
                        obscureText: true,
                        controller: password,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16.sp,
                          color: Colors.black,
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
                        onPressed: () async {
                          setState(() {
                            loginPressed = true;
                          });
                          if (_formkey.currentState!.validate()) {
                            try {
                              UserCredential userCredential = await FirebaseAuth
                                  .instance
                                  .signInWithEmailAndPassword(
                                      email: email.text.toString(),
                                      password: password.text.toString());
                              String uid = userCredential.user!.uid;
                              SharedPreferences sharedPreferences =
                                  await SharedPreferences.getInstance();
                              sharedPreferences.setString('uid', uid);
                              sharedPreferences.setBool('isLoggedIn', true);
                              Get.offAll(() => const HomeScreen());
                            } catch (e) {
                              _showErrorSnackbar(
                                'Login failed. Please check your credentials and try again.',
                              );
                            }
                          }
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account?',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontSize: 14.sp,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, 'register_screen');
                          },
                          // style: outlinedButtonStyle,
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.green,
                              fontSize: 18.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.h),
                    SizedBox(
                      width: 194.w,
                      child: divider4,
                    ),
                    fixSizedBox5,
                    SizedBox(
                      width: 180.w,
                      height: 40.h,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, 'forget_password_screen');
                        },
                        child: Text(
                          "Forgot Password?",
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