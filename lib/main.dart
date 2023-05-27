import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:medical_box/features/OtherScreens/history_screen.dart';
import 'package:medical_box/features/OtherScreens/loading_screen.dart';
import 'package:medical_box/features/OtherScreens/maps_screen.dart';
import 'package:medical_box/features/OtherScreens/profile_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_box/features/OtherScreens/home_screen.dart';
import 'package:medical_box/features/authentication/forget_password_screen.dart';
import 'package:medical_box/features/authentication/login_page.dart';
import 'package:medical_box/features/authentication/register_page.dart';
import 'package:medical_box/test.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
              textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp,decorationColor: Colors.black),
            ),
            routes: {
              'register_screen': (_) => const RegisterScreen(),
              'profile_screen': (_) => const ProfileScreen(),
              'map_screen': (_) => const MapScreen(),
              'home_screen': (_) => const HomeScreen(),
              'login_screen': (_) => const LogInScreen(),
              'forget_password_screen': (_) => const ForgetPasswordScreen(),
              'loading_screen': (_) => const LoadingPage(),
              'history_screen': (_) => const HistoryPage(),
            },
            home: const LoadingPage(),
          );
        },
    );
  }
}
