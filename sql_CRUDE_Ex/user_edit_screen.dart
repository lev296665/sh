import 'package:flutter/material.dart';
import 'database_helper.dart';

class UserEditScreen extends StatefulWidget {
  final Map<String, dynamic> user;

  UserEditScreen({required this.user});

  @override
  State<UserEditScreen> createState() => _UserEditScreenState();
}

class _UserEditScreenState extends State<UserEditScreen> {
  final dbHelper = DatabaseHelper();
  late TextEditingController usernameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController(text: widget.user["username"]);
    emailController = TextEditingController(text: widget.user["email"]);
    passwordController = TextEditingController(text: widget.user["password"]);
  }

  Future<void> updateUser() async {
    await dbHelper.updateUser(widget.user["id"], {
      "username": usernameController.text,
      "email": emailController.text,
      "password": passwordController.text,
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit User")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: usernameController, decoration: InputDecoration(labelText: "Username")),
            TextField(controller: emailController, decoration: InputDecoration(labelText: "Email")),
            TextField(controller: passwordController, decoration: InputDecoration(labelText: "Password")),
            SizedBox(height: 20),
            ElevatedButton(onPressed: updateUser, child: Text("Update")),
          ],
        ),
      ),
    );
  }
}
