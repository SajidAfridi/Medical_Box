import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_box/utils/app_colors.dart';
import 'package:medical_box/utils/app_sizebox.dart';
import 'package:medical_box/widgets/app_bar.dart';
import 'package:medical_box/widgets/header_of_all_screens.dart';
import 'package:medical_box/widgets/map_text_styles.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

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
                      onTap: (){
                        Navigator.pushNamed(context, 'profile_screen');
                      },
                      child: const ClipRRect(
                        child: Image(
                          image: AssetImage('assets/images/profile.png'),
                        ),
                      ),
                    ),
                    SizedBox(width: 104.w,),
                    Text('Welcome',style: textStyle,),
                  ],
                ),
                fixSizedBox10,
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
                margin: const EdgeInsets.all(0),
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        SizedBox(
                          width: 345.w,
                          height: 80.h,
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 12.0.w, vertical: 2.0.h),
                            tileColor: Colours.listTileColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0.r),
                              side: BorderSide(
                                  color: Colors.grey.shade300, width: 1.0.w),
                            ),
                            leading: const ClipRRect(
                              child: Image(
                                image: AssetImage('assets/images/profile.png'),
                              ),
                            ),
                            title: Text(
                              'Name ${index + 1}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0.sp,
                              ),
                            ),
                            subtitle: Text(
                              'name',
                              style: TextStyle(
                                fontSize: 16.0.sp,
                              ),
                            ),
                            trailing: InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, 'map_screen');
                              },
                              child: const Icon(Icons.arrow_forward),
                            ),
                          ),
                        ),
                        const Divider(),
                      ],
                    );
                  },
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
