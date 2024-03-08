import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:petrocardapppp/utilities//colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petrocardapppp/utilities/styles.dart';

class CustomTextfield extends StatefulWidget {
  final IconData icon;
  final String hintText;
  final String errorMsg;
  final TextEditingController controller;
  final String? Function(String?)? validatorValue;
  final bool showBorder;
  final bool numerickeyboard;
  final bool istrue;

  const CustomTextfield({
    Key? key,
    required this.icon,
    required this.hintText,
    required this.controller,
    this.showBorder = true,
    required this.validatorValue,
    required this.errorMsg,
    this.numerickeyboard = false,
    this.istrue = true,
  }) : super(key: key);

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {


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
      child: TextFormField(
        controller: widget.controller,
        textInputAction:
        widget.istrue ? TextInputAction.next : TextInputAction.go,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return widget.errorMsg;
          }
          return widget.validatorValue!(value);
        },
        decoration: InputDecoration(
          prefixIcon: Icon(
            widget.icon,
            color: AppColors.darkPurple,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
          border: InputBorder.none,
          hintText: widget.hintText,
            errorText: widget.validatorValue!(widget.controller.text),
          hintStyle:
          const TextStyle(color: AppColors.secondaryText, letterSpacing: 0.7),
        ),
      ),
    );
  }
}

class CustomPassfields extends StatefulWidget {
  final IconData icon;
  final IconData icon2;
  final bool oneField;
  final String hintText;
  final String hintText2;
  final TextEditingController controller;
  final String errorMsg;
  final bool isSufixIcon;
  final Function(String value) validator;
  final TextEditingController controller2;
  final bool obscureText;
  final bool isBorder;

  const CustomPassfields({
    Key? key,
    required this.icon,
    this.oneField = false,
    required this.icon2,
    required this.hintText,
    required this.hintText2,
    required this.controller,
    required this.validator,
    required this.errorMsg,
    this.isSufixIcon = true,
    this.isBorder =false,
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
      child: widget.oneField?
      Container(
        padding: const EdgeInsets.all(10.0),
        decoration: widget.isBorder? BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppColors.lightPurple),
          ),
        ): null,
        child: TextFormField(
          controller: widget.controller2,
          obscureText: _isObscured,
          textInputAction: TextInputAction.go,
          validator: (value){
            widget.validator(value!);
            if(value.isEmpty){
              return widget.errorMsg;
            }
            return null;
          },
          decoration: InputDecoration(
              prefixIcon: Icon(
                widget.icon2,
                color: AppColors.darkPurple,
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
              border: InputBorder.none,
              hintText: widget.hintText2,
              hintStyle: const TextStyle(
                  color: AppColors.secondaryText, letterSpacing: 0.7),
              suffixIcon: widget.isSufixIcon ?IconButton(
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
              ):null,),
        ),
      ): Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: AppColors.lightPurple),
              ),
            ),
            child: TextFormField(
              controller: widget.controller,
              obscureText: _isObscured,
              textInputAction: TextInputAction.next,
              validator: (value){
                widget.validator(value!);
                if(value.isEmpty){
                  return widget.errorMsg;
                }
                return null;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(
                  widget.icon,
                  color: AppColors.darkPurple,
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                border: InputBorder.none,
                hintText: widget.hintText,
                hintStyle: AppStyles.Textfield_hintstyle,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              controller: widget.controller2,
              obscureText: _isObscured,
              textInputAction: TextInputAction.go,
              validator: (value){
                widget.validator(value!);
                if(value.isEmpty){
                  return widget.errorMsg;
                }
                return null;
              },
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    widget.icon2,
                    color: AppColors.darkPurple,
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
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
      )
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
          TextField(
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
        ],
      ),
    );
  }
}
