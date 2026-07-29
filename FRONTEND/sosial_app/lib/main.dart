import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sosial_app/app/Routes/appPages.dart';
import 'package:sosial_app/app/Routes/routes.dart';
import 'package:sosial_app/app/services/auth.dart';
import 'package:sosial_app/app/services/auth_controller.dart';
import 'package:sosial_app/app/views/auth/loginScreen.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences pref = await SharedPreferences.getInstance();
  String? token = pref.getString("token");
  Get.put(AuthController(),permanent: true);
  runApp(MainApp(token: token));
}

class MainApp extends StatelessWidget {
  final String? token;
  const MainApp({ required this.token, super.key});

  bool get isLoggedIn => token != null && !JwtDecoder.isExpired(token!);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: isLoggedIn? routes.SPLASHCHECKER : routes.INITIAL,
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

