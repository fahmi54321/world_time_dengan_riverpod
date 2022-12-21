import 'package:flutter/material.dart';
import 'package:world_time_dengan_riverpod/presentation/pages/clock_pages.dart';
import 'package:world_time_dengan_riverpod/res/constants.dart';
import 'package:world_time_dengan_riverpod/res/routes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.darkBg,
        primarySwatch: Colors.pink,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        cardTheme: CardTheme(
          elevation: 0,
          color: AppColors.darkClockBg,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
      home: ClockPage(),
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}
