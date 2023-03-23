import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_box/utils/app_colors.dart';
import 'package:medical_box/widgets/app_bar.dart';
import '../../widgets/drawer.dart';
import '../../widgets/header_of_all_screens.dart';
import '../../widgets/map_text_styles.dart';

class DetailMap extends StatefulWidget {
  const DetailMap({Key? key}) : super(key: key);

  @override
  State<DetailMap> createState() => _DetailMapState();
}

class _DetailMapState extends State<DetailMap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SizedBox(
        width: ScreenUtil().setWidth(163),
        child: drawer(context),
      ),
      appBar: appBar,
      body: Column(
        children: [
          header(
            context,
            'Map',
            const Icon(
              Icons.location_on_outlined,
              color: Colours.drawerColor,
              size: 17,
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Container(
                  color: Colors.blueGrey,
                  height: double.infinity,
                  width: double.infinity,
                ),
                Positioned(
                  top: 10.h,
                    left: 35.w,
                    child: Container(
                      height: 113.h,
                      width: 116.w,
                      padding: EdgeInsets.all(8.0.r),
                      decoration: ShapeDecoration(
                        color: Colours.themeColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0.r),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Name: ',style: textStyle,),
                          Text('Location: ',style: textStyle,),
                          Text('Box ID: ',style: textStyle,),
                          Icon(Icons.access_alarm_sharp,color: Colors.white,)
                        ],
                      ),
                    )
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
