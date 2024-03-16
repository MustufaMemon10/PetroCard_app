import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utilities/colors.dart';

class RequestUserIcon extends StatefulWidget {
  final String? Gender;
  const RequestUserIcon({
    required this.Gender,
    super.key});

  @override
  State<RequestUserIcon> createState() => _RequestUserIconState();
}

class _RequestUserIconState extends State<RequestUserIcon> {

  String? Gender;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: 35.0,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
              width: 0.8.w,
              color: Colors.black.withOpacity(0.5))),
      child: widget.Gender == 'Male'?
      Image.asset('assets/Icons/man.png',)
          :widget.Gender == 'Female'
          ? Image.asset('assets/Icons/woman.png'):
      widget.Gender == ''?
      Image.asset('assets/Icons/usericon.png',)
          : null,
    );
  }
}
