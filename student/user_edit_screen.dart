// user_edit_screen.dart
import 'package:flutter/material.dart';
import 'user_api_service.dart';

class UserEditScreen extends StatefulWidget {
  final Map<String, dynamic> user;
  const UserEditScreen({required this.user, super.key});

  @override
  State<UserEditScreen> createState() => _UserEditScreenState();
}

class _UserEditScreenState extends State<UserEditScreen> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  final UserApiService apiService = UserApiService();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.user["name"]);
    emailController = TextEditingController(text: widget.user["email"]);
    passwordController = TextEditingController(text: widget.user["password"]);
  }

  Future<void> updateUser() async {
    await apiService.updateUser(widget.user["id"], {
      "name": nameController.text,
      "email": emailController.text,
      "password": passwordController.text,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("User updated successfully!")),
    );
    Navigator.pop(context); // go back to list page
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit User")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: nameController, decoration: InputDecoration(labelText: "Name")),
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
