import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../utilities/colors.dart';
import '../../../utilities/styles.dart';

class AddFeedbackPage extends StatefulWidget {
  const AddFeedbackPage({Key? key}) : super(key: key);

  @override
  State<AddFeedbackPage> createState() => _AddFeedbackPageState();
}

class _AddFeedbackPageState extends State<AddFeedbackPage> {
  TextEditingController areaNameController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  final formKey = new GlobalKey<FormState>();
  var logindata;
  var data;
  bool isLoading = false;
  double rating = 3.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.darkPurple ,
        title: Text('Add Feedback'),
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
            bottom: Radius.circular(30),
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
              Container(
                width: double.infinity,
                height: 0.05.sh,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.0),
                    topLeft: Radius.circular(10.0),
                  ),
                ),
                child: Center(child: Text("Your opinion matters to us!",style: TextStyle(
                    fontSize: 22.0,fontWeight: FontWeight.w500,color: AppColors.black.withOpacity(0.8)
                ),)),
              ),
              Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text("Enjoying PetroApp?",style: AppStyles.feedprimaryText,),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:5.0,bottom: 8.0),
                      child: Text("Tap on emoji to rate it.",style: AppStyles.feedsecondaryText,),
                    ),
                    SizedBox(height: 5.0.h,),
                    RatingBar.builder(
                      initialRating: rating,
                      itemCount: 5,
                      itemSize: 50.0,
                      itemBuilder: (BuildContext context, int index) {
                        switch (index) {
                          case 0:
                            return Icon(
                              Icons.sentiment_very_dissatisfied,
                              color: Colors.red,
                            );
                          case 1:
                            return Icon(
                              Icons.sentiment_dissatisfied,
                              color: Colors.redAccent,
                            );
                          case 2:
                            return Icon(
                              Icons.sentiment_neutral,
                              color: Colors.amber,
                            );
                          case 3:
                            return Icon(
                              Icons.sentiment_satisfied,
                              color: Colors.lightGreen,
                            );
                          case 4:
                            return Icon(
                              Icons.sentiment_very_satisfied,
                              color: Colors.green,
                            );
                          default:
                            return Container(); // This default case is necessary
                        }
                      },
                      onRatingUpdate: (double ratingUpdate) {
                        rating = ratingUpdate;
                        print(ratingUpdate);
                      },
                    ),
                    SizedBox(height: 8.0.h,),
                    SizedBox(height: 10.h,),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Divider(height: 1.0, color: Colors.grey[400],),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                child: TextFormField(
                  style: TextStyle(color: Color(0xFF08364B)),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Please enter Comment";
                    }
                  },
                  controller: messageController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Comment',
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
                      child: const Text('Send Feedback',
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
          "https://petrocard.000webhostapp.com/API/addfeedback.php");
      final response = await http
          .post(login_url, body: {
        "id": prefs.getString('id'),
        "rating": rating.toString(),
        "comment": messageController.text,
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
              backgroundColor: Colors.red, // Customize background color
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
