import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:sosial_app/app/model/authModel.dart';
import 'package:sosial_app/app/services/api.dart';

class RegisterController extends GetxController {
  var formkey = GlobalKey<FormState>();
  final FocusNode usernameFocusedNode = new FocusNode();
  final FocusNode emailFocusedNode = new FocusNode();
  final FocusNode passwordFocusedNode = new FocusNode();
  final FocusNode konfirmasiFocusedNode = new FocusNode();

  late Authmodel userBio;
  var usernameController = new TextEditingController();
  var emailController = new TextEditingController();
  var passwordController = new TextEditingController();
  var konfirmasiController = new TextEditingController();

  var usernameFocused = false.obs;
  var emailFocused = false.obs;
  var passwordFocused = false.obs;
  var konfirmasiFocused = false.obs;
  var passwordIcon = true.obs;
  var konfirmasiIcon = true.obs;

  var isLoading = false.obs;
  var userMessage = ''.obs;
  var emailMessage = ''.obs;

  bool hasMultipleAt(String email) {
    return email.split('@').length - 1 > 1;
  }

  @override
  void onClose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    konfirmasiController.dispose();
    usernameFocusedNode.dispose();
    emailFocusedNode.dispose();
    passwordFocusedNode.dispose();
    konfirmasiFocusedNode.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    emailFocusedNode.addListener(
      () => emailFocused.value = emailFocusedNode.hasFocus,
    );
    passwordFocusedNode.addListener(
      () => passwordFocused.value = passwordFocusedNode.hasFocus,
    );
    konfirmasiFocusedNode.addListener(
      () => konfirmasiFocused.value = konfirmasiFocusedNode.hasFocus,
    );
    super.onInit();
  }

  Future<void> Takedata() async {
    String username;
    String email;
    String password;
    var datas;

    if (formkey.currentState!.validate()) {
      username = usernameController.text.toString();
      email = emailController.text.toString();
      password = passwordController.text.toString();

      datas = {"username": username, "email": email, "password": password};

      isLoading.value = true;
      var userData = await Api.register(datas);
      isLoading.value = false;

      print('Login dengan $email');

      if (userData['status'] == 201) {
        emailMessage.value = '';
        userMessage.value = '';

        userBio = Authmodel(
          id: userData['_id'],
          username: userData['username'],
          email: userData['email'],
        );

        Get.toNamed("/HOME");
      } else if (userData['status'] == 401) {
        emailMessage.value = userData['message'];
      } else if (userData['status'] == 402) {
        userMessage.value = userData['message'];
      } else {
        print("data hilang!!!!!!!");
      }
    } else {
      print('Form belum valid');
    }
  }
}
