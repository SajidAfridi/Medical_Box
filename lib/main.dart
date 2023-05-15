import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:medical_box/features/OtherScreens/maps_screen.dart';
import 'package:medical_box/features/OtherScreens/profile_screen.dart';
import 'package:medical_box/features/OtherScreens/users_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_box/features/authentication/login_page.dart';
import 'package:medical_box/features/authentication/register_page.dart';
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
              'profile_screen': (_) => const ProfileScreen(),
              'map_screen': (_) => const MapScreen(),
              'users_screen': (_) => const UserScreen(),
              'login_screen': (_) => const LogInScreen(),
            },
            home: const LogInScreen(),
          );
        },
    );
  }
}
