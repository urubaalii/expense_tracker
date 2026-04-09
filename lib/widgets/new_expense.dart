import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/expense.dart';
final formatter = DateFormat.yMd();

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  State<NewExpense> createState(){
    return _NewExpenseState();
  }
}
class _NewExpenseState extends State<NewExpense>{
final _titleController = TextEditingController();
final _amountController = TextEditingController();
DateTime? _selectedDate; //? bc it has no value when we first open the modal, but it will have a value after we pick a date. this is the variable that will store the date that the user picks
Category _selectedCategory = Category.leisure; //this is the variable that will store the category that the user selects. it starts as leisure by default, but it will change when the user selects a different category from the dropdown menu

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
    return Padding(padding: EdgeInsets.all(16),
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

        ElevatedButton(onPressed: (){ //button: when button gets hit, print the price, and the text
        Navigator.pop(context); //pops current screen off stack and goes back to main screen
        }, child: Text("Cancel")),
        
        ElevatedButton(onPressed: (){ //button: when button gets hit, print the price, and the text
          print(_titleController.text);
          print(_amountController.text);
        }, child: Text("Save Expense"))
       ],)
      ]
    )
    );
  }
}