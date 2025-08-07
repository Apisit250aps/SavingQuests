import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:save_quests/models/enum/transaction_category/transaction_category.dart';
import 'package:save_quests/models/enum/transaction_type/transaction_type.dart';
import 'package:save_quests/models/transaction/transaction.dart';
import 'package:save_quests/models/wallet/wallet.dart';

class WalletController extends GetxController {
  late Box<Wallet> walletBox;
  late Box<Transaction> transactionBox;
  late Box<TransactionType> transactionTypeBox;
  late Box<TransactionCategory> transactionCategoryBox;

  final RxList<Wallet> wallets = <Wallet>[].obs;
  final RxList<Transaction> transactions = <Transaction>[].obs;

  Wallet get defaultWallet => wallets.first;

  double get balances {
    return transactions.fold(0.0, (sum, tx) {
      return sum + (tx.amount * tx.type.sign);
    });
  }

  @override
  void onInit() {
    super.onInit();

    _setup();
  }

  void _setup() async {
    initialBox();
    await initialWallet();
    loadTransactions();
  }

  void initialBox() async {
    walletBox = Hive.box<Wallet>('wallets');
    transactionBox = Hive.box<Transaction>('transactions');
    transactionTypeBox = Hive.box<TransactionType>('transaction_types');
    transactionCategoryBox = Hive.box<TransactionCategory>(
      'transaction_categories',
    );
  }

  Future<void> initialWallet() async {
    final walletList = walletBox.values.toList();

    if (walletList.isEmpty) {
      final newWallet = Wallet(
        name: "default",
        desc: "-",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await walletBox.add(newWallet);
    }

    loadWallets();
  }

  void loadWallets() {
    wallets.assignAll(walletBox.values.toList());
  }

  void loadTransactions() {
    if (wallets.isEmpty) {
      return;
    }
    final allTransactions = transactionBox.values.toList();
    final filteredTransactions =
        allTransactions
            .where((tx) => tx.walletId == defaultWallet.key)
            .toList();
    transactions.assignAll(filteredTransactions);
  }

  Future<void> addTransaction(Transaction tx) async {
    tx.walletId = defaultWallet.key;
    await transactionBox.add(tx);
    loadTransactions();
  }

  Future<void> updateTransaction(Transaction tx) async {
    await tx.save();
    loadTransactions();
  }

  Future<void> deleteTransaction(Transaction tx) async {
    await tx.delete();
    loadTransactions();
  }

  Future<void> deleteTransactionByKey(dynamic key) async {
    await transactionBox.delete(key);
    loadTransactions();
  }
}
