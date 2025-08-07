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

      // บันทึกและรอให้เสร็จ
      await walletBox.add(newWallet);
      print("Created new wallet with key: ${newWallet.key}");
    }

    loadWallets();
  }

  void loadWallets() {
    wallets.assignAll(walletBox.values.toList());
    print("Loaded wallets: ${wallets.length}");
  }

  void loadTransactions() {
    if (wallets.isEmpty) {
      print("No wallets available");
      return;
    }

    final allTransactions = transactionBox.values.toList();
    print("Total transactions in box: ${allTransactions.length}");

    final filteredTransactions =
        allTransactions
            .where((tx) => tx.walletId == defaultWallet.key)
            .toList();

    transactions.assignAll(filteredTransactions);
    print("Transactions for default wallet: ${transactions.length}");
  }

  Future<void> addTransaction(Transaction tx) async {
    // ให้แน่ใจว่า wallet reference ถูกต้อง
    tx.walletId = defaultWallet.key;

    // บันทึกและรอให้เสร็จ
    await transactionBox.add(tx);
    print("Added transaction with key: ${tx.key}");

    // รีโหลดข้อมูล
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
