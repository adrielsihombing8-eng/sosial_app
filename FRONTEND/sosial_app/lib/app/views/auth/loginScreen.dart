import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:sosial_app/app/Routes/routes.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  var formkey = GlobalKey<FormState>();
  final FocusNode emailFocusedNode = new FocusNode();
  final FocusNode passwordFocusedNode = new FocusNode();
  var emailController = new TextEditingController();
  var passwordController = new TextEditingController();

  bool emailFocused = false;
  bool passwordFocused = false;
  bool passwordIcons = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void Takedata() {
    if (formkey.currentState!.validate()) {
      String email = emailController.text.toString();
      String password = passwordController.text.toString();
      print('Login dengan $email');
    } else {
      print('Form belum valid');
    }
    //api login
  }

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
            top: 150,
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
            top: 155,
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
            top: 250,
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
            left: MediaQuery.of(context).size.width / 2 - 200,
            child: SingleChildScrollView(
              child: Container(
                width: 400,
                color: Colors.transparent,
                child: Form(
                  key: formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 60),
                      Text(
                        "Email",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextFormField(
                        controller: emailController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty) return 'Wajib isi';
                          if (!value.contains("@")) return 'email tidak valid';
                          return null;
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white30,
                          hintText: "alim@example.com",
                          hintStyle: TextStyle(color: Colors.grey),
                          contentPadding: EdgeInsets.symmetric(vertical: 15),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Password",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextFormField(
                        obscureText: passwordIcons,
                        controller: passwordController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return 'Wajib di isi';
                          return null;
                        },
                        decoration: InputDecoration(
                          fillColor: Colors.white30,
                          filled: true,
                          hintText: "*****",
                          hintStyle: TextStyle(color: Colors.grey),
                          contentPadding: EdgeInsets.symmetric(vertical: 15),
                          suffixIcon: IconButton(onPressed: () => setState(() {
                            passwordIcons = !passwordIcons;
                          }), icon: Icon(passwordIcons ? Icons.visibility_off : Icons.visibility))
                        ),
                      ),
                      SizedBox(height: 70),
                      Container(
                        width: 150,
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {
                            Takedata();
                          },
                          child: const Text("Login"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
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
                            child: Text("Sign Up")
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
