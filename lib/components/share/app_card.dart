import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppCard extends StatelessWidget {
  final Widget? child;
  const AppCard({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color:  Colors.pink.shade50, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.pink.withAlpha((255.0 * 0.10).round()),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
  }
}
