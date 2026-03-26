import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Expense{
  Expense({required this.title, required this.amount, required this.date}) : id = uuid.v4();

  final String id;  //this is all the data for an expense
  final String title;
  final double amount;
  final DateTime date;
}