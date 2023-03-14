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
  final _formkey = GlobalKey<FormState>();
  String error = '';

  String box_id = '';
  String admin_id = '';
  String team_leader_email = '';
  String contact_number = '';
  String team_id = '';
  String password = '';
  String confirm_password = '';

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
              width: 180,
              height: 91,
            ),
          ),
          fixSizedBox40,
          Form(
            key: _formkey,
            child: Column(
              children: [
                SizedBox(
                  width: ScreenUtil().setWidth(290),
                  height: ScreenUtil().setHeight(50),
                  child: TextFormField(
                    onChanged: (val) {
                      setState(() {
                        box_id = val;
                      });
                    },
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                    decoration: inputDecoration("Box ID"),
                  ),
                ),
                fixSizedBox10,
                SizedBox(
                  width: ScreenUtil().setWidth(290),
                  height: ScreenUtil().setHeight(50),
                  child: TextFormField(
                    obscureText: false,
                    onChanged: (val) {
                      setState(() {
                        admin_id = val;
                      });
                    },
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                    decoration: inputDecoration("Admin ID"),
                  ),
                ),
                fixSizedBox10,
                SizedBox(
                  width: ScreenUtil().setWidth(290),
                  height: ScreenUtil().setHeight(50),
                  child: TextFormField(
                    obscureText: false,
                    onChanged: (val) {
                      setState(() {
                        team_leader_email = val;
                      });
                    },
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                    decoration: inputDecoration("Team Leader Email"),
                  ),
                ),
                fixSizedBox10,
                SizedBox(
                  width: ScreenUtil().setWidth(290),
                  height: ScreenUtil().setHeight(50),
                  child: TextFormField(
                    obscureText: false,
                    onChanged: (val) {
                      setState(() {
                        contact_number = val;
                      });
                    },
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                    decoration: inputDecoration("Contact Number"),
                  ),
                ),
                fixSizedBox10,
                SizedBox(
                  width: ScreenUtil().setWidth(290),
                  height: ScreenUtil().setHeight(50),
                  child: TextFormField(
                    onChanged: (val) {
                      setState(() {
                        team_id = val;
                      });
                    },
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                    decoration: inputDecoration("Team ID"),
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
                fixSizedBox10,
                SizedBox(
                  width: ScreenUtil().setWidth(290),
                  height: ScreenUtil().setHeight(50),
                  child: TextFormField(
                    obscureText: true,
                    onChanged: (val) {
                      setState(() {
                        confirm_password = val;
                      });
                    },
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                    decoration: inputDecoration("Confirm Password"),
                  ),
                ),
                fixSizedBox20,
                ElevatedButton(
                  onPressed: () {},
                  style: buttonStyle,
                  child: const Text(
                    "Register",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
