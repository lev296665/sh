import 'package:flutter/material.dart';
import 'user_api_service.dart';
import 'user_edit_screen.dart';

class UserListScreen extends StatelessWidget {
  final apiService = UserApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Users from API")),
      body: FutureBuilder<List<dynamic>>(
        future: apiService.getUsers(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          final users = snapshot.data!;
          if (users.isEmpty) return Center(child: Text("No users found"));
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return ListTile(
                title: Text(user["name"]),
                subtitle: Text(user["email"]),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(icon: Icon(Icons.edit, color: Colors.blue), onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => UserEditScreen(user: user)));
                    }),
                    IconButton(icon: Icon(Icons.delete, color: Colors.red), onPressed: () async {
                      await apiService.deleteUser(user["id"]);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("User deleted!")));
                    }),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
