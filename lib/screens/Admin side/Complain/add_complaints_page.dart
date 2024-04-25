import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
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
        backgroundColor: AppColors.white ,
        title: Text('Add Complaints',style: TextStyle(color: AppColors.darkPurple,fontSize: 20,fontWeight: FontWeight.w600),),
        titleTextStyle: TextStyle(color: Colors.black,fontSize: 20),
        centerTitle: true,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              color: Colors.black.withAlpha(20),
            ),
            child: Icon(Icons.arrow_back_ios_new, color:Colors.black, size: 20),
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
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20,),
                  FadeInDown(
                    duration: Duration(milliseconds: 550),
                    child: Padding(padding: EdgeInsets.all(16),
                      child:  Text(
                        "What's your Complaint?",
                        style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      ),),
                  ),
                  FadeInDown(
                    duration: Duration(milliseconds: 600),
                    child: Container(
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
                  ),
                  SizedBox(height:20 ),
                  FadeInDown(
                    duration: Duration(milliseconds: 650),
                    child: Container(
                        height: 55,
                        width: double.infinity,
                        padding: EdgeInsets.only(left: 16,right: 16),
                        margin: EdgeInsets.all(10),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: AppColors.darkPurple,
                              side: BorderSide.none,
                              shape: StadiumBorder(),
                            ),
                            child: const Text('Send Complaint',
                              style: TextStyle(color: Colors.white),),
                            onPressed: _submit
                        )),
                  ),
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: isLoading
                ? Container(
                color: AppColors.white.withOpacity(0.5),
                child: Center(
                  child: LoadingAnimationWidget.halfTriangleDot(
                      color: AppColors.darkPurple, size: 50),
                ))
                : SizedBox(),
          ),
        ],
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
