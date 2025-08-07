// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_category.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransactionCategoryAdapter extends TypeAdapter<TransactionCategory> {
  @override
  final int typeId = 3;

  @override
  TransactionCategory read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TransactionCategory.other;
      case 1:
        return TransactionCategory.food;
      case 2:
        return TransactionCategory.shopping;
      case 3:
        return TransactionCategory.bills;
      case 4:
        return TransactionCategory.transport;
      case 5:
        return TransactionCategory.entertainment;
      default:
        return TransactionCategory.other;
    }
  }

  @override
  void write(BinaryWriter writer, TransactionCategory obj) {
    switch (obj) {
      case TransactionCategory.other:
        writer.writeByte(0);
        break;
      case TransactionCategory.food:
        writer.writeByte(1);
        break;
      case TransactionCategory.shopping:
        writer.writeByte(2);
        break;
      case TransactionCategory.bills:
        writer.writeByte(3);
        break;
      case TransactionCategory.transport:
        writer.writeByte(4);
        break;
      case TransactionCategory.entertainment:
        writer.writeByte(5);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
