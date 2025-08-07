import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:save_quests/components/app/transaction/transaction_card.dart';
import 'package:save_quests/components/share/app_card.dart';
import 'package:save_quests/controllers/wallet_controller.dart';

class HomeView extends GetView<WalletController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(spacing: 10, children: [BalanceCard(), TransactionsCard()]),
    );
  }
}

class BalanceCard extends StatelessWidget {
  const BalanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Balance"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("฿5000", style: TextStyle(fontSize: 32)),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [Text("+ 130%"), Text("+50%")],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
