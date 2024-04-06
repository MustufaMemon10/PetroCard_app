import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petrocardapppp/screens/MainScreens/BaseScreen.dart';
import 'package:petrocardapppp/utilities/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RechargeCardScreen extends StatefulWidget {
  const RechargeCardScreen({super.key});

  @override
  State<RechargeCardScreen> createState() => _RechargeCardScreenState();
}

class _RechargeCardScreenState extends State<RechargeCardScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _cardNumberController = TextEditingController();
  TextEditingController _cvvController = TextEditingController();
  TextEditingController _expiryController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
  bool isLoading = false;

  Future<void> _rechargeCard() async {
    SharedPreferences setpreference = await SharedPreferences.getInstance();
    final form = _formKey.currentState;
    if (form!.validate()) {
      setState(() {
        isLoading = true;
      });
      final login_url =
          Uri.parse("https://petrocard.000webhostapp.com/API/rechargecard.php");
      final response = await http.post(login_url, body: {
        'id': setpreference.getString('id') ?? '',
        'amount': _amountController.text,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Recharge Card',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18.0,
            color: AppColors.black,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              color: Colors.black.withAlpha(20),
            ),
            child:
                Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0.w, horizontal: 20.0.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Enter Payment Details',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 15),
                Text(
                  'Credit/Debit/ATM card',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.6),
                ),
                SizedBox(height: 15),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _cardNumberController,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value!.length != 16) {
                      if (value.isEmpty) {
                        return 'Card Number is required';
                      }
                      return 'Provide valid Card Number';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: 'Card Number',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(
                              color: AppColors.lightPurple, width: 0.5)),
                      filled: true,
                      // Enable filled mode
                      fillColor: Colors.grey[200],
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.lightPurple2),
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
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 20.0),
                      suffix: Image.asset(
                        'assets/Icons/credit-card (1)suffix.png',
                        height: 20.0,
                        width: 30.0,
                      )),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 0.41.sw,
                      child: TextFormField(
                        controller: _cvvController,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.length != 5) {
                            if (value.isEmpty) {
                              return 'CVV is required';
                            }
                            return 'Provide valid Cvv';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'CVV',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16.0),
                              borderSide: BorderSide(
                                  color: AppColors.lightPurple, width: 0.5)),
                          filled: true,
                          // Enable filled mode
                          fillColor: Colors.grey[200],
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.lightPurple2),
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
                              color: AppColors.secondaryText,
                              letterSpacing: 0.7),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 20.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 0.41.sw,
                      child: TextFormField(
                        controller: _expiryController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Expiry date is required';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Expiry',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: BorderSide(
                                  color: AppColors.lightPurple, width: 0.5)),
                          filled: true,
                          // Enable filled mode
                          fillColor: Colors.grey[200],
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.lightPurple2),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.darkPurple),
                            // Customize focused border color
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.red),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          floatingLabelStyle: const TextStyle(
                              color: AppColors.darkPurple, letterSpacing: 0.7),
                          labelStyle: const TextStyle(
                              color: AppColors.secondaryText,
                              letterSpacing: 0.7),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 20.0),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _amountController,
                  textCapitalization: TextCapitalization.characters,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Amount is required';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Amount',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(
                            color: AppColors.lightPurple, width: 0.5)),
                    filled: true,
                    // Enable filled mode
                    fillColor: Colors.grey[200],
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.lightPurple2),
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
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: SizedBox(
                    width: 250.w,
                    height: 40.h,
                    child: ElevatedButton(
                      onPressed: () {
                        _rechargeCard();
                        FocusScope.of(context).unfocus();
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: AppColors.darkPurple,
                        side: BorderSide.none,
                        shape: StadiumBorder(),
                      ),
                      child: Text('Pay Now'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
