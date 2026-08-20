import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:sosial_app/app/controller/registerController.dart';

class Registerscreen extends StatefulWidget {
  const Registerscreen({super.key});

  @override
  State<Registerscreen> createState() => _RegisterscreenState();
}

class _RegisterscreenState extends State<Registerscreen> {
  final controller = Get.find<RegisterController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: -40,
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
              top: 150,
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
      
            Positioned(
              top: 100,
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
              top: 105,
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
              top: 200,
              left: MediaQuery.of(context).size.width / 2 - 90,
              child: Container(
                height: 80,
                width: 200,
                color: Colors.transparent,
                child: Text(
                  "Hallo Dear👋",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
      
            Positioned(
              top: 250,
              bottom: 10,
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
                        SizedBox(height: 5),
                        Text(
                          "Username",
                          style: TextStyle(
                            fontSize: 15,
                            color: controller.usernameFocused.value
                                ? Colors.blueAccent
                                : Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextFormField(
                          focusNode: controller.usernameFocusedNode,
                          controller: controller.usernameController,
                          onFieldSubmitted: (_) => FocusScope.of(
                            context,
                          ).requestFocus(controller.emailFocusedNode),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty)
                              return 'Wajib isi';
                            return null;
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: controller.usernameFocused.value
                                ? Colors.white60
                                : Colors.white30,
                            hintText: "alim@example.com",
                            hintStyle: TextStyle(color: Colors.grey),
                            contentPadding: EdgeInsets.symmetric(vertical: 15),
                          ),
                        ),
                        SizedBox(height: 8),
                        Obx(
                          () => controller.userMessage.value.isNotEmpty
                              ? Padding(
                                  padding: EdgeInsets.only(bottom: 8),
                                  child: Text(
                                    controller.userMessage.value,
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 13,
                                    ),
                                  ),
                                )
                              : SizedBox.shrink(),
                        ),
                
                        SizedBox(height: 5),
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
                          onFieldSubmitted: (_) => FocusScope.of(
                            context,
                          ).requestFocus(controller.passwordFocusedNode),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty)
                              return 'Wajib isi';
                            if (!value.contains("@") &&
                                !controller.hasMultipleAt(value))
                              return 'email tidak valid';
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
                
                        SizedBox(height: 5),
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
                          obscureText: controller.passwordIcon.value,
                          focusNode: controller.passwordFocusedNode,
                          controller: controller.passwordController,
                          onFieldSubmitted: (_) => FocusScope.of(
                            context,
                          ).requestFocus(controller.konfirmasiFocusedNode),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty)
                              return 'Wajib di isi';
                            // if (!RegExp(r'[A-Z]').hasMatch(value)) {
                            //   return 'harus ada huruf besar';
                            // }
                            // if (!RegExp(r'[a-z]').hasMatch(value)) {
                            //   return 'harus ada huruf kecil';
                            // }
                            // if (!RegExp(r'[0-9]').hasMatch(value)) {
                            //   return 'harus ada angka';
                            // }
                            // if (!RegExp(
                            //   r'[!@#$%^&*(),.?":{}|<>]',
                            // ).hasMatch(value)) {
                            //   return 'Harus ada simbol unik (!@#%\$, dll)';
                            // }
                            return null;
                          },
                          decoration: InputDecoration(
                            fillColor: controller.passwordFocused.value
                                ? Colors.white60
                                : Colors.white30,
                            filled: true,
                            hintText: "*****",
                            hintStyle: TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () => setState(() {
                                controller.passwordIcon.value =
                                    !controller.passwordIcon.value;
                              }),
                              icon: Icon(
                                controller.passwordIcon.value
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Konfirmasi",
                          style: TextStyle(
                            fontSize: 15,
                            color: controller.konfirmasiFocused.value
                                ? Colors.blueAccent
                                : Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextFormField(
                          obscureText: controller.konfirmasiIcon.value,
                          onFieldSubmitted: (_) =>
                              controller.konfirmasiFocusedNode.unfocus(),
                          focusNode: controller.konfirmasiFocusedNode,
                          controller: controller.konfirmasiController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty)
                              return 'Wajib di isi';
                            if (value != controller.passwordController.text) {
                              return 'Invalid Confirmation';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            fillColor: controller.konfirmasiFocused.value
                                ? Colors.white60
                                : Colors.white30,
                            filled: true,
                            hintText: "*****",
                            hintStyle: TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                controller.konfirmasiIcon.value
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.grey[700],
                              ),
                              onPressed: () => setState(
                                () => controller.konfirmasiIcon.value =
                                    !controller.konfirmasiIcon.value,
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
                                controller.Takedata();
                              },
                              child: controller.isLoading.value
                                  ? SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                      ),
                                    )
                                  : const Text("Register"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                foregroundColor: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Udah punya akun?"),
                            TextButton(
                              onPressed: () {
                                Get.toNamed("/LOGIN");
                              },
                              child: Text("Sign In"),
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
      ),
    );
  }
}
