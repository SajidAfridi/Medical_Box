import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _formkey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();

  bool isSendingOTP = false;
  bool isResendEnabled = true;
  int resendCoolDown = 30;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forget Password"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),
                Text(
                  "Enter your email to reset password:",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(height: 20.h),
                TextFormField(
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16.sp,
                    color: Colors.black,
                  ),
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
                  decoration: const InputDecoration(
                    hintText: "Email",
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
                SizedBox(height: 20.h),
                SizedBox(
                  width: double.infinity,
                  child: Hero(
                    tag: 'send_button',
                    child: ElevatedButton(
                      onPressed: isResendEnabled ? handleForgetPassword : null,
                      child: isSendingOTP
                          ? const CircularProgressIndicator()
                          : const Text(
                              "Get OTP",
                              style: TextStyle(color: Colors.black),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void handleForgetPassword() async {
    if (_formkey.currentState!.validate()) {
      setState(() {
        isSendingOTP = true;
        isResendEnabled = false;
        resendCoolDown = 30;
      });
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text);
        showDialog(
          context: context,
          builder: (context) {
            return Hero(
              tag: 'success_dialog',
              child: AlertDialog(
                title: const Text(
                  "OTP Sent",
                  style: TextStyle(color: Colors.black),
                ),
                content: const Text(
                  "An OTP has been sent to your email.",
                  style: TextStyle(color: Colors.black),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context); // Go back to login screen
                    },
                    child:
                        const Text("OK", style: TextStyle(color: Colors.black)),
                  ),
                ],
              ),
            );
          },
        );
      } catch (e) {
        // Failed to send OTP
        showDialog(
          context: context,
          builder: (context) {
            return Hero(
              tag: 'error_dialog',
              child: AlertDialog(
                title: const Text(
                  "Error",
                  style: TextStyle(color: Colors.redAccent),
                ),
                content: const Text(
                  "Failed to send OTP. Please try again later.",
                  style: TextStyle(color: Colors.redAccent),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context); // Go back to login screen
                    },
                    child:
                        const Text("OK", style: TextStyle(color: Colors.black)),
                  ),
                ],
              ),
            );
          },
        );
      } finally {
        setState(() {
          isSendingOTP = false;
          isResendEnabled = true;
        });
      }
    }
  }

  @override
  void dispose() {
    email.dispose();
    super.dispose();
  }
}
