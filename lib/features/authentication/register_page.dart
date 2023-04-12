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
                    width: ScreenUtil().setWidth(290),
                    height: ScreenUtil().setHeight(50),
                    child: TextFormField(
                      obscureText: false,
                      controller: adminID,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp,
                      ),
                      decoration: inputDecoration("Admin ID"),
                    ),
                  ),
                  fixSizedBox10,
                  SizedBox(
                    width: ScreenUtil().setWidth(290),
                    height: ScreenUtil().setHeight(50),
                    child: TextFormField(
                      controller: adminEmail,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp,
                      ),
                      decoration: inputDecoration("Admin Email"),
                    ),
                  ),
                  fixSizedBox10,
                  SizedBox(
                    width: ScreenUtil().setWidth(290),
                    height: ScreenUtil().setHeight(50),
                    child: TextFormField(
                      obscureText: true,
                      controller: password,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp,
                      ),
                      decoration: inputDecoration("Password"),
                    ),
                  ),
                  fixSizedBox10,
                  SizedBox(
                    width: ScreenUtil().setWidth(290),
                    height: ScreenUtil().setHeight(50),
                    child: TextFormField(
                      obscureText: true,
                      controller: confirmPassword,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp,
                      ),
                      decoration: inputDecoration("Confirm Password"),
                    ),
                  ),
                  fixSizedBox20,
                  ElevatedButton(
                    onPressed: () {
                      // context.read<AuthenticationService>().signUp(
                      //     email: box_id.text.trim(),
                      //     password: password.text.trim());
                      Navigator.pushNamed(context, 'login_screen');
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
