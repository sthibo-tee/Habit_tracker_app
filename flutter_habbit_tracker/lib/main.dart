import 'package:flutter/material.dart';
import 'database.dart';
import 'add_habit_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Databasehelper.initDatabase();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AddHabitScreen(),
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
    );
  }
}
