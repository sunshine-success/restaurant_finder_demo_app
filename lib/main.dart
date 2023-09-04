import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:restaurant_finder_app/resources_manager/string_manager.dart';
import 'package:restaurant_finder_app/resources_manager/theme_manager.dart';
import 'package:restaurant_finder_app/ui/home/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    /// --------------
    /// Here Declaration of ResponsiveSizer to make app responsive
    /// --------------
    return ResponsiveSizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          onGenerateTitle: (context) => StringManager.appName,
          debugShowCheckedModeBanner: false,
          theme: getApplicationTheme(),
          home: const HomeScreen(),
        );
      },
    );
  }
}
