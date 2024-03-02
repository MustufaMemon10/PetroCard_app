import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petrocardapppp/utilities/colors.dart';

class btn extends StatefulWidget {
  final Color containerColor;
  final IconData icon;
  final String btntext;
 const btn({
    Key? key,
    required this.containerColor,
    required this.icon,
    required this.btntext,
  }) : super(key: key);

  @override
  State<btn> createState() => _btnState();
}

class _btnState extends State<btn> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
              height: 35.h,
              width: 35.w,
              padding: EdgeInsets.symmetric(vertical: 8.0,horizontal: 8.0),
              decoration:  BoxDecoration(
                border: Border.all(width: 0.5.w,color: AppColors.black.withAlpha(150)),
              borderRadius: BorderRadius.circular(12.0),
              color: widget.containerColor,
            ),
            child: Icon(
              widget.icon,
              color: AppColors.black,),
            ),
            SizedBox(height: 8.0.h,),
             Text(widget.btntext,style: TextStyle(fontSize: 14.0,fontWeight: FontWeight.w800,color: AppColors.primaryText.withOpacity(0.8)),),
             ],
    ); 
  }
}