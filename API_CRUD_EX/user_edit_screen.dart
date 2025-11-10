import 'package:flutter/material.dart';
import 'user_api_service.dart';

class UserEditScreen extends StatefulWidget {
  final Map<String, dynamic> user;
  UserEditScreen({required this.user});

  @override
  State<UserEditScreen> createState() => _UserEditScreenState();
}

class _UserEditScreenState extends State<UserEditScreen> {
  final apiService = UserApiService();
  late TextEditingController usernameController;
  late TextEditingController emailController;
