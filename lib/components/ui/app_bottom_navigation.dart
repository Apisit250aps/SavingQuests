import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:save_quests/controllers/view_controller.dart';

class AppBottomNavigation extends GetWidget<ViewController> {
  const AppBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BottomNavigationBar(
        currentIndex: controller.currentIndex.value,
        onTap: controller.changePage,
        type: BottomNavigationBarType.fixed,
        items: List.generate(
          controller.views.length,
          (index) => BottomNavigationBarItem(
            icon: Icon(controller.views[index].icon),
            label: controller.views[index].title,
          ),
        ),
      ),
    );
  }
}
