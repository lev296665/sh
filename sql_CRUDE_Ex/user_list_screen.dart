import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'user_detail_screen.dart';

class UserListScreen extends StatelessWidget {
  final DatabaseHelper dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User List")),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: dbHelper.getUsers(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          final users = snapshot.data!;
          if (users.isEmpty) return Center(child: Text("No Users Found"));
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return ListTile(
                title: Text(user["username"]),
                subtitle: Text(user["email"]),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => UserDetailScreen(userId: user["id"]))),
              );
            },
          );
        },
      ),
    );
  }
}
