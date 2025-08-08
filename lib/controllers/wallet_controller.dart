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

  // Filter properties
  final Rx<TransactionType?> selectedType = Rx<TransactionType?>(null);
  final Rx<TransactionCategory?> selectedCategory = Rx<TransactionCategory?>(
    null,
  );
  final Rx<DateTime?> startDate = Rx<DateTime?>(null);
  final Rx<DateTime?> endDate = Rx<DateTime?>(null);

  Wallet get defaultWallet => wallets.first;

  double get balances {
    return transactions.fold(0.0, (sum, tx) {
      return sum + (tx.amount * tx.type.sign);
    });
  }

  // Filtered transactions getter
  List<Transaction> get filteredTransactions {
    List<Transaction> filtered = List.from(transactions);

    // Filter by type
    if (selectedType.value != null) {
      filtered = filtered.where((tx) => tx.type == selectedType.value).toList();
    }

    // Filter by category
    if (selectedCategory.value != null) {
      filtered =
          filtered
              .where((tx) => tx.category == selectedCategory.value)
              .toList();
    }

    // Filter by date range
    if (startDate.value != null) {
      filtered =
          filtered
              .where(
                (tx) => tx.createdAt.isAfter(
                  startDate.value!.subtract(const Duration(days: 1)),
                ),
              )
              .toList();
    }

    if (endDate.value != null) {
      filtered =
          filtered
              .where(
                (tx) => tx.createdAt.isBefore(
                  endDate.value!.add(const Duration(days: 1)),
                ),
              )
              .toList();
    }

    // Sort by date (newest first)
    filtered.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return filtered;
  }

  // Group transactions by date
  Map<DateTime, List<Transaction>> get groupedFilteredTransactions {
    final Map<DateTime, List<Transaction>> grouped = {};

    for (final transaction in filteredTransactions) {
      final date = DateTime(
        transaction.createdAt.year,
        transaction.createdAt.month,
        transaction.createdAt.day,
      );

      if (grouped[date] == null) {
        grouped[date] = [];
      }
      grouped[date]!.add(transaction);
    }

    // Sort each day's transactions by time (newest first)
    for (final dateTransactions in grouped.values) {
      dateTransactions.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    }

    // Sort dates (newest first)
    final sortedEntries =
        grouped.entries.toList()..sort((a, b) => b.key.compareTo(a.key));

    return Map.fromEntries(sortedEntries);
  }

  // Check if any filter is active
  bool get hasActiveFilter {
    return selectedType.value != null ||
        selectedCategory.value != null ||
        startDate.value != null ||
        endDate.value != null;
  }

  // Get filter summary text
  String getFilterSummary() {
    final List<String> filters = [];

    if (selectedType.value != null) {
      filters.add(selectedType.value!.label);
    }

    if (selectedCategory.value != null) {
      filters.add(_getCategoryLabel(selectedCategory.value!));
    }

    if (startDate.value != null || endDate.value != null) {
      if (startDate.value != null && endDate.value != null) {
        filters.add(
          '${_formatDate(startDate.value!)} - ${_formatDate(endDate.value!)}',
        );
      } else if (startDate.value != null) {
        filters.add('from ${_formatDate(startDate.value!)}');
      } else if (endDate.value != null) {
        filters.add('to ${_formatDate(endDate.value!)}');
      }
    }

    return filters.join(', ');
  }

  String _getCategoryLabel(TransactionCategory category) {
    switch (category) {
      case TransactionCategory.other:
        return 'other';
      case TransactionCategory.food:
        return 'food';
      case TransactionCategory.shopping:
        return 'shopping';
      case TransactionCategory.bills:
        return 'bills';
      case TransactionCategory.transport:
        return 'transport';
      case TransactionCategory.entertainment:
        return 'entertainment';
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  // Clear all filters
  void clearFilters() {
    selectedType.value = null;
    selectedCategory.value = null;
    startDate.value = null;
    endDate.value = null;
  }

  // Set date range
  void setDateRange(DateTime start, DateTime end) {
    startDate.value = start;
    endDate.value = end;
  }

  // Filter by transaction type
  void filterByType(TransactionType? type) {
    selectedType.value = type;
  }

  // Filter by category
  void filterByCategory(TransactionCategory? category) {
    selectedCategory.value = category;
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

  Future<void> updateTransactionByKey(
    dynamic key,
    Transaction newTransaction,
  ) async {
    // Get the existing transaction
    final existingTransaction = transactionBox.get(key);
    if (existingTransaction != null) {
      // Update the fields
      existingTransaction.name = newTransaction.name;
      existingTransaction.desc = newTransaction.desc;
      existingTransaction.amount = newTransaction.amount;
      existingTransaction.type = newTransaction.type;
      existingTransaction.category = newTransaction.category;
      existingTransaction.createdAt = newTransaction.createdAt;
      existingTransaction.updatedAt = newTransaction.updatedAt;

      // Save the changes
      await existingTransaction.save();
      loadTransactions();
    }
  }
}
