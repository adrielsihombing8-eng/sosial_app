import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:flutter/material.dart';
import 'package:sosial_app/app/model/authModel.dart';
import 'package:sosial_app/app/services/api.dart';

class LoginController extends GetxController {
  var formkey = GlobalKey<FormState>();
  final FocusNode emailFocusedNode = new FocusNode();
  final FocusNode passwordFocusedNode = new FocusNode();
  var emailController = new TextEditingController();
  var passwordController = new TextEditingController();

  late Authmodel models;
  var isLoading = false.obs;
  var emailMessage = ''.obs;

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

      if (apiLogin['statuscode'] == 200) {
        emailMessage.value = '';

        models = Authmodel(
          id: apiLogin['_id'],
          username: apiLogin['username'],
          email: apiLogin['email'],
        );
      }
      else{
        emailMessage.value = 'email tidak ada';
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
