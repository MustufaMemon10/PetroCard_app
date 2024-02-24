import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petrocardapppp/utilities/colors.dart';
class NotificationItem extends StatefulWidget {
  final String notTitle;
  final String subtitle;

  const NotificationItem({
    Key? key,
    required this.notTitle,
    required this.subtitle,
  }) : super(key: key);

  @override
  _NotificationItemState createState() => _NotificationItemState();
}

class _NotificationItemState extends State<NotificationItem> {
  bool isMoreClicked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isMoreClicked ? 190 : 90,
      margin: EdgeInsets.symmetric(vertical: 5.0),
      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.notifications_active_outlined,
            size: 25.0,
            color: AppColors.darkPurple.withAlpha(230),
          ),
          SizedBox(width: 5.0,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.notTitle,
                  style: TextStyle(color: AppColors.primaryText, fontSize: 14.sp),
                ),
                Text(
                  widget.subtitle,
                  style: TextStyle(color: AppColors.primaryText.withAlpha(200), fontSize: 12.0.sp),
                  maxLines: 2,
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                isMoreClicked = !isMoreClicked;
              });
            },
            icon: Icon(
              Icons.more_vert,
              color: AppColors.black.withAlpha(160),
            ),
            iconSize: 19.0,
          ),
        ],
      ),
    );
  }
}
