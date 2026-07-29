import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:sosial_app/app/Routes/routes.dart';
import 'package:sosial_app/app/controller/login_controller.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final controller = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            child: Container(
              height: 300,
              width: MediaQuery.of(context).size.width,
              color: Colors.black,
              child: Image.asset(
                "assets/img/aset3.jpg",
                width: MediaQuery.of(context).size.width,
                height: 300,
              ),
            ),
          ),

          Positioned(
            top: 200,
            child: SafeArea(
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width,
                    minHeight:
                        MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.top,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Column(
                      children: [
                        //isi form
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            top: 200,
            left: MediaQuery.of(context).size.width / 2 - 45,
            child: Container(
              height: 90,
              width: 90,
              color: Colors.transparent,
              child: CircleAvatar(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
            ),
          ),

          Positioned(
            top: 205,
            left: MediaQuery.of(context).size.width / 2 - 40,
            child: Container(
              height: 80,
              width: 80,
              color: Colors.transparent,
              child: CircleAvatar(
                child: Icon(
                  Icons.book_online_outlined,
                  size: 70,
                  color: Colors.blue,
                ),
                backgroundColor: Colors.white,
                foregroundColor: Colors.white,
              ),
            ),
          ),

          Positioned(
            top: 290,
            left: MediaQuery.of(context).size.width / 2 - 80,
            child: Container(
              height: 100,
              width: 180,
              color: Colors.transparent,
              child: Text(
                "Welcome👋",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: Colors.blue,
                ),
              ),
            ),
          ),

          Positioned(
            top: 280,
            left: MediaQuery.of(context).size.width / 2 - 150,
            child: SingleChildScrollView(
              child: Container(
                width: 300,
                color: Colors.transparent,
                child: Form(
                  key: controller.formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 70),
                      Text(
                        "Email",
                        style: TextStyle(
                          fontSize: 15,
                          color: controller.emailFocused.value
                              ? Colors.blueAccent
                              : Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextFormField(
                        focusNode: controller.emailFocusedNode,
                        controller: controller.emailController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onFieldSubmitted: (_) => FocusScope.of(
                          context,
                        ).requestFocus(controller.passwordFocusedNode),
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return 'Wajib isi';
                          if (!value.contains("@")) return 'email tidak valid';
                          return null;
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: controller.emailFocused.value
                              ? Colors.white60
                              : Colors.white30,
                          hintText: "alim@example.com",
                          hintStyle: TextStyle(color: Colors.grey),
                          contentPadding: EdgeInsets.symmetric(vertical: 15),
                        ),
                      ),
                      SizedBox(height: 8),
                      Obx(
                        () => controller.emailMessage.value.isNotEmpty
                            ? Padding(
                                padding: EdgeInsets.only(bottom: 8),
                                child: Text(
                                  controller.emailMessage.value,
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 13,
                                  ),
                                ),
                              )
                            : SizedBox.shrink(),
                      ),

                      SizedBox(height: 20),
                      Text(
                        "Password",
                        style: TextStyle(
                          fontSize: 15,
                          color: controller.passwordFocused.value
                              ? Colors.blueAccent
                              : Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextFormField(
                        focusNode: controller.passwordFocusedNode,
                        obscureText: controller.passwordIcons.value,
                        controller: controller.passwordController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onFieldSubmitted: (_) =>
                            controller.passwordFocusedNode.unfocus(),
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return 'Wajib di isi';
                          return null;
                        },
                        decoration: InputDecoration(
                          fillColor: controller.passwordFocused.value
                              ? Colors.white60
                              : Colors.white30,
                          filled: true,
                          hintText: "*****",
                          hintStyle: TextStyle(color: Colors.grey),
                          contentPadding: EdgeInsets.symmetric(vertical: 15),
                          suffixIcon: IconButton(
                            onPressed: () => setState(() {
                              controller.passwordIcons.value =
                                  !controller.passwordIcons.value;
                            }),
                            icon: Icon(
                              controller.passwordIcons.value
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 40),
                      Container(
                        width: 150,
                        height: 40,
                        child: Obx(
                          () => ElevatedButton(
                            onPressed: () {
                              controller.isLoading.value? null : controller.Takedata();
                            },
                            child: controller.isLoading.value
                                ? SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                                : Text("Login"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Belum punya akun?"),
                          TextButton(
                            onPressed: () {
                              Get.toNamed("/REGISTER");
                            },
                            child: Text("Sign Up"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
