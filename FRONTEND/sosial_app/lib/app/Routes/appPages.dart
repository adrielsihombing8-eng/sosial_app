import 'package:flutter/widgets.dart';
import 'package:get/route_manager.dart';
import 'package:sosial_app/app/Routes/routes.dart' as Routes;
import 'package:sosial_app/app/views/auth/loginScreen.dart';
import 'package:sosial_app/app/views/auth/registerScreen.dart';

class Apppages {
  static final routes = [
    GetPage(name: Routes.routes.INITIAL, page: () => Loginscreen()),
    GetPage(name: Routes.routes.LOGIN, page: () => Loginscreen()),
    GetPage(name: Routes.routes.REGISTER, page: () => Registerscreen()),
  ];
}
