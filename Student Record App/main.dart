// main.dart
import 'package:flutter/material.dart';
import 'student_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Record App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: StudentListScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
