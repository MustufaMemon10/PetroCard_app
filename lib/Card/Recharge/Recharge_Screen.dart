import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petrocardapppp/utilities/colors.dart';

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
  TextEditingController _emailController = TextEditingController();

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
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.black,
          ),
          iconSize: 18.0,
        ),
      ),
      body: Form(
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
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,letterSpacing: 0.6),
              ),
              SizedBox(height: 10),
          TextFormField(
            keyboardType: TextInputType.number,
            controller: _cardNumberController,
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (!RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]$').hasMatch(value!)) {
                return 'Please enter a valid Card Number';
              }
              if (value.isEmpty) {
                return 'Card Number is required';
              }
              return null;
            },
            decoration: InputDecoration(
                labelText: 'Card Number',
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
                suffix: Image.asset(
                  'assets/Icons/credit-card (1)suffix.png', height: 20.0,
                  width: 30.0,)
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
            child: TextFormField(
              controller: _cvvController,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (!RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]$').hasMatch(value!)) {
                  return 'Please enter a valid  Number';
                }
                if (value.isEmpty) {
                  return 'CVV is required';
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: 'CVV',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0),
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
              ),
            ),
          ),
          SizedBox(
            width: 0.41.sw,
            child: TextFormField(
              controller: _expiryController,
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Expiry date is required';
                }
                // Add additional validation if needed, such as checking the format (MM/YY)
                return null;
              },
              decoration: InputDecoration(
              labelText: 'Expiry',
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
            ),
          ),
        ),
        ],
      ),
      SizedBox(height: 20,),
              TextFormField(
                controller: _amountController,
                textCapitalization: TextCapitalization.characters,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Amount date is required';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Amount',
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
                ),
              ),
      SizedBox(height: 30,),
      Center(
        child: SizedBox(
          width: 250.w,
          height: 40.h,
          child: ElevatedButton(
            onPressed: () {
              // Implement payment logic here
              _handlePayment(context);
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
    ),)
    ,
    )
    ,
    );
  }
}

void _handlePayment(BuildContext context) {}
