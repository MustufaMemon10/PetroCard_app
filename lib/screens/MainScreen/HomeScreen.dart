import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petrocardapppp/Card/Cardsfield.dart';
import 'package:petrocardapppp/Components/custombtns.dart';
import 'package:petrocardapppp/Widgets/Transaction_card.dart';
import 'package:petrocardapppp/utilities/colors.dart';
import 'package:petrocardapppp/utilities/styles.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      height: 1.sh,
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0.w),
      child: Column(
        children: [
          SizedBox(height: 70.h,),
           Cardsfield(),
           Appbtns(),
           Expanded(child: 
           Column(children: [
            Padding(padding: EdgeInsets.symmetric(vertical: 15.0,horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Text('Transactions',style: AppStyles.primaryTitle,),
              Icon(Icons.linear_scale_outlined,color: AppColors.black,),
            ]),
            ),
            Flexible(
              flex: 1,
              child:ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: [
                  TransactionCard( color: Colors.black,
                  letter: 'H',
                  title: 'HP Petroleum',
                  subTitle: '10/2/2024',
                  price: '-300',),
                  TransactionCard( color: Color(0xfffe695d),
                  letter: 'I',
                  title: 'Indian Oil',
                  subTitle: '09/2/2024',
                  price: '-50',),
                  TransactionCard( color: Color(0xff103289),
                  letter: 'B',
                  title: 'Bharat Petroleum',
                  subTitle: '07/2/2024',
                  price: '-400',),
                  TransactionCard( color: Colors.greenAccent,
                  letter: 'M',
                  title: 'Mercury',
                  subTitle: '5/2/2024',
                  price: '150',),
                  TransactionCard( color: Colors.amberAccent,
                  letter: 'R',
                  title: 'Rupam Petroleum',
                  subTitle: '31/1/2024',
                  price: '-600',),
                ],
              ) 
              )
           ],)
           )
        ],
      ),
    );
  }
}