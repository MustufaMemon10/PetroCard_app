import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utilities/colors.dart';

class UserIcon extends StatefulWidget {
   bool isDark= false;
   UserIcon({
    Key ? key,
    required this.isDark,
    }): super(key: key);

  @override
  State<UserIcon> createState() => _UserIconState();
}

class _UserIconState extends State<UserIcon> {
  Future<void> fetchGender() async {
    SharedPreferences setpreference = await SharedPreferences.getInstance();
    setState(() {
      Gender = setpreference.getString('gender') ?? '';
      print('$Gender');
    });
  }
  void initState() {
    super.initState();
    fetchGender();
  }
  String Gender = '';
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: 35.0,
      decoration: BoxDecoration(
          color: widget.isDark ? AppColors.black : AppColors.white,
          shape: BoxShape.circle,
      ),
      child: Gender == 'Male'?
      Image.asset('assets/Icons/man.png',)
          :Gender == 'Female'
          ? Image.asset('assets/Icons/woman.png'):
      Gender == ''?
      Image.asset('assets/Icons/usericon.png',color: widget.isDark? AppColors.white: AppColors.black,)
          : null,
    );
  }
}
