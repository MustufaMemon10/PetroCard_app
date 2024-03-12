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
            height: 60,
            width: 70,
            borderRadius: BorderRadius.circular(12.0),
          )
        : Column(
            children: [
              GestureDetector(
                onTap: widget.onTap,
                child: AnimatedContainer(
                    duration: Duration(milliseconds: 100),
                    height: 60,
                    width: 70,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(
                            width: 0.4.w, color: Colors.black.withOpacity(0.5)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade50,
                            offset: Offset(-6, -6),
                            blurRadius: 10,
                            spreadRadius: 1,
                          ),
                        ]),
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
