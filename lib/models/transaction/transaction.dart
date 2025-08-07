import 'package:hive/hive.dart';
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
  int type; // -1 = รายจ่าย, 1 = รายรับ

  @HiveField(5)
  DateTime createdAt;

  @HiveField(6)
  DateTime updatedAt;

  Transaction({
    required this.wallet,
    required this.name,
    required this.desc,
    required this.amount,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
  });
}
