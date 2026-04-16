import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  void _openAddExpenseOverlay(){ //this = launching up a widget and passing it into here and then associated w the key press
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(
        onAddExpense:_addExpense));
  }

  void _addExpense(Expense expense){ //this is the function that will be called when the user submits the new expense form. 
    setState(() { //it takes an expense as an argument and adds it to the list of registered expenses. then it calls setState to update the screen with the new expense.
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense){
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState((){
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars(); //clears any existing snack bars before showing a new one
    ScaffoldMessenger.of(context).showSnackBar( //widget showing temporary pop up message
      SnackBar(
        duration: Duration(seconds: 5),
        content: Text("Expense Deleted!"),
        action: SnackBarAction(label: "Undo", //undo puts it back in
        onPressed: () { 
        setState(() {
          _registeredExpenses.insert(expenseIndex, expense);
        });
        }),
        )
    );
  }

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
  Expense(
    title: "Movie Ticket",
    amount: 18.00,
    date: DateTime.now(),
    category: Category.leisure
  ),
  ];
  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(child: Text("No Expense. Click + to add one!"),
    );
    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text ("Expense Tracker"),
        actions:[
          IconButton(icon: const Icon(Icons.add), 
          onPressed:_openAddExpenseOverlay,
          //add more here if needed
          )
        ],
      ),
      body: Column(
        children: [
          Chart(expenses: _registeredExpenses),
          Expanded(
            child: mainContent),
        ]
      )
    );
  }
}