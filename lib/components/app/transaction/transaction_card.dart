import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:save_quests/components/app/transaction/transaction_item.dart';
import 'package:save_quests/components/share/app_card.dart';
import 'package:save_quests/controllers/wallet_controller.dart';

class TransactionsCard extends GetWidget<WalletController> {
  const TransactionsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              const Text(
                'Transactions',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              // IconButton(
              //   onPressed: () {
              //     print(">>> hello world");
              //   },
              //   icon: Icon(PhosphorIcons.plus(), size: 20),
              // ),
            ],
          ),
          const SizedBox(height: 25),
          Obx(
            () => Column(
              spacing: 10,
              children:
                  controller.transactions.reversed
                      .map((tx) => TransactionItem(transaction: tx))
                      .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
