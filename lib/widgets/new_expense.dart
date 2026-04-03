import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  State<NewExpense> createState(){
    return _NewExpenseState();
  }
}
class _NewExpenseState extends State<NewExpense>{
final _titleController = TextEditingController();
final _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(16),
    child: Column(
      children:[
       TextField( //this is in the modal.. this is where we will enter the title of the expense
        controller: _titleController, //this = where is this data going to be saved
        maxLength: 50,
        keyboardType: TextInputType.name,
        decoration :InputDecoration(
          label: Text("Title"),
        ),
       ),
        //make the amount field here for homework, use text field
        TextField(
          controller:_amountController, //made separate controller
          maxLength: 6,
          keyboardType: TextInputType.number, //this makes the keyboard only show numbers
          decoration: InputDecoration(
            prefixText: '\$', //this is the $ sign before the number
            label: Text("Amount"),
          ),
        ),
        
       Row(children: [
        ElevatedButton(onPressed: (){ //button: when button gets hit, print the price, and the text
          print(_titleController.text);
          print(_amountController.text);
        }, child: Text("Save Expense")
        )
       ],)
      ]
    )
    );
  }
}