import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../services/api_service.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  final db = DatabaseHelper();
  final api = ApiService();

  int localCount = 0;
  int apiCount = 0;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    final students = await db.getStudents();
    final users = await api.fetchUsers();

    setState(() {
      localCount = students.length;
      apiCount = users.length;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reports"),
        centerTitle: true,
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              child: ListTile(
                leading: const Icon(Icons.storage),
                title: const Text("Local Students"),
                trailing: Text(
                  "$localCount",
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              child: ListTile(
                leading: const Icon(Icons.cloud),
                title: const Text("API Users"),
                trailing: Text(
                  "$apiCount",
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}