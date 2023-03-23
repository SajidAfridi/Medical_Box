import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_box/widgets/app_bar.dart';
import 'package:medical_box/widgets/drawer.dart';

class DetailTemperature extends StatefulWidget {
  const DetailTemperature({Key? key}) : super(key: key);

  @override
  State<DetailTemperature> createState() => _DetailTemperatureState();
}

class _DetailTemperatureState extends State<DetailTemperature> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Container(
        width: 163.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(15.r),
          ),
        ),
        child: drawer(context),
      ),
      appBar: appBar,
      body: const Center(
        child: Text('Temperature Details'),
      ),
    );
  }
}
