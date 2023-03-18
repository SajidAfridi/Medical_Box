import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:medical_box/features/OtherScreens/maps_screen.dart';
import 'package:medical_box/features/OtherScreens/temperature_screen.dart';
import 'package:medical_box/features/OtherScreens/users_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_box/features/authentication/login_page.dart';
import 'package:medical_box/features/authentication/register_page.dart';

import 'features/OtherScreens/detail_temperature_screen.dart';
import 'features/OtherScreens/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Medical Box',
          theme: ThemeData(
            primarySwatch: Colors.green,
            textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
          ),
          routes: {
            'register_screen': (_) => const RegisterScreen(),
            'home_screen': (_) => const HomeScreen(),
            'map_screen': (_) => const MapScreen(),
            'users_screen': (_) => const UserScreen(),
            'temperature_screen': (_) => const TemperatureScreen(),
            'login_screen': (_) => const LogInScreen(),
            'details_temperature': (_) => const DetailTemperature(),
          },
          home: const SampleMap(),
        );
      },
    );
  }
}

class SampleMap extends StatefulWidget {
  const SampleMap({Key? key}) : super(key: key);

  @override
  State<SampleMap> createState() => _SampleMapState();
}

class _SampleMapState extends State<SampleMap> {
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.2342323423423, -122),
    zoom: 13.0,
  );
  static const CameraPosition _kLake = CameraPosition(
    target: LatLng(37.234342523423, -122),
    zoom: 13.0,
    tilt: 59,
    bearing: 192,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _kGooglePlex,
        mapType: MapType.hybrid,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: const Text('To The Lake'),
        icon: const Icon(Icons.directions_boat),
      ),
    );
  }
  Future<void> _goToTheLake()async{
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
