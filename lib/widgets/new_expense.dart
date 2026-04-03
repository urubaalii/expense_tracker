import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  State<NewExpense> createState(){
    return _NewExpenseState();
  }
}
class _NewExpenseState extends State<NewExpense>{
final _titleController = TextEditingController();

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
       Row(children: [
        //make the amount field here for homework
       ]),
       Row(children: [
        ElevatedButton(onPressed: (){ //button: when button gets hit, print the price, and the text
          print(_titleController.text);
        }, child: Text("Save Expense")
        )
       ],)
      ]
    )
    );
  }
}