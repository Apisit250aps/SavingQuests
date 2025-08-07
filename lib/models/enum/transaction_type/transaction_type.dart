import 'package:hive/hive.dart';

part 'transaction_type.g.dart';

@HiveType(typeId: 2) // ต้องไม่ซ้ำกับ typeId อื่น
enum TransactionType {
  @HiveField(0)
  income,     // รายรับ

  @HiveField(1)
  expense,    // รายจ่าย
}
