import 'package:get/instance_manager.dart';
import 'package:sosial_app/app/controller/loginController.dart';

class LoginBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
  }
}