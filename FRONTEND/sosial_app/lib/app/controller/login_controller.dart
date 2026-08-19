import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:flutter/material.dart';
import 'package:sosial_app/app/model/authModel.dart';
import 'package:sosial_app/app/services/api.dart';
import 'package:sosial_app/app/services/auth_controller.dart';

class LoginController extends GetxController {
  var authController = Get.find<AuthController>();
  var formkey = GlobalKey<FormState>();
  final FocusNode emailFocusedNode = new FocusNode();
  final FocusNode passwordFocusedNode = new FocusNode();
  var emailController = new TextEditingController();
  var passwordController = new TextEditingController();

  late Authmodel models;
  var isLoading = false.obs;
  var emailMessage = ''.obs;
  var passwordMessage = ''.obs;

  var emailFocused = false.obs;
  var passwordFocused = false.obs;
  var passwordIcons = true.obs;

  void togglePassword() {
    passwordIcons.value = !passwordIcons.value;
  }

  Future<void> Takedata() async {
    if (formkey.currentState!.validate()) {
      String email = emailController.text.toString();
      String password = passwordController.text.toString();

      var userLogin = {"email": email, "password": password};

      isLoading.value = true;
      var apiLogin = await Api.login(userLogin);
      isLoading.value = false;

      print(apiLogin['statuscode']);

      if (apiLogin['statuscode'] == 200) {
        emailMessage.value = '';
        passwordMessage.value = '';

        models = Authmodel(
          id: apiLogin['_id'],
          username: apiLogin['username'],
          email: apiLogin['email'],
        );

        authController.setUser(models);

        Get.toNamed("/HOME");
      }
      else if (apiLogin['statuscode'] == 401) {
        emailMessage.value = 'email salah';
      }
      else if (apiLogin['statuscode'] == 402) {
        passwordMessage.value = 'password salah';
      }
      else {
        emailMessage.value = 'Terjadi kesalahan';
      }

      print('Login dengan $email');
    } else {
      print('Form belum valid');
    }
  }

  @override
  void onInit() {
    emailFocusedNode.addListener(() {
      emailFocused.value = emailFocusedNode.hasFocus;
    });
    passwordFocusedNode.addListener(() {
      passwordFocused.value = passwordFocusedNode.hasFocus;
    });
    super.onInit();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocusedNode.dispose();
    passwordFocusedNode.dispose();
    super.onClose();
  }
}
