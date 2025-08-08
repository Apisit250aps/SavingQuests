import 'package:flutter/material.dart';
import 'package:save_quests/components/app/transaction/statements.dart';

class TransactionView extends StatelessWidget {
  const TransactionView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(children: [Statements()]),
    );
  }
}
