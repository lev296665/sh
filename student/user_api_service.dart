// user_api_service.dart
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserApiService {
  final String baseUrl = "https://691021cf45e65ab24ac5b037.mockapi.io/users";

  // Fetch all users
  Future<List<dynamic>> getUsers() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load users: ${response.statusCode}");
    }
  }

  // Add user
  Future<void> addUser(Map<String, dynamic> user) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(user),
    );
    if (response.statusCode != 201 && response.statusCode != 200) {
      throw Exception("Failed to add user: ${response.statusCode}");
    }
  }

  // Update user
  Future<void> updateUser(String id, Map<String, dynamic> user) async {
    final response = await http.put(
      Uri.parse("$baseUrl/$id"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(user),
    );
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception("Failed to update user: ${response.statusCode}");
    }
  }

  // Delete user
  Future<void> deleteUser(String id) async {
    final response = await http.delete(
        Uri.parse("$baseUrl/$id"));
    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception("Failed to delete user: ${response.statusCode}");
    }
  }
}
