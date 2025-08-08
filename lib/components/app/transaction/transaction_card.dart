import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
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
            ],
          ),
          const SizedBox(height: 25),
          Obx(() {
            final transactions = controller.transactions;
            final sortedTxs = [...transactions];
            sortedTxs.sort((b, a) => a.createdAt.compareTo(b.createdAt));
            if (sortedTxs.isEmpty) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    'No transactions found',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ),
              );
            }
            return Column(
              spacing: 10,
              children:
                  sortedTxs
                      .map((tx) => TransactionItem(transaction: tx))
                      .toList(),
            );
          }),
        ],
      ),
    );
  }
}
