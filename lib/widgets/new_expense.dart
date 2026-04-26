import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/expense.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io'; //this is for the platform check to show different dialogs for ios and android

final formatter = DateFormat.yMd();

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});
  final void Function(Expense expense) onAddExpense; 

  State<NewExpense> createState(){
    return _NewExpenseState();
  } //cards, dismissable, modal, validation, saving data with controllers, asynchronous in new_expense with datapicker..., "dispose"
}
class _NewExpenseState extends State<NewExpense>{
final _titleController = TextEditingController();
final _amountController = TextEditingController();
DateTime? _selectedDate; //? bc it has no value when we first open the modal, but it will have a value after we pick a date. this is the variable that will store the date that the user picks
Category _selectedCategory = Category.leisure; //this is the variable that will store the category that the user selects. it starts as leisure by default, but it will change when the user selects a different category from the dropdown menu

void _submitExpenseData(){
final enteredAmount = double.tryParse(_amountController.text);
final amountIsInvalid  = enteredAmount == null || enteredAmount <= 0; //this checks if the amount is a valid number and if it is greater than 0
if(_titleController.text.trim().isEmpty || amountIsInvalid || _selectedDate == null) { //this checks if the title is empty, if the amount is invalid, or if the date is not selected
showCupertinoDialog(
context: context, 
builder: (ctx)=>CupertinoAlertDialog(
  title: const Text("Invalid Input!"),
  content: const Text("Please make sure to have a valid title, amount, and date."),
  actions: [
    TextButton(
      onPressed: (){
        Navigator.pop(ctx);
      },
      child: Text("Okay")
    ),
  ]
));
return;
}
widget.onAddExpense(Expense(
  title: _titleController.text,
  amount: enteredAmount,
  date: _selectedDate!,
  category: _selectedCategory,
));
//save the data
Navigator.pop(context); //this is what closes the modal after we save the data. it pops the current screen off the stack and goes back to the main screen
}

void _presentDatePicker() async { //this is the function that will show the date picker when the calendar button is pressed. it wont end until the user is done interacting w it.
final now = DateTime.now();
final firstDate = DateTime(now.year - 1, now.month, now.day); //this is the first date that can be selected (1 year ago) (ranges)
  final pickedDate = await showDatePicker( //user will pick a date and then it will be saved in this variable
  context: context,
  initialDate: now,
  firstDate: firstDate,
  lastDate: now
  );
  print(pickedDate); //this is the date that the user picked
  setState(() { //update screen 
  _selectedDate = pickedDate; //this is where we save the date that the user picked 
});}

@override
void dispose(){
  _titleController.dispose(); //lifecycle method. what do i do when widget leaves screen
  _amountController.dispose(); //when you close the modal, dispose makes it so it isnt saving in memory and its not running in the background
  super.dispose();
}

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.fromLTRB(16, 48, 16, 16),
    child: Column(
      children:[
       TextField( //this is in the modal.. this is where we will enter the title of the expense
        controller: _titleController, //this = where is this data going to be saved
        maxLength: 50,
        keyboardType: TextInputType.name,
        decoration :InputDecoration(
          label: Text('Title'),
        ),
       ),
        //make the amount field here for homework, use text field
        Row(
          children: [
            Expanded(
              child: TextField(
                controller:_amountController, //made separate controller
                maxLength: 6,
                keyboardType: TextInputType.number, //this makes the keyboard only show numbers
                decoration: InputDecoration(
                  prefixText: '\$', //this is the $ sign before the number
                  label: Text("Amount"),
                ),
              ),
            ),
            SizedBox(width:16),
            Expanded(child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center, 
              children: [
               Text(
                _selectedDate == null ?
                'Select Date' :
                formatter.format(_selectedDate!), //this is the date that the user picked, but formatted to look better. ! bc we know it has a value at this point
              ),
              IconButton(onPressed: _presentDatePicker, icon: const Icon(Icons.calendar_month)) //this is where the button leads to
            ],),)
          ],
        ),
        SizedBox(height:10),
       Row(children: [
        DropdownButton(
          value: _selectedCategory,
          items: Category.values.map( //this is how we get all the values of the enum and turn them into dropdown menu items
            (category) => DropdownMenuItem(
              value: category, //this is the value that will be saved when the user selects this option
              child: Text(category.name.toUpperCase(),),
            ),
          ).toList(),
          onChanged: (value){
            if(value == null){ //if value is null return, otherwise set state to selected category
              return;
            }
            setState((){
              _selectedCategory = value; //this is where we save the category that the user selected
            });
          },
        ),
        Spacer(), //this is the space between the dropdown menu and the buttons
        ElevatedButton(onPressed: (){ //button: when button gets hit, print the price, and the text
        Navigator.pop(context); //pops current screen off stack and goes back to main screen
        }, child: Text("Cancel")),
        
        ElevatedButton(
          onPressed: _submitExpenseData,
    
       child: Text("Save Expense"),
       ),
       ],)
      ]
    )
    );
  }
}