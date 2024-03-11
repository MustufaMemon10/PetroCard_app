import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petrocardapppp/utilities/colors.dart';
import 'package:petrocardapppp/utilities/styles.dart';

class TransactionCard extends StatefulWidget {
  final String title;
  final String subTitle;
  final String price;
  TransactionCard({
  required this.price,
  required this.subTitle,
  required this.title,
  });

  @override
  State<TransactionCard> createState() => _TransactionCardState();
}

class _TransactionCardState extends State<TransactionCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset('assets/Icons/petrol-station.png',height: 20,width: 20.0,),
              SizedBox(width: 8.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.subTitle,
                    style: TextStyle(fontSize: 12.0,fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ],
          ),
          Text(
            '${widget.price}₹',
            style: TextStyle(color: Colors.red, fontSize: 14.0),
          ),
        ],
      ),
    );
  }
}
