import 'package:hive/hive.dart';
import 'package:save_quests/models/enum/transaction_category/transaction_category.dart';
import 'package:save_quests/models/enum/transaction_type/transaction_type.dart';
import 'package:save_quests/models/wallet/wallet.dart';

part 'transaction.g.dart';

@HiveType(typeId: 1)
class Transaction extends HiveObject {
  @HiveField(0)
  Wallet wallet;

  @HiveField(1)
  String name;

  @HiveField(2)
  String desc;

  @HiveField(3)
  double amount;

  @HiveField(4)
  TransactionType type;

  @HiveField(5)
  TransactionCategory category;

  @HiveField(6)
  DateTime createdAt;

  @HiveField(7)
  DateTime updatedAt;

  Transaction({
    required this.wallet,
    required this.name,
    required this.desc,
    required this.amount,
    this.type = TransactionType.expense,
    this.category = TransactionCategory.other,
    required this.createdAt,
    required this.updatedAt,
  });
}
