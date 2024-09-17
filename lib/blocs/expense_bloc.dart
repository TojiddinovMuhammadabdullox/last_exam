// blocs/expense_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/expense_repository.dart';
import 'expense_event.dart';
import 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final ExpenseRepository _repository;

  ExpenseBloc(this._repository) : super(ExpenseInitial()) {
    on<AddExpenseEvent>(_onAddExpense);
    on<FetchExpensesEvent>(_onFetchExpenses);
    on<DeleteExpenseEvent>(_onDeleteExpense);
    on<UpdateExpenseEvent>(_onUpdateExpense);
  }

  Future<void> _onAddExpense(
      AddExpenseEvent event, Emitter<ExpenseState> emit) async {
    try {
      emit(ExpenseLoading());
      await _repository.addExpense(event.expense);
      add(FetchExpensesEvent());
    } catch (e) {
      emit(ExpenseError("Failed to add expense"));
    }
  }

  Future<void> _onFetchExpenses(
      FetchExpensesEvent event, Emitter<ExpenseState> emit) async {
    try {
      emit(ExpenseLoading());
      final expenses = await _repository.fetchExpenses();
      emit(ExpenseLoaded(expenses));
    } catch (e) {
      emit(ExpenseError("Failed to fetch expenses"));
    }
  }

  Future<void> _onDeleteExpense(
      DeleteExpenseEvent event, Emitter<ExpenseState> emit) async {
    try {
      await _repository.deleteExpense(event.id);
      add(FetchExpensesEvent());
    } catch (e) {
      emit(ExpenseError("Failed to delete expense"));
    }
  }

  Future<void> _onUpdateExpense(
      UpdateExpenseEvent event, Emitter<ExpenseState> emit) async {
    try {
      await _repository.updateExpense(event.expense);
      add(FetchExpensesEvent());
    } catch (e) {
      emit(ExpenseError("Failed to update expense"));
    }
  }
}
