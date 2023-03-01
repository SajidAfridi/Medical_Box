import 'package:flutter/material.dart';
import 'package:medical_box/screens/home_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // routes: {
      //   MyRoute.homePage: (context)=> const HomePage(),
      //   MyRoute.loginPage: (context)=> const HomePage(),
      //   MyRoute.mapPage: (context)=> const HomePage(),
      // },
      // initialRoute: MyRoute.homePage,
      home: const HomePage(),
    );
  }
}


