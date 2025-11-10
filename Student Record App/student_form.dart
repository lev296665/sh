// student_form.dart
import 'package:flutter/material.dart';
import 'student_db.dart';

class StudentFormScreen extends StatefulWidget {
  @override
  _StudentFormScreenState createState() => _StudentFormScreenState();
}

class _StudentFormScreenState extends State<StudentFormScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController rollCtrl = TextEditingController();
  TextEditingController deptCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Student')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(children: [
            TextFormField(controller: nameCtrl, decoration: InputDecoration(labelText: 'Name')),
            TextFormField(controller: rollCtrl, decoration: InputDecoration(labelText: 'Roll No')),
            TextFormField(controller: deptCtrl, decoration: InputDecoration(labelText: 'Department')),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  await StudentDB.instance.insertStudent({
                    'name': nameCtrl.text,
                    'roll': rollCtrl.text,
                    'dept': deptCtrl.text,
                  });
                  Navigator.pop(context);
                }
              },
              child: Text('Save'),
            ),
          ]),
        ),
      ),
    );
  }
}
