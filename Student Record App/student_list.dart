// student_list.dart
import 'package:flutter/material.dart';
import 'student_form.dart';
import 'student_db.dart';

class StudentListScreen extends StatefulWidget {
  @override
  _StudentListScreenState createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  List<Map<String, dynamic>> students = [];

  @override
  void initState() {
    super.initState();
    refreshList();
  }

  Future<void> refreshList() async {
    final data = await StudentDB.instance.getStudents();
    setState(() => students = data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Student Records')),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          final s = students[index];
          return ListTile(
            title: Text(s['name']),
            subtitle: Text('Roll No: ${s['roll']} | Dept: ${s['dept']}'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => StudentFormScreen()),
          );
          refreshList();
        },
      ),
    );
  }
}
