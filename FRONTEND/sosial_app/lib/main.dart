import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sosial_app/app/Routes/appPages.dart';
import 'package:sosial_app/app/Routes/routes.dart';
import 'package:sosial_app/app/views/auth/loginScreen.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: routes.INITIAL,
      getPages: Apppages.routes,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      enableLog: true,
      defaultTransition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}
