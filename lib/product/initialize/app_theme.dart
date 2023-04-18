import 'package:flutter/material.dart';
import 'package:will_do_full_app/product/constants/color_constants.dart';

@immutable
class AppTheme {
  ThemeData get theme => ThemeData.dark().copyWith(
        scaffoldBackgroundColor: ColorConst.backgrounColor,
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.all(8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsets>(
              const EdgeInsets.all(14),
            ),
            backgroundColor:
                MaterialStateProperty.all<Color>(ColorConst.primaryColor),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            elevation: MaterialStateProperty.all<double>(20),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(ColorConst.grey),
            padding: MaterialStateProperty.all<EdgeInsets>(
              const EdgeInsets.all(18),
            ),
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
      );
}
