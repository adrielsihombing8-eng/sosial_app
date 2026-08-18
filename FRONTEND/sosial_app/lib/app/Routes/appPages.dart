import 'package:flutter/widgets.dart';
import 'package:get/route_manager.dart';
import 'package:sosial_app/app/Routes/routes.dart' as Routes;
import 'package:sosial_app/app/bindings/Home_bindings.dart';
import 'package:sosial_app/app/bindings/login_bindings.dart';
import 'package:sosial_app/app/bindings/register_binding.dart';
import 'package:sosial_app/app/services/auth.dart';
import 'package:sosial_app/app/views/auth/loginScreen.dart';
import 'package:sosial_app/app/views/auth/registerScreen.dart';
import 'package:sosial_app/app/views/dashboard/dashboard.dart';
import 'package:sosial_app/app/views/dashboard/pages/home.dart';

class Apppages {
  static final routes = [
    GetPage(name: Routes.routes.SPLASHCHECKER, page: () => splashChecker()),
    GetPage(name: Routes.routes.INITIAL, page: () => Loginscreen(), binding: LoginBindings()),
    GetPage(name: Routes.routes.LOGIN, page: () => Loginscreen(), binding: LoginBindings()),
    GetPage(name: Routes.routes.REGISTER, page: () => Registerscreen(), binding: RegisterBinding()),
    GetPage(name: Routes.routes.DASHBOARD, page:() => Dashboard()),
  ];
}
