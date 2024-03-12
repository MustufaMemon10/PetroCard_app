import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:petrocardapppp/utilities/colors.dart';

class ManageRequestsScreen extends StatefulWidget {
  @override
  _ManageRequestsScreenState createState() => _ManageRequestsScreenState();
}

class _ManageRequestsScreenState extends State<ManageRequestsScreen> {
  List<Map<String, dynamic>> requestData = [];

  Future<void> fetchUserData() async {
    try {
      final response = await http.get(Uri.parse(
          'https://petrocard.000webhostapp.com/API/Admin/users_details.php'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        if (responseData['error'] == false) {
          final List<dynamic> RequestsData = responseData['users'];
          setState(() {
            requestData = RequestsData.cast<Map<String, dynamic>>();
          });
        } else {
          print('Error fetching user data: ${responseData['message']}');
        }
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
          child: ListView.builder(
              itemCount: requestData.length,
              itemBuilder: (context, index) {
                final request = requestData[index];
                return SingleChildScrollView(
                  child: Container(
                    height: 200.0,
                    width: 1.sw,
                    margin: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: AppColors.grey.withOpacity(0.4),
                    ),
                  ),
                );
              }
          ),
        )
    );
  }
}
