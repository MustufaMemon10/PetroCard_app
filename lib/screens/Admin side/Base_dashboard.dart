import 'package:flutter/material.dart';
import 'package:petrocardapppp/utilities/colors.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text('Admin Panel'),
      ),
      drawer: Drawer(
        backgroundColor: AppColors.primaryPurple,
        child: ListView(
          children: [
            DrawerHeader(
              child: Text('Admin Menu'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Manage Users'),
              onTap: () {
                Navigator.pop(context);
                // Navigate to the manage users screen
                Navigator.push(context, MaterialPageRoute(builder: (context) => ManageUsersScreen()));
              },
            ),
            ListTile(
              title: Text('Manage Card Requests'),
              onTap: () {
                Navigator.pop(context);
                // Navigate to the manage card requests screen
                Navigator.push(context, MaterialPageRoute(builder: (context) => ManageCardRequestsScreen()));
              },
            ),
            ListTile(
              title: Text('Manage Card List'),
              onTap: () {
                Navigator.pop(context);
                // Navigate to the manage card list screen
                Navigator.push(context, MaterialPageRoute(builder: (context) => ManageCardListScreen()));
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text('Welcome to Admin Panel'),
      ),
    );
  }
}
class ManageUsersScreen extends StatefulWidget {
  const ManageUsersScreen({super.key});

  @override
  State<ManageUsersScreen> createState() => _ManageUsersScreenState();
}

class _ManageUsersScreenState extends State<ManageUsersScreen> {
  var data;
  var logindata;
  bool isLoading = false;
  Future<List<dynamic>> fetchUsers() async {
    final loginUrl = Uri.parse("https://petrocard.000webhostapp.com/API/users_details.php");
    final response = await http.get(loginUrl);
    if (response.statusCode == 200) {
      final logindata = jsonDecode(response.body);
      if (!logindata['error']) {
        final data = logindata['data'];
        SharedPreferences setpreference = await SharedPreferences.getInstance();
        setpreference.setString('id', data['id'].toString());
        setpreference.setString('name', data['name'].toString());
        setpreference.setString('phone', data['phone'].toString());
        setpreference.setString('email', data['email'].toString());
        setpreference.setString('timestamp', data['timestamp'].toString());
        return [data];
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(logindata['message'].toString()),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.red,
          ),
        );
        // Return an empty list
        return [];
      }
    } else {
      throw Exception('Failed to load users');
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Manage Users'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: fetchUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<dynamic> users = snapshot.data!;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                var user = users[index];
                return ListTile(
                  title: Text(user['name']),
                  subtitle: Text(user['email']),
                  // Add more fields as needed
                );
              },
            );
          }
        },
      )

    );
  }
}


class ManageCardRequestsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Card Requests'),
      ),
      body: Center(
        child: Text('Manage Card Requests Screen'),
      ),
    );
  }
}

class ManageCardListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Card List'),
      ),
      body: Center(
        child: Text('Manage Card List Screen'),
      ),
    );
  }
}