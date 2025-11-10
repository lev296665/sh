// user_list_screen.dart
import 'package:flutter/material.dart';
import 'user_api_service.dart';
import 'user_edit_screen.dart';

class UserListScreen extends StatefulWidget {
  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  final UserApiService apiService = UserApiService();
  late Future<List<dynamic>> usersFuture;

  @override
  void initState() {
    super.initState();
    usersFuture = apiService.getUsers();
  }

  void refreshUsers() {
    setState(() {
      usersFuture = apiService.getUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Users from API")),
      body: FutureBuilder<List<dynamic>>(
        future: usersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No users found."));
          }

          List<dynamic> users = snapshot.data!;

          return RefreshIndicator(
            onRefresh: () async => refreshUsers(),
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                var user = users[index];
                return ListTile(
                  title: Text(user["name"] ?? "No name"),
                  subtitle: Text(user["email"] ?? "No email"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UserEditScreen(user: user),
                            ),
                          );
                          refreshUsers();
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () async {
                          await apiService.deleteUser(user["id"]);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("User deleted!")),
                          );
                          refreshUsers();
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
