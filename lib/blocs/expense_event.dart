import 'package:last_exam/models/expense.dart';

abstract class ExpenseEvent {}

class AddExpenseEvent extends ExpenseEvent {
  final ExpenseModel expense;
  AddExpenseEvent(this.expense);
}

class FetchExpensesEvent extends ExpenseEvent {}

class DeleteExpenseEvent extends ExpenseEvent {
  final int id;
  DeleteExpenseEvent(this.id);
}

class UpdateExpenseEvent extends ExpenseEvent {
  final ExpenseModel expense;
  UpdateExpenseEvent(this.expense);
}
