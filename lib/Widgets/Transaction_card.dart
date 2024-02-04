import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:petrocardapppp/Components/colors.dart';

class TransactionCard extends StatefulWidget {
  const TransactionCard({super.key});

  @override
  State<TransactionCard> createState() => _TransactionCardState();
}

class _TransactionCardState extends State<TransactionCard> {
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.1,
      maxChildSize: 0.8,
      builder: (BuildContext context, ScrollController scrollController) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final maxHeight = constraints.maxHeight * 0.8; // Set your maximum height
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0.r),
                  topRight: Radius.circular(30.0.r),
                ),
                color: AppColors.black,
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: 4.h,
                        width: 50.w,
                        decoration: BoxDecoration(
                          color: AppColors.secondaryText,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: min(maxHeight, constraints.maxHeight),
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: SizedBox(
                        height: 1.sh, // Adjust the height as needed
                        width: 1.sw,
                        // Add other content as needed
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
