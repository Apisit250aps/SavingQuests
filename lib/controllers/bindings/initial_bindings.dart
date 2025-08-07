import 'package:get/get.dart';
import 'package:save_quests/controllers/view_controller.dart';
import 'package:save_quests/controllers/wallet_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ViewController());
    Get.put(WalletController());
  }
}
