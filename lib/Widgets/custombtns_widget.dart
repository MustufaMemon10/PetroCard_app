
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:petrocardapppp/utilities/colors.dart';

class Btn extends StatefulWidget {
  final IconData icon;
  final String text;
  final Function() onTap;

  const Btn({
    Key? key,
    required this.icon,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  State<Btn> createState() => _BtnState();
}

class _BtnState extends State<Btn> {
  bool isButtonPressed = false;
  void Buttonpressed(){
    setState(() {
      isButtonPressed = !isButtonPressed;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      GestureDetector(
        onTap: Buttonpressed,
        child: AnimatedContainer(
          duration: Duration (milliseconds: 100),
          height: 60,
          width: 70,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(width: 0.8,color: AppColors.black),
            boxShadow: [
              isButtonPressed?BoxShadow(
                color: Colors.grey.shade50,
                offset: Offset(-6,-6),
                blurRadius: 10,
                spreadRadius: 1,
              ):BoxShadow(
                color: Colors.grey.shade400,
                offset: Offset(6,6),
                blurRadius: 10,
                spreadRadius: 1,
              )
            ]
          ),
              child: Icon(
                widget.icon,
                size: 22.0,
                color: AppColors.primaryPurple,
              )),
      ),
        SizedBox(height: 10.0),
        Text(
          widget.text,
          style: TextStyle(
            fontSize: 16.0, // Adjust font size as needed
            color: AppColors.primaryText, // Use card text color
            fontWeight: FontWeight.bold, // Adjust font weight as needed
          ),
        )
      ],
    );
  }
}
