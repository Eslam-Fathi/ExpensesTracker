import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final dateFormatter = DateFormat.yMd();

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.leisure: Icons.movie,
  Category.travel: Icons.flight_takeoff,
  Category.work: Icons.work,
};

const uuid = Uuid();

enum Category { food, work, leisure, travel }

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();
  final String id;
  final String title;
  final DateTime date;
  final double amount;
  final Category category;

  String get formattedDate {
    return dateFormatter.format(date);
  }
}

class ExpensesBucket {
  ExpensesBucket({required this.category, required this.expenses});
  final Category category;
  final List<Expense> expenses;

  ExpensesBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  double get totalAmount {
    double sum = 0;

    for (var expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
