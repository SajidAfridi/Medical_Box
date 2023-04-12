import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:medical_box/features/OtherScreens/detail_map_screen.dart';
import 'package:medical_box/features/OtherScreens/maps_screen.dart';
import 'package:medical_box/features/OtherScreens/temperature_screen.dart';
import 'package:medical_box/features/OtherScreens/users_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_box/features/authentication/login_page.dart';
import 'package:medical_box/features/authentication/register_page.dart';
import 'features/OtherScreens/detail_temperature_screen.dart';
import 'features/OtherScreens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
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
              'details_map': (_) => const DetailMap(),
              'users_screen': (_) => const UserScreen(),
              'temperature_screen': (_) => const TemperatureScreen(),
              'login_screen': (_) => const LogInScreen(),
              'details_temperature': (_) => const DetailTemperature(),
            },
            home: const LogInScreen(),
          );
        },
    );
  }
}
