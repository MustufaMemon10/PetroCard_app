import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../screens/MainScreen/BaseScreen.dart';

class UserRegistrationPage extends StatefulWidget {
  @override
  _UserRegistrationPageState createState() => _UserRegistrationPageState();
}

class _UserRegistrationPageState extends State<UserRegistrationPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController idController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController panNumberController = TextEditingController();
  String imagePath = ''; // Pa
  bool _imageSelected = false;
  var logindata;
  var data;
  bool isLoading = false;

  // th of the selected image
  Future<void> _handleApplication() async {
    final form = _formKey.currentState;
    if (form!.validate()) {
      setState(() {
        isLoading = true;
      });

      final login_url = Uri.parse(
          "https://petrocard.000webhostapp.com/API/apply_card.php");

      try {
        final response = await http.post(login_url, body: {
          "doc_img": imagePath,
          "status": statusController.text,
          "address": addressController.text,
          "gender": genderController.text,
          "dob": dobController.text,
          "pan_number": panNumberController.text,
          "id": idController.text,
        });

        if (response != null && response.statusCode == 200) {
          logindata = jsonDecode(response.body);
          data = jsonDecode(response.body)['user'];
          print(logindata);
          setState(() {
            isLoading = false;
          });

          if (logindata['error'] == false) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(logindata['message'].toString()),
                duration: Duration(seconds: 2),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => BaseScreen()),
                  (route) => false,
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(logindata['message'].toString()),
                duration: Duration(seconds: 2),
                backgroundColor: Colors.red,
              ),
            );
          }
        } else {
          // Handle HTTP error responses here
          print('Failed to get response from server.');
        }
      } catch (e) {
        // Handle any exceptions that might occur during the HTTP request
        print('Error occurred during HTTP request: $e');
      }
    }
  }

  // }
    // Future<void> _submitForm() async {
    //   var url = Uri.parse('"https://petrocard.000webhostapp.com/API/apply_card.php"');
    //   var request = http.MultipartRequest('POST', url);
    //   request.fields['id'] = idController.text;
    //   request.fields['status'] = statusController.text;
    //   request.fields['address'] = addressController.text;
    //   request.fields['dob'] = dobController.text;
    //   request.fields['gender'] = genderController.text;
    //   request.fields['pan_number'] = panNumberController.text;
    //   request.files.add(await http.MultipartFile.fromPath('doc_img', imagePath));
    //
    //   var streamedResponse = await request.send();
    //   var response = await http.Response.fromStream(streamedResponse);
    //
    //   if (response.statusCode == 200) {
    //     var jsonResponse = json.decode(response.body);
    //     if (!jsonResponse['error']) {
    //       // Successful registration, handle the response accordingly
    //       print('User registered successfully');
    //     } else {
    //       // Error in registration, handle the error message
    //       print('Error: ${jsonResponse['message']}');
    //     }
    //   } else {
    //     // Server error, handle the error accordingly
    //     print('Server Error: ${response.reasonPhrase}');
    //   }
    // }

    Future<void> _pickPhoto() async {
      final status = await Permission.storage.request();
      if (status == PermissionStatus.granted) {
        final pickedFile = await ImagePicker().pickImage(
          source: ImageSource.gallery,
        );
        if (pickedFile != null) {
          setState(() {
            imagePath = pickedFile.path;
            _imageSelected = true;
            print('panphoto: $imagePath');
          });
        }
      } else if (status == PermissionStatus.denied ||
          status == PermissionStatus.restricted) {
        showDialog(
          context: context,
          builder: (BuildContext context) =>
              AlertDialog(
                title: Text("Permission Required"),
                content: Text(
                    "Please grant access to the storage to upload photos."),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("OK"),
                  ),
                ],
              ),
        );
      } else if (status == PermissionStatus.permanentlyDenied) {
        // Show a dialog indicating that permission is permanently denied
        showDialog(
          context: context,
          builder: (BuildContext context) =>
              AlertDialog(
                title: Text("Permission Denied"),
                content: Text(
                    "Please enable access to the storage in the app settings."),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("OK"),
                  ),
                ],
              ),
        );
      }
    }
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Registration'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: idController,
              decoration: InputDecoration(labelText: 'ID'),
            ),
            TextField(
              controller: statusController,
              decoration: InputDecoration(labelText: 'Status'),
            ),
            TextField(
              controller: addressController,
              decoration: InputDecoration(labelText: 'Address'),
            ),
            TextField(
              controller: dobController,
              decoration: InputDecoration(labelText: 'Date of Birth'),
            ),
            TextField(
              controller: genderController,
              decoration: InputDecoration(labelText: 'Gender'),
            ),
            TextField(
              controller: panNumberController,
              decoration: InputDecoration(labelText: 'PAN Number'),
            ),
            ElevatedButton(
              onPressed: () {
                _pickPhoto();
                // Select image functionality
                // Implement image picker and set imagePath variable
                // Example: https://pub.dev/packages/image_picker
              },
              child: Text('Select Image'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _handleApplication,
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
