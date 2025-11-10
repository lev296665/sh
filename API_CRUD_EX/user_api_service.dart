import 'package:http/http.dart' as http;
import 'dart:convert';

class UserApiService {
  final String baseUrl = "https://68e0e27993207c4b4795a83e.mockapi.io/users";

  Future<List<dynamic>> getUsers() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) return jsonDecode(response.body);
    throw Exception("Failed to load users");
  }

  Future<void> addUser(Map<String, dynamic> user) async {
    final response = await http.post(Uri.parse(baseUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(user));
    if (response.statusCode != 201) throw Exception("Failed to add user");
  }

  Future<void> updateUser(String id, Map<String, dynamic> user) async {
    final response = await http.put(Uri.parse("$baseUrl/$id"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(user));
    if (response.statusCode != 200) throw Exception("Failed to update user");
  }

  Future<void> deleteUser(String id) async {
    final response = await http.delete(Uri.parse("$baseUrl/$id"));
    if (response.statusCode != 200) throw Exception("Failed to delete user");
  }
}
