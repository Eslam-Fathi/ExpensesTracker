import 'package:flutter/material.dart';
import 'package:tracker_app/Models/expenses.dart';
import 'package:tracker_app/Widgets/Expenses_List/expenses_item.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expenses, required this.onDismissedItem});

  final List<Expense> expenses;
  final void Function(Expense expense) onDismissedItem;

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) => Dismissible(
        background: Container(
          color: isDarkMode
              ? Theme.of(context).colorScheme.tertiary.withOpacity(0.3)
              : Theme.of(context).colorScheme.errorContainer,
          margin: EdgeInsets.symmetric(
            horizontal: Theme.of(context).cardTheme.margin!.horizontal,
          ),
        ),
        key: ValueKey(expenses[index]),
        onDismissed: (direction) => onDismissedItem(expenses[index]),
        child: ExpenseItem(
          expense: expenses[index],
        ),
      ),
    );
  }
}
