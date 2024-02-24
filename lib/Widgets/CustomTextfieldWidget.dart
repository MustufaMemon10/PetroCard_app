import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:petrocardapppp/utilities/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextfield extends StatefulWidget {
  final IconData icon;
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final bool showBorder;
  final bool sufixIcon;
  final bool numerickeyboard;
  final bool istrue;

  const CustomTextfield({
    Key? key,
    required this.icon,
    required this.hintText,
    required this.controller,
    this.showBorder = true,
    this.sufixIcon = false,
    required this.obscureText,
    this.numerickeyboard = false,
    this.istrue = true,
  }) : super(key: key);

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0.h, horizontal: 10.0.w),
      decoration: widget.showBorder
          ? const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.lightPurple),
        ),
      )
          : null,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(
              widget.icon,
              color: AppColors.secondaryText,
            ),
          ),
          Expanded(
            child: TextField(
              controller: widget.controller,
              obscureText: _isObscured,
              textInputAction:
              widget.istrue ? TextInputAction.next : TextInputAction.go,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: widget.hintText,
                hintStyle:
                const TextStyle(color: AppColors.secondaryText, letterSpacing: 0.7),
                suffixIcon: widget.sufixIcon
                    ? IconButton(
                  icon: Icon(
                    _isObscured ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isObscured = !_isObscured;
                    });
                  },
                )
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomPassfields extends StatefulWidget {
  final IconData icon;
  final IconData icon2;
  final String hintText;
  final String hintText2;
  final TextEditingController controller;
  final TextEditingController controller2;
  final bool obscureText;

  const CustomPassfields({
    Key? key,
    required this.icon,
    required this.icon2,
    required this.hintText,
    required this.hintText2,
    required this.controller,
    required this.controller2,
    required this.obscureText,
  }) : super(key: key);

  @override
  State<CustomPassfields> createState() => _CustomPassfieldsState();
}

class _CustomPassfieldsState extends State<CustomPassfields> {
  late bool _isObscured;
  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: AppColors.lightPurple),
              ),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(
                    widget.icon,
                    color: AppColors.secondaryText,
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: widget.controller,
                    obscureText: _isObscured,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: widget.hintText,
                      hintStyle: const TextStyle(
                          color: AppColors.secondaryText, letterSpacing: 0.7),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(
                    widget.icon2,
                    color: AppColors.secondaryText,
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: widget.controller2,
                    obscureText: _isObscured,
                    textInputAction: TextInputAction.go,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: widget.hintText2,
                        hintStyle: const TextStyle(
                            color: AppColors.secondaryText, letterSpacing: 0.7),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isObscured
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _isObscured = !_isObscured;
                            });
                          },
                        )),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NumericTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool showBorder;
  const NumericTextField({
    Key? key,
    required this.hintText,
    required this.controller,
    this.showBorder = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      padding: const EdgeInsets.all(10.0),
      decoration: showBorder
          ? BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey),
        ),
      )
          : null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding:  EdgeInsets.symmetric(vertical: 10.0,horizontal: 5.0),
            child: Text(
              '+91',
              style: TextStyle(
                color: AppColors.primaryText.withOpacity(0.8),
                fontSize: 16.0,
              ),
            )
          ),
          VerticalDivider(
            color: AppColors.lightPurple,
          ),
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 14.0),
                hintText: hintText,
                hintStyle: TextStyle(color: Colors.grey,
                    fontSize: 16.0,
                    letterSpacing: 0.7),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
