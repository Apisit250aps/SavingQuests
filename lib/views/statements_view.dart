import 'package:flutter/material.dart';

class StatementView extends StatelessWidget {
  const StatementView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [Text("Transactions")]),
    );
  }
}
