import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:practice_riverpod/local_data/local_data.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final Logger _logger = Logger();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();

  List<Map<String, dynamic>> _users = [];

  @override
  void initState() {
    super.initState();
    _refreshUsers();
  }

  // Fetch all users from database
  void _refreshUsers() async {
    final data = await DatabaseHelper().getUsers();
    _logger.i(data);
    setState(() {
      _users = data;
    });
  }

  // Insert new user
  void _addUser() async {
    String name = _nameController.text.trim();
    int age = int.tryParse(_ageController.text.trim()) ?? 0;
    if (name.isNotEmpty) {
      await DatabaseHelper().insertUser(name, age);
      _nameController.clear();
      _ageController.clear();
      _refreshUsers();
    }
  }

  // Update existing user
  void _updateUser(int id) async {
    String name = _nameController.text.trim();
    int age = int.tryParse(_ageController.text.trim()) ?? 0;
    if (name.isNotEmpty) {
      await DatabaseHelper().updateUser(id, name, age);
      _nameController.clear();
      _ageController.clear();
      _refreshUsers();
    }
  }

  // Delete user
  void _deleteUser(int id) async {
    await DatabaseHelper().deleteUser(id);
    _refreshUsers();
  }

  // Show dialog to update user
  void _showUpdateDialog(Map<String, dynamic> user) {
    _nameController.text = user['name'];
    _ageController.text = user['age'].toString();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Update User'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _ageController,
              decoration: InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              _updateUser(user['id']);
              Navigator.pop(context);
            },
            child: Text('Update'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _nameController.clear();
              _ageController.clear();
            },
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sqflite CRUD Demo')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Input fields
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _ageController,
              decoration: InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            ElevatedButton(onPressed: _addUser, child: Text('Add User')),
            SizedBox(height: 20),

            // List of users
            Expanded(
              child: _users.isEmpty
                  ? Center(child: Text('No users added yet'))
                  : ListView.builder(
                      itemCount: _users.length,
                      itemBuilder: (_, index) {
                        final user = _users[index];
                        _logger.i(user);
                        return Card(
                          child: ListTile(
                            title: Text('${user['name']}'),
                            subtitle: Text('Age: ${user['age']}'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () => _showUpdateDialog(user),
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () => _deleteUser(user['id']),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
