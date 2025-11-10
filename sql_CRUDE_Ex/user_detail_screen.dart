import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'user_edit_screen.dart';

class UserDetailScreen extends StatelessWidget {
  final int userId;
  final dbHelper = DatabaseHelper();

  UserDetailScreen({required this.userId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
      future: dbHelper.getUserById(userId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Scaffold(body: Center(child: CircularProgressIndicator()));
        final user = snapshot.data!;
        return Scaffold(
          appBar: AppBar(title: Text("User Detail")),
          body: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Username: ${user["username"]}", style: TextStyle(fontSize: 18)),
                Text("Email: ${user["email"]}", style: TextStyle(fontSize: 18)),
                Text("Password: ${user["password"]}", style: TextStyle(fontSize: 18)),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => UserEditScreen(user: user))),
                  child: Text("Edit"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () async {
                    await dbHelper.deleteUser(userId);
                    Navigator.pop(context);
                  },
                  child: Text("Delete"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
