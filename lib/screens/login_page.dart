import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_box/utils/Buttons/login_button_common.dart';
import 'package:medical_box/utils/app_colors.dart';
import 'package:medical_box/utils/app_sizebox.dart';
import 'package:medical_box/core/widgets/common_text_fields.dart';
import 'package:medical_box/utils/Buttons/text_button_forgot_registration.dart';
import 'package:medical_box/utils/dividers.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final controller = TextEditingController();
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
              image: AssetImage("assets/images/firstaid 1.png"),
              width: 193,
              height: 100,
            ),
          ),
          fixSizedBox50,
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
            child: Form(
              child: Column(
                children: [
                  TextFormField(
                    onChanged: (val) {
                      setState(() {
                        email = val;
                      });
                    },
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(
                          width: 1,
                          color: Colours.borderColor,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(
                          width: 1,
                          color: Colours.borderColor,
                        ),
                      ),
                      focusColor: Colors.green,
                      hintText: "Password",
                      //errorText: "The Email is not correct",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            color: Colors.green,
                            width: 2.0,
                          )),
                    ),
                  ),
                  fixSizedBox10,
                  TextFormField(
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
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(
                          width: 1,
                          color: Colours.borderColor,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(
                          width: 1,
                          color: Colours.borderColor,
                        ),
                      ),
                      focusColor: Colors.green,
                      hintText: "Password",
                      //errorText: "The Email is not correct",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            color: Colors.green,
                            width: 2.0,
                          )),
                    ),
                  ),
                  fixSizedBox20,
                  ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.green),
                        elevation: MaterialStateProperty.all<double>(1.0),
                        maximumSize:
                            MaterialStateProperty.all(const Size(200, 40)),
                        minimumSize:
                            MaterialStateProperty.all(const Size(200, 40)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: const BorderSide(
                                        color: Colours.borderColor)))),
                    child: const Text(
                      "Log In",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  fixSizedBox10,
                  divider4,
                  fixSizedBox10,
                  ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.green),
                        elevation: MaterialStateProperty.all<double>(1.0),
                        maximumSize:
                            MaterialStateProperty.all(const Size(200, 40)),
                        minimumSize:
                            MaterialStateProperty.all(const Size(200, 40)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: const BorderSide(
                                        color: Colours.borderColor)))),
                    child: const Text(
                      "Login As Admin",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.green),
                        elevation: MaterialStateProperty.all<double>(1.0),
                        maximumSize:
                            MaterialStateProperty.all(const Size(200, 40)),
                        minimumSize:
                            MaterialStateProperty.all(const Size(200, 40)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: const BorderSide(
                                        color: Colours.borderColor)))),
                    child: const Text(
                      "Login As User",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  fixSizedBox10,
                  forgotRegistrationButton,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
