import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:save_quests/components/app/transaction/transaction_filter_sheet.dart';
import 'package:save_quests/components/app/transaction/transaction_item.dart';
import 'package:save_quests/components/share/app_card.dart';
import 'package:save_quests/controllers/wallet_controller.dart';
import 'package:intl/intl.dart';

class Statements extends GetWidget<WalletController> {
  const Statements({super.key});

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
                'Statements',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () => _showFilterDialog(context),
                icon:Icon(PhosphorIcons.funnelSimple(), size: 20),
              ),
            ],
          ),

          // Filter Status
          Obx(
            () =>
                controller.hasActiveFilter
                    ? Container(
                      margin: const EdgeInsets.only(top: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            controller.getFilterSummary(),
                            style:  TextStyle(
                              fontSize: 12,
                              color: Colors.blue.shade300,
                            ),
                          ),
                          const SizedBox(width: 4),
                          GestureDetector(
                            onTap: () => controller.clearFilters(),
                            child: Icon(
                              Icons.close,
                              size: 14,
                              color: Colors.blue.shade300,
                            ),
                          ),
                        ],
                      ),
                    )
                    : const SizedBox.shrink(),
          ),

          const SizedBox(height: 16),

          // Transactions List
          Obx(() {
            final groupedTransactions = controller.groupedFilteredTransactions;
            if (groupedTransactions.isEmpty) {
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
                  groupedTransactions.entries.map((entry) {
                    final date = entry.key;
                    final transactions = entry.value;
                    final sortedTxs = [...transactions]; // สร้างสำเนา
                    sortedTxs.sort(
                      (b, a) => a.createdAt.compareTo(b.createdAt),
                    );

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Date Header
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            _formatDateHeader(date),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                            ),
                          ),
                        ),

                        // Transactions for this date
                        ...sortedTxs.map(
                          (tx) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: TransactionItem(transaction: tx),
                          ),
                        ),

                        const SizedBox(height: 8),
                      ],
                    );
                  }).toList(),
            );
          }),
        ],
      ),
    );
  }

  String _formatDateHeader(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final targetDate = DateTime(date.year, date.month, date.day);

    if (targetDate == today) {
      return 'Today';
    } else if (targetDate == yesterday) {
      return 'Yesterday';
    } else {
      return DateFormat('dd MMM yyyy', 'en').format(date);
    }
  }

  void _showFilterDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => const TransactionFilterSheet(),
    );
  }
}

