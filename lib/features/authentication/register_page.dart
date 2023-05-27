import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  TextEditingController phoneNo = TextEditingController();

  bool loginPressed = false;

  @override
  void dispose() {
    phoneNo.dispose();
    adminEmail.dispose();
    adminID.dispose();
    password.dispose();
    confirmPassword.dispose();
    super.dispose();
  }

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
                        color: Colors.black,
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
                        color: Colors.black,
                      ),
                      decoration:
                          inputDecoration("Enter a active email address"),
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
                      keyboardType: TextInputType.phone,
                      controller: phoneNo,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp,
                        color: Colors.black,
                      ),
                      decoration: inputDecoration("Phone Number"),
                      validator: (value) {
                        final RegExp pakistanPhoneNumberRegExp =
                            RegExp(r'^\+92\d{9}$|^0{1}\d{10}$|^92{1}\d{9}$');
                        if (value == null || value.isEmpty) {
                          return 'Please Enter your Phone Number';
                        } else if (!pakistanPhoneNumberRegExp.hasMatch(value)) {
                          return 'Phone number is not correct';
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
                        color: Colors.black,
                      ),
                      decoration: inputDecoration("Confirm Password"),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the password again';
                        } else if (value != password.text) {
                          return 'The Password Doesn\'t match';
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
                        if (_formKey.currentState!.validate()) {
                          try {
                            final FirebaseAuth auth = FirebaseAuth.instance;
                            final UserCredential userCredential =
                                await auth.createUserWithEmailAndPassword(
                              email: adminEmail.text,
                              password: password.text,
                            );
                            final User? user = userCredential.user;

                            if (user != null) {
                              final adminCollection = FirebaseFirestore.instance
                                  .collection('admin');
                              await adminCollection.doc(adminID.text).set({
                                'adminID': adminID.text,
                                'adminEmail': adminEmail.text,
                                'phoneNo' : phoneNo.text,
                                'password' : password.text,
                              });
                              Navigator.pushReplacementNamed(
                                  context, 'login_screen');
                            } else {}
                          } catch (e) {
                            print(
                                'Error creating user or uploading user data: $e');
                          }
                        }
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
