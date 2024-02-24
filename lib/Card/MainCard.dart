import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petrocardapppp/utilities/colors.dart';
class PetroCard extends StatefulWidget {
  final Color cardColor;
  final String cardMoney;
  final String cardHolder;
  final String startcvv;
  final String endcvv;
  const PetroCard({
    Key? key,
    required this.cardColor,
    required this.cardMoney,
    required this.cardHolder,
    required this.startcvv,
    required this.endcvv,
  }) : super(key: key);

  @override
  State<PetroCard> createState() => _PetroCardState();
}

class _PetroCardState extends State<PetroCard> {
  bool isBalanceHidden = true;

  void toggleBalanceVisibility() {
    setState(() {
      isBalanceHidden = !isBalanceHidden;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190.h,
      width: 380.w,
      decoration: BoxDecoration(
        color: widget.cardColor,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child:   Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(padding: const EdgeInsets.symmetric(vertical: 24.0,horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isBalanceHidden ? '****.** ₹' : widget.cardMoney,
                  style: TextStyle(color: AppColors.white, fontSize: 22.0.sp, fontWeight: FontWeight.w700),
                ),
                InkWell(
                  onTap: toggleBalanceVisibility,
                  child: SvgPicture.asset(
                    'assets/svgs/hide-icon.svg',
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
            ),
            Padding(padding: EdgeInsets.only(left: 24.0,bottom: 32.0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.cardHolder,
                style: TextStyle(
                  fontSize: 16.0.sp,
                  fontWeight: FontWeight.w600,
                  color:  AppColors.white.withOpacity(0.6),
                ),),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 8.0.w),
                      child: Text(
                        widget.startcvv,
                        style: TextStyle(
                          fontSize: 16.0.sp,
                          fontWeight: FontWeight.w600,
                          color:  AppColors.white.withOpacity(0.8),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 8.0.w),
                      child: SvgPicture.asset('assets/svgs/card-dots.svg',color: AppColors.white.withOpacity(0.8),),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 8.0.w),
                      child: SvgPicture.asset('assets/svgs/card-dots.svg',color: AppColors.white.withOpacity(0.8),),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 8.0.w),
                      child: Text(
                        widget.endcvv,
                        style: TextStyle(
                          fontSize: 16.0.sp,
                          fontWeight: FontWeight.w600,
                          color:  AppColors.white.withOpacity(0.8),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            )
          ],
        ),
      ),
    );
  }
}
