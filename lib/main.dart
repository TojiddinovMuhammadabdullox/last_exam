import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:last_exam/views/screens/home_screen.dart';
import 'repository/expense_repository.dart';
import 'blocs/expense_bloc.dart';
import 'blocs/expense_event.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ExpenseBloc(ExpenseRepository())..add(FetchExpensesEvent()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Expense Tracker',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const HomeScreen(),
      ),
    );
  }
}
