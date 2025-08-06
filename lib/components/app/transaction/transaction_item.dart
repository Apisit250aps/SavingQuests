import 'package:flutter/material.dart';

class TransactionItem extends StatelessWidget {
  final IconData icon;
  final String name;
  final String symbol;
  final String price;
  final String change;
  final bool? isPositive;

  const TransactionItem({
    super.key,
    required this.icon,
    required this.name,
    required this.symbol,
    required this.price,
    required this.change,
    this.isPositive,
  });

  @override
  Widget build(BuildContext context) {
    Color changeColor;
    if (isPositive == null) {
      changeColor = Colors.grey;
    } else if (isPositive!) {
      changeColor = Colors.green;
    } else {
      changeColor = Colors.red;
    }

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
          child: Icon(icon, color: Colors.grey[700], size: 20),
        ),
        const SizedBox(width: 12),

        // Name and Symbol
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                symbol,
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
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
              price,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              change,
              style: TextStyle(
                color: changeColor,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
