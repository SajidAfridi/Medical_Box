import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_box/utils/app_sizebox.dart';
import 'package:medical_box/widgets/app_bar.dart';
import 'package:medical_box/widgets/drawer.dart';
import 'package:medical_box/utils/app_colors.dart';
import 'package:medical_box/widgets/home_containers.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Container(
        width: ScreenUtil().setWidth(163),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: drawer(context),
      ),
      appBar: appBar,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 20),
          scrollDirection: Axis.vertical,
          children: [
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, 'users_screen');
              },
              child: homeContainer(
                'Users',
                const Icon(
                  Icons.person,
                  color: Colours.drawerColor,
                  size: 50,
                ),
              ),
            ),
            fixSizedBox10,
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, 'map_screen');
              },
              child: homeContainer(
                'Map',
                const Icon(
                  Icons.map,
                  color: Colours.drawerColor,
                  size: 50,
                ),
              ),
            ),
            fixSizedBox10,
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, 'temperature_screen');
              },
              child: homeContainer(
                'Temperature',
                const Icon(
                  Icons.scale,
                  color: Colours.drawerColor,
                  size: 50,
                ),
              ),
            ),
            fixSizedBox10,
          ],
        ),
      ),
    );
  }
}
