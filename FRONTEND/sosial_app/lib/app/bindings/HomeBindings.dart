import 'package:get/instance_manager.dart';
import 'package:sosial_app/app/controller/feedController.dart';

class HomeBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<FeedController>(() => FeedController(), fenix: true);
  }
}