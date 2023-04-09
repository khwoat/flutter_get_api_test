import 'package:get/get.dart';
import 'package:neversitup_exam/home_page/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
  }
}