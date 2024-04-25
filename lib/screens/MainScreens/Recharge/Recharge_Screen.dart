import 'dart:convert';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
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
      body: Stack(
        children: [
          GestureDetector(
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
                    FadeInDown(
                      duration: Duration(milliseconds: 550),
                      child: Text(
                        'Enter Payment Details',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 15),
                    FadeInDown(
                      duration: Duration(milliseconds: 580),
                      child: Text(
                        'Credit/Debit/ATM card',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.6),
                      ),
                    ),
                    SizedBox(height: 15),
                    FadeInDown(
                      duration: Duration(milliseconds: 600),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: _cardNumberController,
                        textInputAction: TextInputAction.next,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          FilteringTextInputFormatter.singleLineFormatter,
                          CreditCardNumberFormatter(),
                          LengthLimitingTextInputFormatter(19), // Limit input to 5 characters (MM/YY)
                        ],
                        validator: (value) {
                          if (value!.length != 19) {
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
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 0.41.sw,
                          child: FadeInDown(
                            duration: Duration(milliseconds: 650),
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
                        ),
                        SizedBox(
                          width: 0.41.sw,
                          child: FadeInDown(
                            duration: Duration(milliseconds: 680),
                            child:TextFormField(
                              controller: _expiryController,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                _ExpiryDateFormatter(),
                                LengthLimitingTextInputFormatter(5), // Limit input to 5 characters (MM/YY)
                              ],
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Expiry date is required';
                                }
                                // Add additional validation logic for expiry date format if needed
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: 'Expiry (MM/YY)', // Update the label to reflect MM/YY format
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: BorderSide(color: AppColors.lightPurple, width: 0.5),
                                ),
                                filled: true,
                                fillColor: Colors.grey[200],
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: AppColors.lightPurple2),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: AppColors.darkPurple),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: AppColors.red),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                floatingLabelStyle: const TextStyle(
                                  color: AppColors.darkPurple,
                                  letterSpacing: 0.7,
                                ),
                                labelStyle: const TextStyle(
                                  color: AppColors.secondaryText,
                                  letterSpacing: 0.7,
                                ),
                                contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                              ),
                            )

                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FadeInDown(
                      duration: Duration(milliseconds: 720),
                      child: TextFormField(
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
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: FadeInDown(
                        duration: Duration(milliseconds: 760),
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
                    ),
                  ],
                ),
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
      ),
    );
  }
}
class _ExpiryDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    if (text.length > 2 && !text.contains('-')) {
      text = text.substring(0, 2) + '/' + text.substring(2);
    }

    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
class CreditCardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    if (text.length > 4) {
      text = text.substring(0, 4) +
          '-' +
          text.substring(4, 8) +
          '-' +
          text.substring(8, 12) +
          '-' +
          text.substring(12, 16);
    }


    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}


