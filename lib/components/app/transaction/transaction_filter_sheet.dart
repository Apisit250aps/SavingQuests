import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:save_quests/controllers/wallet_controller.dart';
import 'package:save_quests/models/enum/transaction_category/transaction_category.dart';
import 'package:save_quests/models/enum/transaction_type/transaction_type.dart';

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
