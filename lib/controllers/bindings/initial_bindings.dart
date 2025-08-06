import 'package:get/get.dart';
import 'package:save_quests/controllers/view_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ViewController());
  }
}
