import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:save_quests/components/ui/app_bottom_navigation.dart';
import 'package:save_quests/controllers/view_controller.dart';

class MainView extends GetView<ViewController> {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Obx(
          () => Text(controller.currentIndex.value == 0 ? "Home" : "Settings"),
        ),
      ),
      body: PageView(
        controller: controller.pageController,
        onPageChanged: controller.onPageChanged,
        children: [],
      ),
      bottomNavigationBar: AppBottomNavigation(),
    );
  }
}
