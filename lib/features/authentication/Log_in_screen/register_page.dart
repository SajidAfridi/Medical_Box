import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_box/utils/app_colors.dart';
import 'package:medical_box/utils/app_sizebox.dart';
import 'package:medical_box/utils/dividers.dart';

class Register_Screen extends StatefulWidget {
  const Register_Screen({super.key});

  @override
  State<Register_Screen> createState() => _Register_ScreenState();
}

class _Register_ScreenState extends State<Register_Screen> {
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
              image: AssetImage("assets/images/firstaid 1.png"),
              width: 180,
              height: 91,
            ),
          ),
          fixSizedBox40,
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
            child: Form(
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
                        hintText: "Box Id",
                        //errorText: "The Email is not correct",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              color: Colors.green,
                              width: 2.0,
                            )),
                      ),
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
                        hintText: "Admin ID",
                        //errorText: "The Email is not correct",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              color: Colors.green,
                              width: 2.0,
                            )),
                      ),
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
                        hintText: "Team Leader Email",
                        //errorText: "The Email is not correct",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              color: Colors.green,
                              width: 2.0,
                            )),
                      ),
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
                        hintText: "Contact Number",
                        //errorText: "The Email is not correct",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              color: Colors.green,
                              width: 2.0,
                            )),
                      ),
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
                        hintText: "Team Id",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              color: Colors.green,
                              width: 2.0,
                            )),
                      ),
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
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              color: Colors.green,
                              width: 2.0,
                            )),
                      ),
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
                        hintText: "Confirm Password",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              color: Colors.green,
                              width: 2.0,
                            )),
                      ),
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
