import 'package:flutter/material.dart';
import 'student_data.dart';
import 'register_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        title: const Text("Student Dashboard"),
        backgroundColor: Colors.amber,
        foregroundColor: Colors.black,
      ),

      body: students.isEmpty
          ? const Center(
        child: Text(
          "No students registered",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      )

          : ListView.builder(
        itemCount: students.length,

        itemBuilder: (context, index) {

          final student = students[index];

          return Card(
            color: Colors.grey[900],
            margin: const EdgeInsets.all(10),

            child: ListTile(
              leading: const Icon(
                Icons.person,
                color: Colors.amber,
              ),

              title: Text(
                student.name,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),

              subtitle: Text(
                "${student.email}\n${student.course}",
                style: const TextStyle(
                  color: Colors.white70,
                ),
              ),
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        foregroundColor: Colors.black,

        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const RegisterPage(),
            ),
          );

          setState(() {});
        },

        child: const Icon(Icons.add),
      ),
    );
  }
}