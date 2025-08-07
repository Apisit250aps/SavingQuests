import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:save_quests/models/enum/transaction_category/transaction_category.dart';
import 'package:save_quests/models/enum/transaction_type/transaction_type.dart';
import 'package:save_quests/models/transaction/transaction.dart';

class TransactionItem extends StatelessWidget {
  final Transaction transaction;

  const TransactionItem({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Icon
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            categoryIcon(transaction.category),
            color: Colors.grey[700],
            size: 20,
          ),
        ),
        const SizedBox(width: 12),

        // Name and Symbol
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                transaction.name,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                transaction.category.name,
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
            ],
          ),
        ),

        // Chart placeholder (simple line)
        // Container(
        //   width: 60,
        //   height: 30,
        //   child: CustomPaint(painter: MiniChartPainter(isPositive: isPositive)),
        // ),
        const SizedBox(width: 12),

        // Price and Change
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "฿${transaction.amount.toString()}",
              style: TextStyle(
                color: _iconColor(transaction.type),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              DateFormat('d MMM yyyy | h:m:s').format(transaction.createdAt),
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ],
    );
  }

  IconData categoryIcon(TransactionCategory category) {
    switch (category) {
      case TransactionCategory.food:
        return Icons.restaurant;
      case TransactionCategory.shopping:
        return Icons.shopping_cart;
      case TransactionCategory.bills:
        return Icons.receipt_long;
      case TransactionCategory.transport:
        return Icons.directions_car;
      case TransactionCategory.entertainment:
        return Icons.movie;
      case TransactionCategory.other:
        return Icons.category;
    }
  }

  Color _iconColor(TransactionType type) {
    switch (type) {
      case TransactionType.income:
        return Colors.green;
      case TransactionType.expense:
        return Colors.red;
    }
  }
}
