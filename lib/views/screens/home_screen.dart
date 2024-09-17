import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:last_exam/blocs/expense_bloc.dart';
import 'package:last_exam/blocs/expense_event.dart';
import 'package:last_exam/blocs/expense_state.dart';
import 'package:last_exam/views/screens/add_expense.dart';
import 'package:last_exam/views/screens/daromad_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  List pages = [
    BlocBuilder<ExpenseBloc, ExpenseState>(
      builder: (context, state) {
        if (state is ExpenseLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ExpenseLoaded) {
          final expenses = state.expenses;

          return Container(
            color: Colors.grey[200],
            height: 220,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: expenses.length,
              itemBuilder: (context, index) {
                final expense = expenses[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.blue,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.payment,
                                color: Colors.white,
                              ),
                              Text(
                                expense.title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                "Amount: \$${expense.amount}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                              const Spacer(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.green[100],
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => AddExpenseScreen(
                                            expense: expense,
                                            isEditing: true,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      context
                                          .read<ExpenseBloc>()
                                          .add(DeleteExpenseEvent(expense.id!));
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        } else {
          return const Center(child: Text("Error loading expenses"));
        }
      },
    ),
    const DaromadScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Overview",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: CircleAvatar(
              backgroundColor: Color.fromARGB(255, 34, 0, 255),
              child: Icon(
                CupertinoIcons.person_2_alt,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: pages[_selectedIndex], // Display the selected page
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 52, 82, 172),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(55),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddExpenseScreen()),
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 100,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.monetization_on_sharp),
              label: 'Second',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
