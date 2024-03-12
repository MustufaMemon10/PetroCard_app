import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:petrocardapppp/utilities/colors.dart';

class ManageUserScreen extends StatefulWidget {
  @override
  _ManageUserScreenState createState() => _ManageUserScreenState();
}

class _ManageUserScreenState extends State<ManageUserScreen> {
  List<Map<String, dynamic>> userData = [];

  Future<void> fetchUserData() async {
    try {
      final response = await http.get(Uri.parse(
          'https://petrocard.000webhostapp.com/API/Admin/fetchapi.php'));
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          userData = List<Map<String, dynamic>>.from(
              data.map((item) => item as Map<String, dynamic>));
        });
      } else {
        print('Failed to fetch user data: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching user data: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> _refreshData() async {
    await fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: ListView.separated(
          itemCount: userData.length,
          separatorBuilder: (context, index) =>
              Divider(
                color: Colors.grey,
                thickness: 1.0,
              ),
          itemBuilder: (context, index) {
            final user = userData[index];
            return ListTile(
              title: Text('User Name: ${user['name']}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Email: ${user['email']}'),
                  Text('Phone: ${user['phone']}'),
                  Text('id : ${user['id']}'),
                  // Add more fields as needed
                ],
              ),
              // Add onTap callback if needed
            );
          },
        ),
      ),
    );
  }
}