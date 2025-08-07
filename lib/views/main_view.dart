import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:save_quests/components/app/transaction/transaction_form.dart';
import 'package:save_quests/controllers/view_controller.dart';
import 'package:save_quests/views/transactions_view.dart';

class MainView extends GetView<ViewController> {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(
            controller.views[controller.currentIndex.value].title,
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ),
      body: PageView(
        controller: controller.pageController,
        onPageChanged: controller.onPageChanged,
        children: List.generate(
          controller.views.length,
          (index) => controller.views[index].view,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:
            () => Get.bottomSheet(
              TransactionForm(),
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
            ),
        shape: CircleBorder(),
        backgroundColor: Colors.black87,
        child: Icon(PhosphorIcons.piggyBank(), size: 32.0, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // bottomNavigationBar: AppBottomNavigation(),
    );
  }
}
