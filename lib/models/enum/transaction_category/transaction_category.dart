import 'package:hive/hive.dart';

part 'transaction_category.g.dart';

@HiveType(typeId: 3) // ต้องไม่ซ้ำกับ typeId ที่ใช้ไปแล้ว
enum TransactionCategory {
  @HiveField(0)
  other,        // อื่นๆ

  @HiveField(1)
  food,         // อาหาร

  @HiveField(2)
  shopping,     // ชอปปิง

  @HiveField(3)
  bills,        // บิล

  @HiveField(4)
  transport,    // ค่าเดินทาง

  @HiveField(5)
  entertainment // บันเทิง
}
