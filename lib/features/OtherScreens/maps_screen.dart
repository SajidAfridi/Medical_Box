import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:medical_box/features/OtherScreens/detail_map_screen.dart';
import 'package:medical_box/utils/app_colors.dart';
import 'package:medical_box/widgets/app_bar.dart';
import '../../widgets/drawer.dart';
import '../../widgets/header_of_all_screens.dart';
import '../../widgets/map_text_styles.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  List<String> items = <String>['User 1', 'User 2', 'User 3'];
  String selectedOption = ' ';

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
  void initState() {
    super.initState();
    selectedOption = items[0];
  }

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
              size: 22,
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
                    mapType: MapType.hybrid,
                    initialCameraPosition: _kGooglePlex,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                  ),
                ),
                Positioned(
                  left: 35.w,
                  child: Container(
                    width: 109.w,
                    height: 38.h,
                    padding: EdgeInsets.all(8.0.r),
                    decoration: ShapeDecoration(
                      color: Colours.themeColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0.r),
                      ),
                    ),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      iconDisabledColor: Colors.white,
                      iconEnabledColor: Colors.white,
                      value: selectedOption,
                      style: textStyle,
                      hint: Text(
                        selectedOption,
                        style: textStyle,
                      ),
                      dropdownColor: Colors.green,
                      onChanged: (value) {
                        setState(() {
                          Navigator.pushNamed(context, 'details_map');
                          selectedOption = value!;
                        });
                      },
                      items: items.map((String option) {
                        return DropdownMenuItem<String>(
                          alignment: AlignmentDirectional.bottomCenter,
                          value: option,
                          child: Text(option),
                        );
                      }).toList(),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: const Text('CECOS University'),
        icon: const Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kCECOS));
  }
}
