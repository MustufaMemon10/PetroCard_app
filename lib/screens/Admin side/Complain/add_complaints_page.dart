import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:petrocardapppp/utilities/colors.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AddComplaintsPage extends StatefulWidget {
  const AddComplaintsPage({Key? key}) : super(key: key);

  @override
  State<AddComplaintsPage> createState() => _AddComplaintsPageState();
}

class _AddComplaintsPageState extends State<AddComplaintsPage> {
  TextEditingController areaNameController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  final formKey = new GlobalKey<FormState>();
  var logindata;
  var data;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.darkPurple ,
        title: Text('Add Complaints'),
        titleTextStyle: TextStyle(color: Colors.white,fontSize: 20),
        shadowColor: Colors.white,
        elevation: 10,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              color: Colors.white.withAlpha(20),
            ),
            child: Icon(Icons.arrow_back_ios_new, color:Colors.white, size: 20),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        actions: <Widget>[
          SizedBox(width: 20,),
        ],
      ),
      body: isLoading ? Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor)) : SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20,),
              Padding(padding: EdgeInsets.all(16),
                child:  Text(
                  "What's your Complaints",
                  style:
                  TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),),
              Container(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                child: TextFormField(
                  style: TextStyle(color: Color(0xFF08364B)),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Please enter message";
                    }
                    return null;
                  },
                  controller: messageController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Message',
                    labelStyle:TextStyle(color: Color(0xFF08364B)),
                    helperStyle: TextStyle(color: Color(0xFF08364B)),
                    hintStyle: TextStyle(color: Color(0xFF08364B)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      borderSide: BorderSide(
                        color: Color(0xFF08364B),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      borderSide: BorderSide(
                        color: Color(0xFF08364B),
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height:30 ,),
              Container(
                  height: 55,
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 16,right: 16),
                  margin: EdgeInsets.all(10),
                  child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
                      ),
                      child: const Text('Send Complaint',
                        style: TextStyle(color: Colors.white),),
                      onPressed: _submit
                  )),
            ],
          ),
        ),
      ) ,
    );
  }

  Future<void> _submit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final form = formKey.currentState;
    if (form!.validate()) {
      setState(() {
        isLoading = true;
      });
      final login_url = Uri.parse(
          "https://petrocard.000webhostapp.com/API/addcomplaint.php");
      final response = await http
          .post(login_url, body: {
        "id": prefs.getString('id'),
        "message": messageController.text,
      });
      if (response.statusCode == 200) {
        logindata = jsonDecode(response.body);
        print(data);
        setState(() {
          isLoading = false;
        });
        if (logindata['error'] == false) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(logindata['message'].toString()),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.green, // Customize background color
            ),
          );
          Navigator.of(context).pop();
        }else{
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(logindata['message'].toString()),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.red, // Customize background color
            ),
          );
        }
      }
    }

  }

}
