import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:sosial_app/app/services/api.dart';
import 'package:sosial_app/app/services/auth_controller.dart';
import 'package:sosial_app/app/services/auth_store.dart';

class splashChecker extends StatefulWidget {
  const splashChecker({super.key});

  @override
  State<splashChecker> createState() => _splashCheckerState();
}

class _splashCheckerState extends State<splashChecker> {
  var authController = Get.find<AuthController>();

  @override
  void initState() {
    tokenChecker();
    super.initState();
  }

  Future<void> tokenChecker() async {
    var token = await AuthStore.getToken();

    if (token == null) {
      if (!mounted) return;
      Get.offAllNamed("/LOGIN");
      return;
    }
    
    bool isValidToken = await Api.cekToken(token!);

    authController.loadDataUser();

    if (!mounted) return;

    if (isValidToken) {
      authController.loadDataUser();
      Get.offAllNamed("/HOME");
    } else {
      await AuthStore.clear();
      Get.offAllNamed("/LOGIN");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: CircularProgressIndicator());
  }
}
