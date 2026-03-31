import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid(); //making the uuid class

final formatter = DateFormat.yMd(); //formatting the date to look better

enum Category {food, travel, leisure, work} //its own category variable
const categoryIcons={ //map of category to icon
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work
};
class Expense{
  Expense({required this.title, required this.amount, 
  required this.date, required this.category}) : id = uuid.v4(); //random id generator

  final String id;  //this is all the data for an expense
  final String title;
  final double amount;
  final DateTime date;
  final Category category; //string is too flexibile --> limited this to 4 cats using an enum --> leisure, travel, food, work --> then switched it to Category category

  String get formattedDate{
    return formatter.format(date); //this is the getter for the formatted date
  } //call this method and return this version of the date
}