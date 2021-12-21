import 'package:flutter/material.dart';
import 'app_colors.dart';

final ThemeData themeData = ThemeData(
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: AppColors.page,
  indicatorColor: AppColors.active,
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  textTheme: TextTheme(
    bodyText2: TextStyle(
      color: AppColors.unactive,
    )
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.nav,
    elevation: 0,
  ),
  tabBarTheme: TabBarTheme(
    unselectedLabelColor: AppColors.unactive,
    indicatorSize: TabBarIndicatorSize.label,
    labelStyle: TextStyle(
      fontSize: 18,
    ),
    labelPadding: EdgeInsets.symmetric(horizontal: 12),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: AppColors.nav,
    selectedItemColor: AppColors.active,
    unselectedItemColor: AppColors.unactive,
    selectedLabelStyle: TextStyle(
      fontSize: 15,
    ),
  ),
);