import 'package:beamer/beamer.dart';
import 'package:blog_app/gen/fonts.gen.dart';
import 'package:blog_app/presentation/routes/app_pages.dart';
import 'package:blog_app/presentation/screens/global/colors/solid_colors.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
// 1E1F28
// #c
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: AppPages.routerDelagate,
      routeInformationParser: BeamerParser(),
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
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
