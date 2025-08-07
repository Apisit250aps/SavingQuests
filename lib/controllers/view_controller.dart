import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:save_quests/views/wallet_view.dart';
import 'package:save_quests/views/statements_view.dart';

class ViewController extends GetxController {
  var currentIndex = 0.obs;

  late PageController pageController;

  final List<ViewItem> views = [
    ViewItem(
      view: WalletView(),
      icon: Icon(PhosphorIcons.wallet(), size: 32.0),
      title: "Wallet",
    ),
    ViewItem(
      view: StatementView(),
      icon: Icon(PhosphorIcons.cardholder(), size: 32.0),
      title: "Statements",
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: 0);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void changePage(int index) {
    currentIndex.value = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  void onPageChanged(int index) {
    currentIndex.value = index;
  }
}

class ViewItem {
  final Widget view;
  final Icon icon;
  final String title;

  ViewItem({required this.view, required this.icon, required this.title});
}
