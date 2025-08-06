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
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      );
  }
}