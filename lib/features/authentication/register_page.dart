import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_box/utils/app_colors.dart';
import 'package:medical_box/utils/app_sizebox.dart';
import 'package:medical_box/widgets/button_style.dart';
import 'package:medical_box/widgets/input_decoration.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController adminID = TextEditingController();
  TextEditingController adminEmail = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  bool loginPressed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colours.whiteBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 114.h,
            ),
            Center(
              child: Image(
                image: const AssetImage("assets/images/firstaidIcon.png"),
                width: ScreenUtil().setWidth(180),
                height: ScreenUtil().setHeight(91),
              ),
            ),
            fixSizedBox40,
            Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    width: 290.w,
                    height: loginPressed ? 70.h : 50.h,
                    child: TextFormField(
                      obscureText: false,
                      controller: adminID,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp,
                      ),
                      decoration: inputDecoration("Admin ID"),
                      validator: (value) {
                        final RegExp boxIDRegExp =
                        RegExp(r'^(?=.*[A-Za-z\d])[A-Za-z\d]{6,}$');
                        if (value == null || value.isEmpty) {
                          return 'Please enter a Box ID';
                        } else if (!boxIDRegExp.hasMatch(value)) {
                          return 'Box ID must be at least 6 characters long';
                        }
                        return null;
                      },
                    ),
                  ),
                  fixSizedBox10,
                  SizedBox(
                    width: 290.w,
                    height: loginPressed ? 70.h : 50.h,
                    child: TextFormField(
                      controller: adminEmail,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp,
                      ),
                      decoration: inputDecoration("Admin Email"),
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
                  fixSizedBox10,
                  SizedBox(
                    width: 290.w,
                    height: loginPressed ? 70.h : 50.h,
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
                  fixSizedBox10,
                  SizedBox(
                    width: 290.w,
                    height: loginPressed ? 70.h : 50.h,
                    child: TextFormField(
                      obscureText: true,
                      controller: confirmPassword,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp,
                      ),
                      decoration: inputDecoration("Confirm Password"),
                      validator: (value){
                        if(value != password.text){
                          return 'The Password Doesn\'t match';
                        }
                        return null;
                      },
                    ),
                  ),
                  fixSizedBox20,
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        loginPressed = true;
                      });
                      if (_formKey.currentState!.validate()) {
                        Navigator.pushReplacementNamed(
                            context, 'login_screen');
                      }
                      return;
                    },
                    style: buttonStyle,
                    child: Text(
                      "Register",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
