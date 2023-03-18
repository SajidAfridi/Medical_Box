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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Image(
              image: AssetImage("assets/images/firstaidIcon.png"),
              width: 193,
              height: 100,
            ),
          ),
          fixSizedBox50,
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  SizedBox(
                    width: ScreenUtil().setWidth(290),
                    height: ScreenUtil().setHeight(50),
                    child: TextFormField(
                      onChanged: (val) {
                        setState(() {
                          email = val;
                        });
                      },
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                      decoration: inputDecoration("Email"),
                    ),
                  ),
                  fixSizedBox10,
                  SizedBox(
                    width: ScreenUtil().setWidth(290),
                    height: ScreenUtil().setHeight(50),
                    child: TextFormField(
                      obscureText: true,
                      onChanged: (val) {
                        setState(() {
                          password = val;
                        });
                      },
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                      decoration: inputDecoration("Password"),
                    ),
                  ),
                  fixSizedBox20,
                  ElevatedButton(
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
                  fixSizedBox10,
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, 'home_screen');
                    },
                    style: buttonStyle,
                    child: const Text(
                      "Login As Admin",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  fixSizedBox10,
                  divider4,
                  fixSizedBox10,
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'register_screen');
                    },
                    style: outlinedButtonStyle,
                    child: const Text(
                      "Not Registered?",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                        color: Colors.white
                      ),
                    ),
                  ),
                  fixSizedBox10,
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Forgot Registration?",
                      style: TextStyle(
                          fontWeight: FontWeight.w400, color: Colors.black),
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
