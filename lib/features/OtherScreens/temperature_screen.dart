import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_box/widgets/header_of_all_screens.dart';

import '../../utils/app_colors.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/drawer.dart';

class TemperatureScreen extends StatefulWidget {
  const TemperatureScreen({Key? key}) : super(key: key);

  @override
  State<TemperatureScreen> createState() => _TemperatureScreenState();
}

class _TemperatureScreenState extends State<TemperatureScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SizedBox(
        width: 163.w,
        child: drawer(context),
      ),
      appBar: appBar,
      body: Padding(
        padding: EdgeInsets.fromLTRB(17.w, 4.h, 13.w, 5.h),
        child: Column(children: [
          header(
            context,
            "Temperature",
            const Icon(
              Icons.scale,
              color: Colours.drawerColor,
              size: 22,
            ),
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: 10, // replace with the length of your data list
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    Card(
                      elevation: 0.sh,
                      margin: EdgeInsets.symmetric(
                          horizontal: 2.0.w, vertical: 1.0.h),
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 12.0.w, vertical: 8.0.h),
                        tileColor: Colours.listTileColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0.r),
                          side: BorderSide(
                              color: Colors.grey.shade300, width: 1.0.w),
                        ),
                        title: Text(
                          'Item title',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0.sp,
                          ),
                        ),
                        subtitle: Text(
                          'Item subtitle',
                          style: TextStyle(
                            fontSize: 16.0.sp,
                          ),
                        ),
                        isThreeLine: false,
                        trailing: IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, 'details_temperature');
                          },
                          icon: Icon(Icons.arrow_forward),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, 'details_temperature');
                        },
                      ),
                    ),
                    const Divider(),
                  ],
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}
