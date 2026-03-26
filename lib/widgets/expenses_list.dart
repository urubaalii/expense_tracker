import 'package:expense_tracker/models/Expense.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key, required this.expenses});

final List<Expense> expenses;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount:expenses.length, //listview builder letting us scroll through list
      itemBuilder: (ctx, index) => Text(expenses[index].title) //ctx=context-what is on screen rn, index=index of the list
      );
}
}