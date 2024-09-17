import 'package:last_exam/models/expense.dart';

abstract class ExpenseState {}

class ExpenseInitial extends ExpenseState {}

class ExpenseLoading extends ExpenseState {}

class ExpenseLoaded extends ExpenseState {
  final List<ExpenseModel> expenses;
  ExpenseLoaded(this.expenses);
}

class ExpenseError extends ExpenseState {
  final String message;
  ExpenseError(this.message);
}
