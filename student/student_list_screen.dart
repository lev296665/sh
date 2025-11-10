import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'student_detail_screen.dart';

class StudentListScreen extends StatefulWidget {
  const StudentListScreen({super.key});

  @override
  State<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  final DatabaseHelper dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Student List")),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: dbHelper.getStudents(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          final students = snapshot.data ?? [];
          if (students.isEmpty) {
            return const Center(child: Text("No students found."));
          }

          return ListView.builder(
            itemCount: students.length,
            itemBuilder: (context, index) {
              final student = students[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text(student["name"][0].toUpperCase()),
                  ),
                  title: Text(student["name"]),
                  subtitle: Text("Roll No: ${student["rollNumber"]}"),
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            StudentDetailScreen(studentId: student["id"]),
                      ),
                    );
                    setState(() {});
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
