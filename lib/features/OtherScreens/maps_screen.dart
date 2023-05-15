import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../utils/app_colors.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/header_of_all_screens.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(33.997484888266584, 71.46691819101065),
    zoom: 14.4746,
  );

  static const CameraPosition _kCECOS = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(33.95631023099256, 71.43736221534408),
      zoom: 18.151926040649414);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(17.h, 4.w, 13.h, 5.w),
            child: header(
              'Your Location',
              const Icon(
                Icons.location_on_outlined,
                color: Colours.drawerColor,
                size: 22,
              ),
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Container(
                  color: Colors.blueGrey,
                  height: double.infinity,
                  width: double.infinity,
                  child: GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: _kGooglePlex,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                  ),
                ),
                Positioned(
                  left: 70.w,
                  bottom: 10.h,
                  child: Container(
                    width: 200.w,
                    height: 150.h,
                    padding: EdgeInsets.all(8.0.r),
                    decoration: ShapeDecoration(
                      color: Colours.themeColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0.r),
                      ),
                    ),
                    child: Container(
                      margin: EdgeInsets.fromLTRB(10.w, 0, 10.w, 5.h),
                      height: 80.h,
                      width: 250.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5.r),
                        ),
                        image: const DecorationImage(
                            image: AssetImage("assets/images/temp.png"),
                            fit: BoxFit.fill),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: _goToTheLake,
      //   label: const Text('CECOS University'),
      //   icon: const Icon(Icons.directions_boat),
      // ),
    );
  }

  // Future<void> _goToTheLake() async {
  //   final GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(_kCECOS));
  // }
}
