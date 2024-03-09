import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petrocardapppp/utilities/colors.dart';

class SlidermenuItem extends StatelessWidget {
  final String title;
  final IconData iconData;
  final Function(String)? onTap;
  final bool isSetting;

  const SlidermenuItem(
      {Key? key,
        required this.title,
        required this.iconData,
        required this.onTap,
        this.isSetting = false,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(height: 5.h,
          color: AppColors.black.withOpacity(.3),
        ),
        ListTile(
            title: Text(title,
                style: const TextStyle(
                    color: Colors.black, fontFamily: 'RobotoMono')),
            leading: Icon(iconData, color: AppColors.black),
            onTap: () => onTap?.call(title)),
      ],
    );
  }
}