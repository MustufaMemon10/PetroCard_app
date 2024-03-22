import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petrocardapppp/utilities/colors.dart';

class TransactionText extends StatelessWidget {
  final bool isDark;

  const TransactionText({
    Key? key,
    required this.isDark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FadeInLeft(
            duration: Duration(milliseconds: 200),
            child: Text(
              'Recent Transaction',
              style: TextStyle(
                fontSize: 24.0.sp,
                fontWeight: FontWeight.w500,
                color: isDark ? AppColors.white : AppColors.black,
              ),
            ),
          ),
          FadeInRight(
            duration: Duration(milliseconds: 200),
            child: IconButton(
              icon: SvgPicture.asset(
                'assets/Icons/mac-action.svg',
                height: 5.0,
                width: 5.0,
                color: isDark ? AppColors.white : AppColors.black, // Use isDark to determine the icon color
              ),
              onPressed: () {
              },
            ),
          )
        ],
      ),
    );
  }
}

void _showPopupMenu(BuildContext context) {
  final RenderBox overlay =
  Overlay.of(context).context.findRenderObject() as RenderBox;
  showMenu(
    context: context,
    position: RelativeRect.fromRect(
      Rect.fromPoints(
        overlay.localToGlobal(Offset(0.0, 20.0)),
        overlay.localToGlobal(Offset(0.0, 20.0)),
      ),
      Offset.zero & overlay.size,
    ),
    items: [
      PopupMenuItem(
        child: Text('Option 1'),
        value: 1,
      ),
      PopupMenuItem(
        child: Text('Option 2'),
        value: 2,
      ),
      PopupMenuItem(
        child: Text('Option 3'),
        value: 3,
      ),
    ],
  );
}
