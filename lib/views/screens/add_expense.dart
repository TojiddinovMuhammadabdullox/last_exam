import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:last_exam/blocs/expense_bloc.dart';
import 'package:last_exam/blocs/expense_event.dart';
import 'package:last_exam/models/expense.dart';

class AddExpenseScreen extends StatelessWidget {
  final ExpenseModel? expense;
  final bool isEditing;

  AddExpenseScreen({super.key, this.expense, this.isEditing = false});

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (isEditing && expense != null) {
      _titleController.text = expense!.title;
      _amountController.text = expense!.amount.toString();
    }

    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? "Edit Expense" : "Add Expense")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                labelText: "Title",
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _amountController,
              decoration: InputDecoration(
                labelText: "Amount",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  onPressed: () {
                    final title = _titleController.text;
                    final amount = double.parse(_amountController.text);

                    if (isEditing) {
                      context.read<ExpenseBloc>().add(
                            UpdateExpenseEvent(
                              ExpenseModel(
                                id: expense!.id,
                                title: title,
                                amount: amount,
                                date: expense!.date,
                              ),
                            ),
                          );
                    } else {
                      context.read<ExpenseBloc>().add(
                            AddExpenseEvent(
                              ExpenseModel(
                                title: title,
                                amount: amount,
                                date: DateTime.now(),
                              ),
                            ),
                          );
                    }
                    Navigator.pop(context);
                  },
                  child: Text(
                    isEditing ? "Update" : "Add",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
