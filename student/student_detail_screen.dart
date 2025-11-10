import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'student_edit_screen.dart';

class StudentDetailScreen extends StatelessWidget {
  final int studentId;
  final DatabaseHelper dbHelper = DatabaseHelper();

  StudentDetailScreen({super.key, required this.studentId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
      future: dbHelper.getStudentById(studentId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (!snapshot.hasData || snapshot.data == null) {
          return const Scaffold(
            body: Center(child: Text("Student not found.")),
          );
        }

        final student = snapshot.data!;
        return Scaffold(
          appBar: AppBar(title: const Text("Student Profile")),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Name: ${student["name"]}", style: const TextStyle(fontSize: 18)),
                Text("Roll Number: ${student["rollNumber"]}", style: const TextStyle(fontSize: 18)),
                Text("Course: ${student["course"]}", style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  icon: const Icon(Icons.edit),
                  label: const Text("Edit"),
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StudentEditScreen(student: student),
                      ),
                    );
                    Navigator.pop(context, true);
                  },
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.delete),
                  label: const Text("Delete"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () async {
                    await dbHelper.deleteStudent(studentId);
                    Navigator.pop(context, true);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
