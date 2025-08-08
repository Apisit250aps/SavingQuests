import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:save_quests/controllers/transaction_form_controller.dart';
import 'package:save_quests/models/enum/transaction_category/transaction_category.dart';
import 'package:save_quests/models/enum/transaction_type/transaction_type.dart';
import 'package:save_quests/models/transaction/transaction.dart';

class TransactionForm extends StatelessWidget {
  final Transaction? transaction;

  const TransactionForm({super.key, this.transaction});

  @override
  Widget build(BuildContext context) {
    final TransactionFormController controller = Get.put(
      TransactionFormController(initialTransaction: transaction),
    );

    return Container(
      height: Get.height * 0.75,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Bottom Sheet Handle
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(top: 12, bottom: 8),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header with Close Button and Delete Button
          Container(
            padding: const EdgeInsets.fromLTRB(20, 8, 8, 16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    controller.isEditMode
                        ? 'Edit Transaction'
                        : 'Add Transaction',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
                if (controller.isEditMode)
                  IconButton(
                    onPressed: controller.deleteTransaction,
                    icon: Icon(Icons.delete, color: Colors.pink[500]),
                    padding: const EdgeInsets.all(8),
                  ),
                IconButton(
                  onPressed: () {
                    Get.delete<TransactionFormController>();
                    Get.back();
                  },
                  icon: Icon(Icons.close, color: Colors.pink[200]),
                  padding: const EdgeInsets.all(8),
                ),
              ],
            ),
          ),

          // Scrollable Form Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Subtitle
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: Text(
                        controller.isEditMode
                            ? 'Edit your transaction details'
                            : 'Add a new income or expense transaction',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),

                    // Form Fields
                    TextFormField(
                      controller: controller.nameController,
                      decoration: _buildInputDecoration(
                        'Transaction Name',
                        icon: Icons.receipt_long,
                      ),
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                      validator:
                          (value) =>
                              value == null || value.isEmpty
                                  ? 'Please enter a name'
                                  : null,
                    ),
                    const SizedBox(height: 16),

                    TextFormField(
                      controller: controller.descController,
                      decoration: _buildInputDecoration(
                        'Description (Optional)',
                        icon: Icons.notes,
                      ),
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 2,
                      minLines: 1,
                    ),
                    const SizedBox(height: 16),

                    TextFormField(
                      controller: controller.amountController,
                      decoration: _buildInputDecoration(
                        'Amount',
                        icon: Icons.attach_money,
                      ),
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                      ),
                      keyboardType: TextInputType.number,
                      validator:
                          (value) =>
                              value == null || double.tryParse(value) == null
                                  ? 'Please enter a valid amount'
                                  : null,
                    ),
                    const SizedBox(height: 16),

                    Column(
                      spacing: 16,
                      children: [
                        Obx(
                          () => DropdownButtonFormField<TransactionType>(
                            value: controller.selectedType.value,
                            items:
                                TransactionType.values
                                    .map(
                                      (type) => DropdownMenuItem(
                                        value: type,
                                        child: Row(
                                          children: [
                                            Icon(
                                              type == TransactionType.expense
                                                  ? Icons.remove_circle_outline
                                                  : Icons.add_circle_outline,
                                              color:
                                                  type ==
                                                          TransactionType
                                                              .expense
                                                      ? Colors.red[400]
                                                      : Colors.green[400],
                                              size: 20,
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              type.name,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                    .toList(),
                            onChanged: controller.updateType,
                            decoration: _buildInputDecoration('Type'),
                            dropdownColor: Colors.white,
                            style: const TextStyle(color: Colors.black87),
                          ),
                        ),
                        Obx(
                          () => DropdownButtonFormField<TransactionCategory>(
                            value: controller.selectedCategory.value,
                            items:
                                TransactionCategory.values
                                    .map(
                                      (category) => DropdownMenuItem(
                                        value: category,
                                        child: Text(
                                          category.name,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                            onChanged: controller.updateCategory,
                            decoration: _buildInputDecoration('Category'),
                            dropdownColor: Colors.white,
                            style: const TextStyle(color: Colors.black87),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Date and Time Row
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () => controller.pickDate(context),
                            borderRadius: BorderRadius.circular(12),
                            child: Obx(
                              () => InputDecorator(
                                decoration: _buildInputDecoration(
                                  'Date',
                                  icon: Icons.calendar_today,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        DateFormat.MMMd().format(
                                          controller.selectedDate.value,
                                        ),
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const Icon(
                                      Icons.keyboard_arrow_down,
                                      color: Colors.black54,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: InkWell(
                            onTap: () => controller.pickTime(context),
                            borderRadius: BorderRadius.circular(12),
                            child: Obx(
                              () => InputDecorator(
                                decoration: _buildInputDecoration(
                                  'Time',
                                  icon: Icons.access_time,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        _formatTime(
                                          controller.selectedTime.value,
                                        ),
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const Icon(
                                      Icons.keyboard_arrow_down,
                                      color: Colors.black54,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    // Submit Button
                    Container(
                      height: 52,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: controller.submitForm,
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(width: 8),
                            Text(
                              controller.isEditMode
                                  ? 'Update Transaction'
                                  : 'Save Transaction',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Bottom padding for safe area
                    SizedBox(
                      height: MediaQuery.of(context).padding.bottom + 16,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat.jm().format(dt);
  }

  InputDecoration _buildInputDecoration(String label, {IconData? icon}) {
    return InputDecoration(
      labelText: label,
      prefixIcon:
          icon != null ? Icon(icon, color: Colors.pink.shade200, size: 20) : null,
    );
  }
}
