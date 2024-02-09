import 'package:flutter/material.dart';
import 'package:petrocardapppp/Components/colors.dart';

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
        SizedBox(height:  isSetting? 250 : 0,),
        ListTile(
            title: Text(title,
                style: const TextStyle(
                    color: Colors.black, fontFamily: 'BalsamiqSans_Regular')),
            leading: Icon(iconData, color: AppColors.black),
            onTap: () => onTap?.call(title)),
      ],
    );
  }
}