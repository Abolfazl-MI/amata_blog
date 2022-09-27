import 'dart:io';

import 'package:beamer/beamer.dart';
import 'package:blog_app/gen/fonts.gen.dart';
import 'package:blog_app/presentation/routes/app_pages.dart';
import 'package:blog_app/presentation/screens/global/colors/solid_colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
// 1E1F28

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,

      theme: ThemeData(
          scaffoldBackgroundColor: SolidColors.gray,
          fontFamily: FontFamily.roboto,
          textTheme: TextTheme(
              headline1: TextStyle(
                  fontSize: 35,
                  fontFamily: FontFamily.bebas,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              headline2: TextStyle(
                  fontSize: 20,
                  fontFamily: FontFamily.bebas,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              caption: TextStyle(
                  fontFamily: FontFamily.roboto,
                  fontSize: 20,
                  color: Colors.white))),
      debugShowCheckedModeBanner: false,
        routes: AppPages.routes,
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
