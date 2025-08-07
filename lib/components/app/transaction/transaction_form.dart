import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:save_quests/controllers/wallet_controller.dart';
import 'package:save_quests/models/enum/transaction_category/transaction_category.dart';
import 'package:save_quests/models/enum/transaction_type/transaction_type.dart';
import 'package:save_quests/models/transaction/transaction.dart';

class TransactionForm extends StatefulWidget {
  final Transaction? transaction; // For edit mode

  const TransactionForm({super.key, this.transaction});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  final _amountController = TextEditingController();

  TransactionType _selectedType = TransactionType.expense;
  TransactionCategory _selectedCategory = TransactionCategory.other;
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  final WalletController _controller = Get.find<WalletController>();

  bool get isEditMode => widget.transaction != null;

  @override
  void initState() {
    super.initState();
    // Set default values if in edit mode
    if (isEditMode) {
      final transaction = widget.transaction!;
      _nameController.text = transaction.name;
      _descController.text = transaction.desc;
      _amountController.text = transaction.amount.toString();
      _selectedType = transaction.type;
      _selectedCategory = transaction.category;
      _selectedDate = transaction.createdAt;
      _selectedTime = TimeOfDay.fromDateTime(transaction.createdAt);
    }
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final double amount = double.parse(_amountController.text);
      final DateTime now = DateTime.now();

      // Combine date and time
      final DateTime combinedDateTime = DateTime(
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day,
        _selectedTime.hour,
        _selectedTime.minute,
      );

      final transaction = Transaction(
        walletId: _controller.defaultWallet.key,
        name: _nameController.text,
        desc: _descController.text.isEmpty ? "" : _descController.text,
        amount: amount,
        type: _selectedType,
        category: _selectedCategory,
        createdAt: combinedDateTime,
        updatedAt: now,
      );

      if (isEditMode) {
        _controller.updateTransactionByKey(
          widget.transaction!.key,
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
        _controller.addTransaction(transaction);
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

  void _deleteTransaction() {
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
                _controller.deleteTransactionByKey(widget.transaction!.key!);
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

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
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
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _pickTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
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
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  String _formatTime(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat.jm().format(dt);
  }

  InputDecoration _buildInputDecoration(String label, {IconData? icon}) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(
        color: Colors.black54,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      prefixIcon:
          icon != null ? Icon(icon, color: Colors.black54, size: 20) : null,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.black12, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.black12, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.black87, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red, width: 2),
      ),
      filled: true,
      fillColor: Colors.grey[50],
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                    isEditMode ? 'Edit Transaction' : 'Add Transaction',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
                if (isEditMode)
                  IconButton(
                    onPressed: _deleteTransaction,
                    icon: const Icon(Icons.delete, color: Colors.red),
                    padding: const EdgeInsets.all(8),
                  ),
                IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.close, color: Colors.black54),
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
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Subtitle
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: Text(
                        isEditMode
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
                      controller: _nameController,
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
                      controller: _descController,
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
                      controller: _amountController,
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

                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<TransactionType>(
                            value: _selectedType,
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
                            onChanged: (val) {
                              if (val != null) {
                                setState(() => _selectedType = val);
                              }
                            },
                            decoration: _buildInputDecoration('Type'),
                            dropdownColor: Colors.white,
                            style: const TextStyle(color: Colors.black87),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: DropdownButtonFormField<TransactionCategory>(
                            value: _selectedCategory,
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
                            onChanged: (val) {
                              if (val != null) {
                                setState(() => _selectedCategory = val);
                              }
                            },
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
                          flex: 2,
                          child: InkWell(
                            onTap: () => _pickDate(context),
                            borderRadius: BorderRadius.circular(12),
                            child: InputDecorator(
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
                                      DateFormat.MMMd().format(_selectedDate),
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
                        const SizedBox(width: 12),
                        Expanded(
                          child: InkWell(
                            onTap: () => _pickTime(context),
                            borderRadius: BorderRadius.circular(12),
                            child: InputDecorator(
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
                                      _formatTime(_selectedTime),
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
                        onPressed: _submitForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black87,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              isEditMode ? Icons.edit : Icons.save,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              isEditMode
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

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    _amountController.dispose();
    super.dispose();
  }
}
