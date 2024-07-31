import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/theme_provider.dart';
import 'screens/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      builder: (context, child) {
        final provider = Provider.of<ThemeProvider>(context);
       return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode:provider.themeState,
          darkTheme: ThemeData(brightness: Brightness.dark),
          home: MainScreen(),
        );
      },
    );
  }
}
