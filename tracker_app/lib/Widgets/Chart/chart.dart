import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Models/expenses.dart';
import 'chart_bar.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.expenses});

  final List<Expense> expenses;

  List<ExpensesBucket> get buckets {
    return [
      ExpensesBucket.forCategory(expenses, Category.food),
      ExpensesBucket.forCategory(expenses, Category.leisure),
      ExpensesBucket.forCategory(expenses, Category.travel),
      ExpensesBucket.forCategory(expenses, Category.work),
    ];
  }

  double get maxTotalExpense {
    double maxTotalExpense = 0;

    for (final bucket in buckets) {
      if (bucket.totalAmount > maxTotalExpense) {
        maxTotalExpense = bucket.totalAmount;
      }
    }

    return maxTotalExpense;
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      padding: EdgeInsets.symmetric(
        vertical: 16.h,
        horizontal: 8.w,
      ),
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.3),
            Theme.of(context).colorScheme.primary.withOpacity(0.0)
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final bucket in buckets)
                  ChartBar(
                    fill: bucket.totalAmount == 0
                        ? 0
                        : bucket.totalAmount / maxTotalExpense,
                  )
              ],
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              for (final bucket in buckets)
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 4.w,
                    ),
                    child: Icon(
                      categoryIcons[bucket.category],
                      color: isDarkMode
                          ? Theme.of(context).colorScheme.secondary
                          : Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.7),
                    ),
                  ),
                ),
            ],
          )
        ],
      ),
    );
  }
}
