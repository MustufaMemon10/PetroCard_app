import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiHelper {
  static Future<bool> checkHasCard(String id) async {
    SharedPreferences setpreference = await SharedPreferences.getInstance();
    final apiUrl = 'https://petrocard.000webhostapp.com/API/checkUserhasCard.php';
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {'id': setpreference.getString('id')},
      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['error'] == true) {
          return true;
        } else {
          return false; // User has a card
        }
      } else {
        // Handle API call failure
        return false; // Assuming no card in case of API failure
      }
    } catch (error) {
      print('Error calling API: $error');
      return false;
    }
  }
}
