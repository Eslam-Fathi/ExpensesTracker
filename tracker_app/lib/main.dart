import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracker_app/Global/Colors/global_color_scheme.dart';
import 'package:tracker_app/Widgets/expenses_tracker.dart';

void main() {
  runApp(
    const ExpensesApp(),
  );
}

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) => MaterialApp(
        //Dark theme
        darkTheme: ThemeData.dark().copyWith(
          useMaterial3: true,
          colorScheme: kColorSchemeDark,
          cardTheme: const CardTheme().copyWith(
            color: kColorSchemeDark.secondaryContainer,
            margin: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 8.h,
            ),
          ),
          datePickerTheme: const DatePickerThemeData().copyWith(
            backgroundColor: kColorSchemeDark.inversePrimary,
            headerBackgroundColor: kColorSchemeDark.onPrimaryContainer,
            headerForegroundColor: kColorSchemeDark.onPrimary,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: kColorSchemeDark.primaryContainer,
              foregroundColor: kColorSchemeDark.onPrimaryContainer,
            ),
          ),
        ),
        // light theme
        theme: ThemeData().copyWith(
          useMaterial3: true,
          colorScheme: kColorScheme,
          cardTheme: const CardTheme().copyWith(
            color: kColorScheme.secondaryContainer,
            margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          ),
          appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: kColorScheme.onPrimaryContainer,
            foregroundColor: kColorScheme.primaryContainer,
          ),
          datePickerTheme: const DatePickerThemeData().copyWith(
            backgroundColor: kColorScheme.inversePrimary,
            headerBackgroundColor: kColorScheme.onPrimaryContainer,
            headerForegroundColor: kColorScheme.onPrimary,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: kColorScheme.primaryContainer,
            ),
          ),
          textTheme: ThemeData().textTheme.copyWith(
                titleLarge: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: kColorScheme.onSecondaryContainer,
                ),
              ),
        ),
        themeMode: ThemeMode.system,
        home: const ExpensesTracker(),
      ),
      designSize: const Size(412, 868),
    );
  }
}
