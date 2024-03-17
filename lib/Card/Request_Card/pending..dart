import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petrocardapppp/utilities/colors.dart';

class pendingscreen extends StatefulWidget {
  const pendingscreen({super.key});

  @override
  State<pendingscreen> createState() => _pendingscreenState();
}

class _pendingscreenState extends State<pendingscreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 0.15.sh,),
          Text('Pending Approval',style: TextStyle(
            color: AppColors.black,fontWeight: FontWeight.bold,
            letterSpacing: 0.7,fontSize: 24.0,
          ),),
          SizedBox(height: 30,),
          Image.asset('assets/Icons/document.gif',height: 300,width: double.infinity,),
          SizedBox(height: 80,),
          Text("We're evaluating your request",style: TextStyle(
            color: AppColors.black,fontWeight: FontWeight.bold,
            letterSpacing: 0.7,fontSize: 20.0,
          ),),
          SizedBox(height: 20,),
          Text("Thank you for your request, we're currently reviewing it to ensure everything is in order. Please stay tuned for updates on your request status.",style: TextStyle(
            color: AppColors.black.withAlpha(70),fontWeight: FontWeight.bold,
            letterSpacing: 0.7,fontSize: 16.0,
          ),),

        ],
      ),
    );
  }
}
