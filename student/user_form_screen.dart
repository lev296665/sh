import 'package:flutter/material.dart';
import 'user_api_service.dart';
import 'user_list_screen.dart';

class UserFormScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => UserFormScreenState();
}

class UserFormScreenState extends State<UserFormScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final UserApiService apiService = UserApiService();

  Future<void> saveUser() async {
    String username = usernameController.text;
    String email = emailController.text;
    String password = passwordController.text;

    if (username.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
      await apiService.addUser({
        "name": username,
        "email": email,
        "password": password,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("User added to server!")),
      );

      usernameController.clear();
      emailController.clear();
      passwordController.clear();
    }
  }

  void loadUsers() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UserListScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add User (API)")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: "Username"),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: "Password"),
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: saveUser, child: Text("Save")),
            ElevatedButton(onPressed: loadUsers, child: Text("View Users")),
          ],
        ),
      ),
    );
  }
}
