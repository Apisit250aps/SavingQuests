import 'package:flutter/material.dart';
import 'package:save_quests/components/app/transaction/transaction_card.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(children: [TransactionsCard()]),
    );
  }
}
