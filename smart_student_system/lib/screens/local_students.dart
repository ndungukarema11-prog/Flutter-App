import 'package:flutter/material.dart';
import '../db/database_helper.dart';

class LocalStudentsScreen extends StatefulWidget {
  const LocalStudentsScreen({super.key});

  @override
  State<LocalStudentsScreen> createState() => _LocalStudentsScreenState();
}

class _LocalStudentsScreenState extends State<LocalStudentsScreen> {
  final db = DatabaseHelper();
  List students = [];

  @override
  void initState() {
    super.initState();
    loadStudents();
  }

  void loadStudents() async {
    final data = await db.getStudents();
    setState(() {
      students = data;
    });
  }

  void deleteStudent(int id) async {
    await db.deleteStudent(id);
    loadStudents();
  }

  void editStudent(int id, String name, String course) {
    final nameController = TextEditingController(text: name);
    final courseController = TextEditingController(text: course);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Update Student"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nameController),
              TextField(controller: courseController),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                await db.updateStudent(id, {
                  "name": nameController.text,
                  "course": courseController.text,
                });

                Navigator.pop(context);
                loadStudents();
              },
              child: const Text("Update"),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Local Students"),
        centerTitle: true,
      ),
      body: students.isEmpty
          ? const Center(child: Text("No students found"))
          : ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          final s = students[index];

          return Card(
            child: ListTile(
              title: Text(s['name']),
              subtitle: Text(s['course']),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => editStudent(
                      s['id'],
                      s['name'],
                      s['course'],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => deleteStudent(s['id']),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}