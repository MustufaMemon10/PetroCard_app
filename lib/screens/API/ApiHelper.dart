import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiHelper {
  static Future<bool> checkHasCard(String id) async {
    final apiUrl = 'https://petrocard.000webhostapp.com/API/checkUserhasCard.php';
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {'id': id},
      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['error']== true) {
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
  static Future<bool> checkRequested(String id) async {
    final apiUrl = 'https://petrocard.000webhostapp.com/API/checkUserHasRequested.php';
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {'id': id},
      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        SharedPreferences setpreference =
        await SharedPreferences.getInstance();
        setpreference.setString('status',['status'].toString());
        if (!responseData['error']) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (error) {
      print('Error calling API: $error');
      return false;
    }
  }
}

