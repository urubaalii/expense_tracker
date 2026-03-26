import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum Category {food, travel, leisure, work} //its own category variable

class Expense{
  Expense({required this.title, required this.amount, 
  required this.date, required this.category}) : id = uuid.v4(); //random id generator

  final String id;  //this is all the data for an expense
  final String title;
  final double amount;
  final DateTime date;
  final Category category; //string is too flexibile --> limit this to 4 cats using an enum --> leisure, travel, food, work --> then switched it to Category category
}