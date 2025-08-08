import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:save_quests/controllers/bindings/initial_bindings.dart';
import 'package:save_quests/models/enum/transaction_category/transaction_category.dart';
import 'package:save_quests/models/enum/transaction_type/transaction_type.dart';
import 'package:save_quests/models/transaction/transaction.dart';
import 'package:save_quests/models/wallet/wallet.dart';
import 'package:save_quests/style.dart';
import 'package:save_quests/views/main_view.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  GoogleFonts.config.allowRuntimeFetching = false;

  await Hive.initFlutter();
  Hive.registerAdapter(WalletAdapter());
  Hive.registerAdapter(TransactionAdapter());
  Hive.registerAdapter(TransactionTypeAdapter());
  Hive.registerAdapter(TransactionCategoryAdapter());

  await Hive.openBox<Wallet>('wallets');
  await Hive.openBox<Transaction>('transactions');
  await Hive.openBox<TransactionType>('transaction_types');
  await Hive.openBox<TransactionCategory>('transaction_categories');

  runApp(const SavingQuests());
}

class SavingQuests extends StatelessWidget {
  const SavingQuests({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Saving Quests',
      theme: AppTheme.light,
      initialBinding: InitialBinding(),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const MainView(),
      debugShowCheckedModeBanner: false,
    );
  }
}
