import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:save_quests/components/app/transaction/transaction_form.dart';
import 'package:save_quests/components/app/wallet/balance_card.dart';
import 'package:save_quests/controllers/wallet_controller.dart';

class TransactionsView extends GetView<WalletController> {
  const TransactionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Transactions",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          spacing: 10,
          children: [BalanceCard(), TransactionForm()],
        ),
      ),
    );
  }
}
