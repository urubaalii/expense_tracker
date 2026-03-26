import 'package:flutter/material.dart';
import 'package:expense_tracker/models/Expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses =[
  Expense(
    title: "Gino's Pizza",
    amount: 25.00,
    date: DateTime.now(),
    category: Category.food
  ),
  Expense(
    title: "Train Ticket to MA",
    amount: 15.25,
    date: DateTime.now(),
    category: Category.travel
  ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("CHART GOES HERE"),
          SizedBox(height: 30),
          Text("EXPENNSES List GOES HERE"),
        ]
      )
    );
  }
}