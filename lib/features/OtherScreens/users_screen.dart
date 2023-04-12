import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_box/utils/app_colors.dart';
import 'package:medical_box/widgets/app_bar.dart';
import 'package:medical_box/widgets/header_of_all_screens.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Padding(
        padding: EdgeInsets.fromLTRB(17.h, 4.w, 13.h, 5.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          header(
            'Users',
            const Icon(
              Icons.person_outline_outlined,
              color: Colours.drawerColor,
              size: 22,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10, // replace with the length of your data list
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    Card(
                      elevation: 0,
                      margin: const EdgeInsets.all(0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 8.0),
                            tileColor: Colours.listTileColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              side: BorderSide(
                                  color: Colors.grey.shade300, width: 1.0),
                            ),
                            title: const Text(
                              'Item title',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                            subtitle: const Text(
                              'Item subtitle',
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                            isThreeLine: true,
                            trailing: const Icon(Icons.arrow_forward),
                            onTap: () {
                              Navigator.pushNamed(context, 'map_screen');
                            },
                          ),
                        ],
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
