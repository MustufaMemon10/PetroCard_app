import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';



class ApiHelper {
  static Future<void> fetchRequestsLength() async {
    SharedPreferences setpreference = await SharedPreferences.getInstance();
    try {
      final response = await http.get(Uri.parse(
          'https://petrocard.000webhostapp.com/API/fetchallrequests.php'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        if (responseData['error'] == false) {
          setpreference.setInt('requestLength', responseData['requests'].length);
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
  static Future<void> fetchUsersLength() async {
    SharedPreferences setpreference = await SharedPreferences.getInstance();
    try {
      final response = await http.get(Uri.parse(
          'https://petrocard.000webhostapp.com/API/users_details.php'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        if (responseData['error'] == false) {
          setpreference.setInt('usersLength', responseData['users'].length);
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


  static Future<void> fetchComplainLength() async {
    SharedPreferences setpreference = await SharedPreferences.getInstance();
    try {
      final response = await http.get(Uri.parse(
          'https://petrocard.000webhostapp.com/API/fetchallcomplaint.php'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        if (responseData['error'] == false) {
          setpreference.setInt('complaintLength', responseData['complaints'].length);
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


static Future<void> fetchFeedbackLength() async {
    SharedPreferences setpreference = await SharedPreferences.getInstance();
    try {
      final response = await http.get(Uri.parse(
          'https://petrocard.000webhostapp.com/API/fetchallfeedback.php'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        if (responseData['error'] == false) {
          setpreference.setInt('feedLength', responseData['feedbacks'].length);
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
}
