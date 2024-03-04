import 'package:flutter/material.dart';
import 'package:petrocardapppp/utilities/colors.dart';

class AppStyles {
  //login page styles
  static TextStyle Textfield_hintstyle =
      TextStyle(color: AppColors.secondaryText, letterSpacing: 0.7);

  //card page style
  static TextStyle primaryTitle = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w600,
    color: AppColors.black,
  );
  static TextStyle seeAll = TextStyle(
    fontSize: 17.0,
    color: AppColors.black,
  );
  static TextStyle cardDetails = TextStyle(
    fontSize: 17.0,
    color: Color(0xff66646d),
    fontWeight: FontWeight.w600,
  );
  static TextStyle cardMoney = TextStyle(
    color: AppColors.white,
    fontSize: 22.0,
    fontWeight: FontWeight.w700,
  );
  static TextStyle tagText = TextStyle(
    fontStyle: FontStyle.italic,
    color: AppColors.black,
    fontWeight: FontWeight.w500,
  );
  static TextStyle otherDetailsPrimary = TextStyle(
    fontSize: 16.0,
    color: AppColors.black,
  );
  static TextStyle otherDetailsSecondary = TextStyle(
    fontSize: 12.0,
    color: Colors.grey,
  );
  static TextStyle locationText = TextStyle(
    fontSize: 24.0,
    color: Colors.black.withOpacity(0.8),
  );

  //rating page style
  static TextStyle feedmainText = TextStyle(
    fontSize: 24.0,
    color: AppColors.black,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.3,
  );
  static TextStyle feedprimaryText = TextStyle(
    fontSize: 20.0,
    color: AppColors.primaryText,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.7,
  );
  static TextStyle feedsecondaryText = TextStyle(
    fontSize: 18.0,
    color: AppColors.secondaryText,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.4,
  );
}
