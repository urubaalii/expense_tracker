import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget{  
  const ExpenseItem({super.key, required this.expense});   //this will display the expense
  final Expense expense;
  
@override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20, vertical: 16),
        child: Column(
          children: [
            Text(expense.title), //this is the title textbox. we wrapped in a column and padding refactoring
            const SizedBox(height: 4), //space between title and amount
            Row(children: [ //we need things in this row of the col, so we use a row to put them next to each other
              Text('\$${expense.amount.toStringAsFixed(2)}'), //this is the price amount
              Spacer(), //puts a space between the amount and the date. pushes everything to the other side
              Row(children: [
                Icon(categoryIcons[expense.category]), //icon category mapping from the map we made in the expense.dart file, we use the category of the expense to get the icon from the map
                const SizedBox(width: 8), //space between icon and date
                Text(expense.formattedDate) //this is the date, we use the getter we made in the expense.dart to get the formatted date
              ])
            ],)
          ],
        ),
      )
    );
  }
}