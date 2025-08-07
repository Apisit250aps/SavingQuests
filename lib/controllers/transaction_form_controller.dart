import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:save_quests/controllers/wallet_controller.dart';
import 'package:save_quests/models/enum/transaction_category/transaction_category.dart';
import 'package:save_quests/models/enum/transaction_type/transaction_type.dart';
import 'package:save_quests/models/transaction/transaction.dart';

class TransactionFormController extends GetxController {
  final Transaction? initialTransaction;
  
  TransactionFormController({this.initialTransaction});

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final descController = TextEditingController();
  final amountController = TextEditingController();

  final Rx<TransactionType> selectedType = TransactionType.expense.obs;
  final Rx<TransactionCategory> selectedCategory = TransactionCategory.other.obs;
  final Rx<DateTime> selectedDate = DateTime.now().obs;
  final Rx<TimeOfDay> selectedTime = TimeOfDay.now().obs;

  final WalletController walletController = Get.find<WalletController>();

  bool get isEditMode => initialTransaction != null;

  @override
  void onInit() {
    super.onInit();
    _initializeForm();
  }

  void _initializeForm() {
    if (isEditMode) {
      final transaction = initialTransaction!;
      nameController.text = transaction.name;
      descController.text = transaction.desc;
      amountController.text = transaction.amount.toString();
      selectedType.value = transaction.type;
      selectedCategory.value = transaction.category;
      selectedDate.value = transaction.createdAt;
      selectedTime.value = TimeOfDay.fromDateTime(transaction.createdAt);
    }
  }

  void updateType(TransactionType? type) {
    if (type != null) {
      selectedType.value = type;
    }
  }

  void updateCategory(TransactionCategory? category) {
    if (category != null) {
      selectedCategory.value = category;
    }
  }

  Future<void> pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.black87,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black87,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      selectedDate.value = picked;
    }
  }

  Future<void> pickTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime.value,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.black87,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black87,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      selectedTime.value = picked;
    }
  }

  void submitForm() {
    if (formKey.currentState?.validate() ?? false) {
      final double amount = double.parse(amountController.text);
      final DateTime now = DateTime.now();

      // Combine date and time
      final DateTime combinedDateTime = DateTime(
        selectedDate.value.year,
        selectedDate.value.month,
        selectedDate.value.day,
        selectedTime.value.hour,
        selectedTime.value.minute,
      );

      final transaction = Transaction(
        walletId: walletController.defaultWallet.key,
        name: nameController.text,
        desc: descController.text.isEmpty ? "" : descController.text,
        amount: amount,
        type: selectedType.value,
        category: selectedCategory.value,
        createdAt: combinedDateTime,
        updatedAt: now,
      );

      if (isEditMode) {
        walletController.updateTransactionByKey(
          initialTransaction!.key,
          transaction,
        );
        Get.back();
        Get.snackbar(
          'Success',
          'Transaction updated successfully',
          backgroundColor: Colors.blue.withOpacity(0.1),
          colorText: Colors.blue[700],
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 2),
          margin: const EdgeInsets.all(16),
          borderRadius: 12,
          icon: const Icon(Icons.edit, color: Colors.blue),
        );
      } else {
        walletController.addTransaction(transaction);
        Get.back();
        Get.snackbar(
          'Success',
          'Transaction saved successfully',
          backgroundColor: Colors.green.withOpacity(0.1),
          colorText: Colors.green[700],
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 2),
          margin: const EdgeInsets.all(16),
          borderRadius: 12,
          icon: const Icon(Icons.check_circle, color: Colors.green),
        );
      }
    }
  }

  void deleteTransaction() {
    if (isEditMode) {
      Get.dialog(
        AlertDialog(
          title: const Text('Delete Transaction'),
          content: const Text(
            'Are you sure you want to delete this transaction? This action cannot be undone.',
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                walletController.deleteTransactionByKey(initialTransaction!.key!);
                Get.back(); // Close dialog
                Get.back(); // Close bottom sheet
                Get.snackbar(
                  'Success',
                  'Transaction deleted successfully',
                  backgroundColor: Colors.red.withOpacity(0.1),
                  colorText: Colors.red[700],
                  snackPosition: SnackPosition.TOP,
                  duration: const Duration(seconds: 2),
                  margin: const EdgeInsets.all(16),
                  borderRadius: 12,
                  icon: const Icon(Icons.delete, color: Colors.red),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Delete'),
            ),
          ],
        ),
      );
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    descController.dispose();
    amountController.dispose();
    super.onClose();
  }
}