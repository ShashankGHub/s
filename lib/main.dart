import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:rova_23/screens/Home_page_rova.dart';
import 'package:rova_23/screens/access_location.dart';
import 'package:rova_23/screens/select_crops_screen.dart';
import 'package:rova_23/screens/splash_screen.dart';
//import 'dart:convert';
//import 'package:http/http.dart' as http;

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      systemNavigationBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ));

    return MaterialApp(
      //supportedLocales: ,
      debugShowCheckedModeBanner: false,
      title: 'Rova-23',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/queryScreen': (context) => const SelectCropsScreen(
              data: '',
            ),
        '/accessLocationScreen': (context) => AccessLocationScreen(
              data: '',
            ),
      },
    );
  }
}
