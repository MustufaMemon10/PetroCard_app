import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  bool isLoading = false;

  void _StartLoading() {
    setState(() {
      isLoading = !isLoading;
    });
    setState(() {
      isLoading = !isLoading;
    });
  }

  @override
  void initState() {
    super.initState();
    _StartLoading();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? CardLoading(
            height: 30.h,
            width: 30.w,
            borderRadius: BorderRadius.circular(16.0),
          )
        : Column(
            children: [
              SizedBox(
                height: 50.h,
                width: 60.w,
                child: ElevatedButton(
                    onPressed: widget.onTap,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.white,
                      side: BorderSide(
                        color: AppColors.lightPurple2,
                        width: 1.0,
                      ),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
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
                  fontWeight: FontWeight.w600, // Adjust font weight as needed
                ),
              )
            ],
          );
  }
}
