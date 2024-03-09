import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petrocardapppp/utilities/colors.dart';
import 'package:petrocardapppp/utilities/styles.dart';

class btn extends StatefulWidget {
  final IconData icon;
  final String text;
 const btn({
    Key? key,
    required this.icon,
   required this.text,
  }) : super(key: key);

  @override
  State<btn> createState() => _btnState();
}

class _btnState extends State<btn> {
  @override
  Widget build(BuildContext context) {
    return 
      Column(
        children: [
          InkWell(
          onTap: (){},
          child: Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              color: AppColors.white
                  .withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(width: .5,color: AppColors.darkPurple),
            ),
            child: Center(
              child: Icon(
                widget.icon,
                color: AppColors.darkPurple.withOpacity(0.9),
                size: 22.0,
              ),
            ),
          ),
    ),
          SizedBox(height: 6.0,),
          Text(widget.text,style: AppStyles.tagText,)
        ],
      );
  }
}