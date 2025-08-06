import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:save_quests/components/app/transaction/transaction_item.dart';
import 'package:save_quests/components/share/app_card.dart';

class TransactionsCard extends StatelessWidget {
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
              IconButton(
                onPressed: () {
                  print(">>> hello world");
                },
                icon: Icon(PhosphorIcons.plus(), size: 20),
              ),
            ],
          ),
          const SizedBox(height: 25),
          Column(
            children: [
              // Bitcoin
              TransactionItem(
                icon: Icons.currency_bitcoin,
                name: 'Bitcoin',
                symbol: 'BTC',
                price: '\$32,811.00',
                change: '-2.27%',
                isPositive: false,
              ),
              const SizedBox(height: 16),
              // Ethereum
              TransactionItem(
                icon: Icons.diamond,
                name: 'Ethereum',
                symbol: 'ETH',
                price: '\$2,489.10',
                change: '+3.90%',
                isPositive: true,
              ),
              const SizedBox(height: 16),
              TransactionItem(
                icon: Icons.attach_money,
                name: 'Tether',
                symbol: 'USDT',
                price: '\$1.00',
                change: '0.00%',
                isPositive: null,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
