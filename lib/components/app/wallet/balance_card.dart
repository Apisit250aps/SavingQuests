import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:save_quests/components/share/app_card.dart';
import 'package:save_quests/controllers/wallet_controller.dart';

class BalanceCard extends GetWidget<WalletController> {
  const BalanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Balance", style: TextStyle(fontSize: 18)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(
                () => Text(
                  "฿ ${controller.balances}",
                  style: TextStyle(fontSize: 32),
                ),
              ),
              // Column(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   crossAxisAlignment: CrossAxisAlignment.end,
              //   children: [Text("+ 130%"), Text("+50%")],
              // ),
            ],
          ),
          Divider(color: Colors.pink[200]),
        ],
      ),
    );
  }
}
