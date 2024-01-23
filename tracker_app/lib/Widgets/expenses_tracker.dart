import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracker_app/Widgets/Chart/chart.dart';
import 'package:tracker_app/Widgets/Expenses_List/expenses_list.dart';
import 'package:tracker_app/Models/expenses.dart';
import 'package:tracker_app/Widgets/NewExpenseOverlay/new_expense.dart';

class ExpensesTracker extends StatefulWidget {
  const ExpensesTracker({super.key});

  @override
  State<ExpensesTracker> createState() => _ExpensesTrackerState();
}

class _ExpensesTrackerState extends State<ExpensesTracker> {
  final List<Expense> _registeredExpenses = [];

  void _openModalBottomOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      constraints: const BoxConstraints(maxWidth: double.infinity),
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpenseOverlay(onAddExpense: _addExpense),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final indexOfExpense = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
            label: "Undo",
            onPressed: () {
              setState(() {
                _registeredExpenses.insert(indexOfExpense, expense);
              });
            }),
        content: const Text("Expense deleted."),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    final width = MediaQuery.of(context).size.width;
    Widget showingContent = const Center(
      child: Text(
        "Nothig is here.\nTry adding some items!",
        textAlign: TextAlign.center,
      ),
    );
    if (_registeredExpenses.isNotEmpty) {
      showingContent = ExpensesList(
        expenses: _registeredExpenses,
        onDismissedItem: _removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expenses Tracker"),
        actions: [
          IconButton(
            onPressed: _openModalBottomOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: width < 600
          ? Column(
              children: [
                Chart(expenses: _registeredExpenses),
                Expanded(
                  child: showingContent,
                ),
              ],
            )
          : Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
                      child: Chart(expenses: _registeredExpenses),
                    ),
                  ),
                  Expanded(
                    child: showingContent,
                  ),
                ],
              ),
            ),
    );
  }
}
