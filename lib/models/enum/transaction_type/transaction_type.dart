import 'package:hive/hive.dart';

part 'transaction_type.g.dart';

@HiveType(typeId: 2) // ต้องไม่ซ้ำกับ typeId อื่น
enum TransactionType {
  @HiveField(0)
  income,     // รายรับ

  @HiveField(1)
  expense,    // รายจ่าย
}

extension TransactionTypeExtension on TransactionType {
  String get label {
    switch (this) {
      case TransactionType.income:
        return "รายรับ";
      case TransactionType.expense:
        return "รายจ่าย";
    }
  }

  int get sign {
    switch (this) {
      case TransactionType.income:
        return 1;
      case TransactionType.expense:
        return -1;
    }
  }
}
