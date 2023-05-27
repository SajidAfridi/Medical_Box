import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_box/utils/app_colors.dart';
import 'package:medical_box/utils/app_sizebox.dart';
import 'package:medical_box/widgets/header_of_all_screens.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(17.h, 4.w, 13.h, 5.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, 'profile_screen');
                    },
                    child: CircleAvatar(
                      radius: 22.sp,
                      backgroundImage: const AssetImage('assets/images/profile.png'),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Text(
                    'Welcome',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18.sp,
                    ),
                  ),
                ],
              ),
              fixSizedBox20,
              header(
                'Users',
                Icon(
                  Icons.person_outline_outlined,
                  color: Colours.drawerColor,
                  size: 22.sp,
                ),
              ),
              Expanded(
                child: Card(
                  elevation: 0,
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  child: ListView.separated(
                    separatorBuilder: (BuildContext context, int index) =>
                    const Divider(height: 5),
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        width: double.infinity,
                        height: 80.h,
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12.0.w,
                            vertical: 2.0.h,
                          ),
                          tileColor: Colours.listTileColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0.r),
                            side: BorderSide(
                              color: Colors.grey.shade300,
                              width: 1.0.w,
                            ),
                          ),
                          leading: CircleAvatar(
                            radius: 25.sp,
                            backgroundImage:
                            const AssetImage('assets/images/profile.png'),
                          ),
                          title: Text(
                            'Name ${index + 1}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.sp,
                            ),
                          ),
                          subtitle: Text(
                            'Name',
                            style: TextStyle(
                              fontSize: 16.sp,
                            ),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward,
                            size: 20.sp,
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, 'map_screen');
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
