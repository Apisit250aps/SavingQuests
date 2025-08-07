import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:save_quests/models/enum/transaction_category/transaction_category.dart';
import 'package:save_quests/models/enum/transaction_type/transaction_type.dart';
import 'package:save_quests/models/transaction/transaction.dart';
import 'package:save_quests/models/wallet/wallet.dart';

class WalletController extends GetxController {
  // hive box
  late Box<Wallet> walletBox;
  late Box<Transaction> transactionBox;
  late Box<TransactionType> transactionTypeBox;
  late Box<TransactionCategory> transactionCategoryBox;
  // stats
  final RxList<Wallet> wallets = <Wallet>[].obs;
  final RxList<Transaction> transactions = <Transaction>[].obs;
  // getter
  Wallet get defaultWallet => wallets[0];
  double get balances {
    return transactions.fold(0.0, (sum, tx) {
      return sum + (tx.amount * tx.type.sign);
    });
  }

  // life cycle
  @override
  void onInit() {
    super.onInit();
    //
    initialBox();
    //
    initialWallet();
    loadTransactions();
  }

  // actions
  void initialBox() {
    walletBox = Hive.box<Wallet>('wallets');
    transactionBox = Hive.box<Transaction>('transactions');
    transactionTypeBox = Hive.box<TransactionType>('transaction_types');
    transactionCategoryBox = Hive.box<TransactionCategory>(
      'transaction_categories',
    );
  }

  void initialWallet() {
    final wallet = walletBox.values.toList();
    if (wallet.isEmpty) {
      walletBox.add(
        Wallet(
          name: "default",
          desc: "-",
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );
    }
    loadWallets();
  }

  void loadWallets() {
    wallets.value = walletBox.values.toList();
  }

  void loadTransactions() async {
    final txs =
        transactionBox.values
            .where((tx) => tx.wallet.key == defaultWallet.key)
            .toList();

    transactions.assignAll(txs);
  }

  Future<void> addTransaction(Transaction tx) async {
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
