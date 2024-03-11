import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petrocardapppp/Card/Cardsfield.dart';
import 'package:petrocardapppp/Components/custombtns.dart';
import 'package:petrocardapppp/Widgets/SleeveWidget.dart';
import 'package:petrocardapppp/Widgets/Transaction_card.dart';
import 'package:petrocardapppp/utilities/colors.dart';
import 'package:petrocardapppp/utilities/styles.dart';

import '../../Widgets/Transaction Text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.white, // Set background color based on isDark
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: isDark ? AppColors.darkBackground : AppColors.white, // Set app bar color based on isDark
            elevation: 5,
            pinned: true,
            centerTitle: false,
            stretch: true,
            expandedHeight: 0.510.sh,
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0.w),
                child: Cardsfield(),
              ),
            ),
          ),
          SliverAppBar(
            backgroundColor: isDark ? AppColors.darkTransactionBackground : AppColors.white, // Set app bar color based on isDark
            elevation: 0,
            pinned: true,
            centerTitle: true,
            bottom: const PreferredSize(
              child: SizedBox(),
              preferredSize: Size.fromHeight(-10.0),
            ),
            flexibleSpace: TransactionText(isDark: isDark,),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 10.w),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
                    decoration: BoxDecoration(
                        color: isDark ? AppColors.darkCardBackground : AppColors.white, // Set card color based on isDark
                        border: Border.all(width: 0.5, color: AppColors.secondaryText),
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primaryPurple.withOpacity(0.2),
                            offset: Offset(1, 2),
                          )
                        ]
                    ),
                    child: TransactionCard(
                      title: 'Transaction $index',
                      subTitle: 'Date $index',
                      price: '-$index',
                    ),
                  ),
                );
              },
              childCount: 10, // Example number of items
            ),
          ),
        ],
      ),
    );
  }
}


