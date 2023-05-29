import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:medical_box/features/authentication/login_page.dart';
import 'package:medical_box/utils/app_sizebox.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String email = '';
  String adminId = '';
  String phoneNo = '';

  Future<void> getUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    final uid = user!.uid;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    adminId = sharedPreferences.getString('adminID')!;

    final adminDoc = await FirebaseFirestore.instance
        .collection('Admins')
        .doc(adminId)
        .get();
    setState(() {
      email = adminDoc['adminEmail'];
      adminId = adminDoc['adminID'];
      phoneNo = adminDoc['phoneNo'];
    });
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 10.h),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 120.r,
                  height: 120.r,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).primaryColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: GestureDetector(
                    onTap: () {},
                    child: CircleAvatar(
                      radius: 55.r,
                      backgroundImage:
                          const AssetImage("assets/images/doctor_profile.jpeg"),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(4.r),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 20.sp,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            fixSizedBox20,
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    buildProfileItem(
                      label: 'Email',
                      value: email,
                    ),
                    SizedBox(height: 10.h),
                    buildProfileItem(
                      label: 'ID',
                      value: adminId,
                    ),
                    SizedBox(height: 10.h),
                    buildProfileItem(
                      label: 'Phone Number',
                      value: phoneNo,
                    ),
                    SizedBox(height: 20.h),
                    GestureDetector(
                      onTap: () async {
                        SharedPreferences sp =
                            await SharedPreferences.getInstance();
                        sp.setBool('isLoggedIn', false);
                        sp.setString('uid', '');
                        sp.setString('adminID', '');
                        FirebaseAuth.instance.signOut();
                        Get.offAll(() => const LogInScreen());
                      },
                      child: Container(
                        height: 50.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.r),
                          color: Theme.of(context).primaryColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            "Sign Out",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 18.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProfileItem({
    required String label,
    required String value,
  }) {
    return Container(
      height: 80.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 5.r,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        title: Text(
          label,
          style: TextStyle(
            color: Colors.black.withOpacity(0.5),
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              value,
              style: TextStyle(fontSize: 18.sp, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
