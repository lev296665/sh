import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'user_list_screen.dart';

class UserFormScreen extends StatefulWidget {
  @override
  State<UserFormScreen> createState() => _UserFormScreenState();
}

class _UserFormScreenState extends State<UserFormScreen> {
  final DatabaseHelper dbHelper = DatabaseHelper();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> saveUser() async {
    if (usernameController.text.isNotEmpty && emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      await dbHelper.insertUser({
        "username": usernameController.text,
        "email": emailController.text,
        "password": passwordController.text,
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("User Saved!")));
      usernameController.clear();
      emailController.clear();
      passwordController.clear();
    }
  }

  void viewUsers() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => UserListScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SQLite User Form")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: usernameController, decoration: InputDecoration(labelText: "Username")),
            TextField(controller: emailController, decoration: InputDecoration(labelText: "Email")),
            TextField(controller: passwordController, decoration: InputDecoration(labelText: "Password"), obscureText: true),
            SizedBox(height: 20),
            ElevatedButton(onPressed: saveUser, child: Text("Save")),
            ElevatedButton(onPressed: viewUsers, child: Text("View Users")),
          ],
        ),
      ),
    );
  }
}
