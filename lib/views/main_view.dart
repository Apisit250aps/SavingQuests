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
      bottomNavigationBar: AppBottomNavigation(),
    );
  }
}
