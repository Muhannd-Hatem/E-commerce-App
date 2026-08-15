import 'package:ecommerce_app/Views/Pages/Widgets/custom_bottom_navbar.dart';
import 'package:ecommerce_app/Views/Pages/utils/app_router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.deepPurple),
      home: const CustomBottomNavBar(),
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
