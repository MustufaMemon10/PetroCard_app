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
          Divider(height: 9.0,thickness: 2.0,color: AppColors.darkPurple,),
          SizedBox(height: 30,),
          Image.asset('assets/Icons/document.gif',height: 300,width: double.infinity,),
          SizedBox(height: 50,),
          Text("We're evaluating your request",style: TextStyle(
            color: AppColors.black,fontWeight: FontWeight.bold,
            letterSpacing: 0.7,fontSize: 20.0,
          ),),
          SizedBox(height: 20,),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 30.0),
            child: Text("Thank you for your request,Please stay tuned for updates on your request status.",style: TextStyle(
              color: AppColors.black.withAlpha(70),fontWeight: FontWeight.bold,
              letterSpacing: 0.8,fontSize: 18.0,
            ),),
          ),
        ],
      ),
    );
  }
}
