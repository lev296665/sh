// main.dart
import 'package:api_crud/user_form_screen.dart';
import 'package:flutter/material.dart';
import 'user_list_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: UserFormScreen(),
  ));
}
