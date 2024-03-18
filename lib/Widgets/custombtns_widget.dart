import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petrocardapppp/utilities/colors.dart';

class Btn extends StatefulWidget {
  final String imagePath;
  final String text;
  final Function() onTap;

  const Btn({
    Key? key,
    required this.imagePath,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  State<Btn> createState() => _BtnState();
}

class _BtnState extends State<Btn> {
  bool isButtonPressed = false;
  @override
  Widget build(BuildContext context) {
    return Column(
            children: [
              SizedBox(
                height: 50,
                width: 60,
                child: ElevatedButton(
                    onPressed: widget.onTap,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.white,
                      side: BorderSide(
                        color: AppColors.grey.withOpacity(0.6),
                        width: 1.0,
                      ),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
                    ),
                    child: Image.asset(
                      widget.imagePath,
                     height: 35,
                      width: 40,
                    )),
              ),
              SizedBox(height: 10.0),
              Text(
                widget.text,
                style: TextStyle(
                  fontSize: 16.0, // Adjust font size as needed
                  color: AppColors.primaryText, // Use card text color
                  fontWeight: FontWeight.w600, // Adjust font weight as needed
                ),
              )
            ],
          );
  }
}
