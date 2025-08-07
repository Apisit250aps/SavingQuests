import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:save_quests/components/app/transaction/transaction_card.dart';
import 'package:save_quests/components/app/wallet/balance_card.dart';
import 'package:save_quests/controllers/wallet_controller.dart';

class WalletView extends GetView<WalletController> {
  const WalletView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(spacing: 10, children: [BalanceCard(), TransactionsCard()]),
    );
  }
}
