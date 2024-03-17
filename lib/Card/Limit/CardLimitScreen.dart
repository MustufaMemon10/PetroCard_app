import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petrocardapppp/utilities/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:petrocardapppp/screens/MainScreen/BaseScreen.dart';


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
        'limitamount' : _limitController.text ?? '',
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppColors.darkPurple,
        title: Text('Set Limit',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 20,color: AppColors.white),),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
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
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: GestureDetector(
            onTap: (){
              FocusScope.of(context).unfocus();
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(bottom: 10.0),
                    decoration: BoxDecoration(
                      color: AppColors.darkPurple.withAlpha(20),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Text('Current:'+cardlimit,style: TextStyle(color: AppColors.secondaryText,fontSize: 18),)),
                TextFormField(
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
                        borderSide: BorderSide.none,
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
                SizedBox(
                  height: 20.0,
                ),
                Center(
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
                      child: Text('Set Limit'),
                    ),
                  ),
                ),
            ],),
          ),
        ),
      ),
    );
  }
}
