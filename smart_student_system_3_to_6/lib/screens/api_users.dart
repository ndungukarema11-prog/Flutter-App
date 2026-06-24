import 'package:flutter/material.dart';
import '../services/api_service.dart';

class ApiUsersScreen extends StatefulWidget {
  const ApiUsersScreen({super.key});

  @override
  State<ApiUsersScreen> createState() => _ApiUsersScreenState();
}

class _ApiUsersScreenState extends State<ApiUsersScreen> {
  final api = ApiService();
  List users = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadUsers();
  }

  void loadUsers() async {
    try {
      final data = await api.fetchUsers();
      setState(() {
        users = data;
        loading = false;
      });
    } catch (e) {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("API Users"),
        centerTitle: true,
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final u = users[index];

          return ListTile(
            leading: const Icon(Icons.person),
            title: Text(u['name']),
            subtitle: Text(u['email']),
          );
        },
      ),
    );
  }
}