import 'dart:convert';
import 'package:animate_do/animate_do.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petrocardapppp/utilities/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:petrocardapppp/screens/MainScreens/BaseScreen.dart';


class CardLimitScreen extends StatefulWidget {
  const CardLimitScreen({super.key});

  @override
  State<CardLimitScreen> createState() => _CardLimitScreenState();
}

class _CardLimitScreenState extends State<CardLimitScreen> {
  String cardlimit = '';
  final _formKey = GlobalKey<FormState>();
  TextEditingController _limitController = TextEditingController();
  bool isLoading = false;
  Future<void> _limitChange() async {
    SharedPreferences setpreference = await SharedPreferences.getInstance();
    final form = _formKey.currentState;
    if (form!.validate()) {
      setState(() {
        isLoading = true;
      });
      final login_url =
      Uri.parse("https://petrocard.000webhostapp.com/API/setcardlimit.php");
      final response = await http.post(login_url, body: {
        'id': setpreference.getString('id') ?? '',
        'limitamount' : _limitController.text,
      });
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print(responseData);
        setState(() {
          isLoading = false;
        });
        if (responseData['error'] == false) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(responseData['message'].toString()),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.green, // Customize background color
            ),
          );
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => BaseScreen()),
                  (route) => false);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(responseData['message'].toString()),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.red, // Customize background color
            ),
          );
        }
      }
    }
  }
  Future<void> getCardlimit() async {
    SharedPreferences setpreference = await SharedPreferences.getInstance();
    setState(() {
      cardlimit = setpreference.getString('cardlimit') ?? '';
    });
  }
  @override
  void initState() {
    super.initState();
    getCardlimit();
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: AppColors.white,
            title: Text('Set Limit',style: TextStyle(fontWeight: FontWeight.w800,fontSize: 20,color: AppColors.black),),
            centerTitle: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(15),
              ),
            ),
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  color: AppColors.black.withAlpha(20),
                ),
                child: Icon(Icons.arrow_back_ios_new, color:Colors.black, size: 20),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: GestureDetector(
                onTap: (){
                  FocusScope.of(context).unfocus();
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.0,),
                    Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(bottom: 10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: FadeInDown(
                              duration:Duration(milliseconds: 550),child: Text('Customize Your Card Spending Limit',style: TextStyle(color: AppColors.darkPurple,fontSize: 22,fontWeight: FontWeight.w600),))),
                    SizedBox(height: 20,),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 20.0),
                        child: FadeInDown(
                          duration:Duration(milliseconds: 580),
                          child: Text('Your Current Card Limit is:'+cardlimit,style: TextStyle(color: AppColors.secondaryText,fontSize: 18),),
                        ),
                      ),
                    ),
                    FadeInDown(
                      duration: Duration(milliseconds: 600),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: _limitController,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Limit is required';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: 'Set Limit',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide:
                                BorderSide(color: AppColors.lightPurple, width: 0.5)),
                            filled: true,
                            // Enable filled mode
                            fillColor: Colors.grey[200],
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.darkPurple),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.darkPurple),
                              // Customize focused border color
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.red),
                              // Customize error border color
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            floatingLabelStyle: const TextStyle(
                                color: AppColors.darkPurple, letterSpacing: 0.7),
                            labelStyle: const TextStyle(
                                color: AppColors.secondaryText, letterSpacing: 0.7),
                            contentPadding:
                            EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                           prefixIcon: Icon(Icons.keyboard_double_arrow_up,color: AppColors.darkPurple,size: 18,)
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Center(
                      child: FadeInDown(
                        duration: Duration(milliseconds: 650),
                        child: SizedBox(
                          width: 250.w,
                          height: 40.h,
                          child: ElevatedButton(
                            onPressed: () {
                              _limitChange();
                              FocusScope.of(context).unfocus();
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: AppColors.darkPurple,
                              side: BorderSide.none,
                              shape: StadiumBorder(),
                            ),
                            child: Text('Confirm'),
                          ),
                        ),
                      ),
                    ),
                ],),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
