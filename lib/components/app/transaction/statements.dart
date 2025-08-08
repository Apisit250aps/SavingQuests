import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:save_quests/components/app/transaction/transaction_item.dart';
import 'package:save_quests/components/share/app_card.dart';
import 'package:save_quests/controllers/wallet_controller.dart';
import 'package:save_quests/models/enum/transaction_type/transaction_type.dart';
import 'package:save_quests/models/enum/transaction_category/transaction_category.dart';
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
                        color: Colors.pink[50],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            controller.getFilterSummary(),
                            style:  TextStyle(
                              fontSize: 12,
                              color: Colors.pink.shade300,
                            ),
                          ),
                          const SizedBox(width: 4),
                          GestureDetector(
                            onTap: () => controller.clearFilters(),
                            child: Icon(
                              Icons.close,
                              size: 14,
                              color: Colors.pink.shade300,
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

class TransactionFilterSheet extends GetWidget<WalletController> {
  const TransactionFilterSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              const Text(
                'Filter Transactions',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              TextButton(
                onPressed: () => controller.clearFilters(),
                child: const Text('Clear All'),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Transaction Type Filter
          const Text(
            'Transaction Type',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Obx(
            () => Wrap(
              spacing: 8,
              children: [
                FilterChip(
                  label: const Text('All'),
                  selected: controller.selectedType.value == null,
                  onSelected: (selected) {
                    controller.selectedType.value = null;
                  },
                ),
                ...TransactionType.values.map(
                  (type) => FilterChip(
                    label: Text(type.label),
                    selected: controller.selectedType.value == type,
                    onSelected: (selected) {
                      controller.selectedType.value = selected ? type : null;
                    },
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Category Filter
          const Text(
            'Category',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Obx(
            () => Wrap(
              spacing: 8,
              children: [
                FilterChip(
                  label: const Text('All'),
                  selected: controller.selectedCategory.value == null,
                  onSelected: (selected) {
                    controller.selectedCategory.value = null;
                  },
                ),
                ...TransactionCategory.values.map(
                  (category) => FilterChip(
                    label: Text(_getCategoryLabel(category)),
                    selected: controller.selectedCategory.value == category,
                    onSelected: (selected) {
                      controller.selectedCategory.value =
                          selected ? category : null;
                    },
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Date Range Filter
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }

  String _getCategoryLabel(TransactionCategory category) {
    switch (category) {
      case TransactionCategory.other:
        return 'Other';
      case TransactionCategory.food:
        return 'Food';
      case TransactionCategory.shopping:
        return 'Shopping';
      case TransactionCategory.bills:
        return 'Bills';
      case TransactionCategory.transport:
        return 'Transport';
      case TransactionCategory.entertainment:
        return 'Entertainment';
    }
  }
}
