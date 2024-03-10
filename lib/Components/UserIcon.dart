import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserIcon extends StatefulWidget {
  const UserIcon({super.key});

  @override
  State<UserIcon> createState() => _UserIconState();
}

class _UserIconState extends State<UserIcon> {
  Future<void> fetchGender() async {
    SharedPreferences setpreference = await SharedPreferences.getInstance();
    setState(() {
      Gender = setpreference.getString('gender') ?? '';
    });
  }
  void initState() {
    super.initState();
    fetchGender();

  }
  String? Gender;
  @override
  Widget build(BuildContext context) {
    return
   SizedBox(
      child:Gender == 'male'?
      Image.asset('assets/Icons/man.png',)
    :Gender == 'female'
          ? Image.asset('assets/Icons/woman.png'):
      Image.asset('assets/Icons/man.png',)
    );
  }
}
