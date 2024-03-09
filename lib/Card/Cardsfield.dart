import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petrocardapppp/Card/MainCard.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:petrocardapppp/utilities/styles.dart';

import '../utilities/colors.dart';
import 'Request/Request_card.dart';

class Cardsfield extends StatefulWidget {

   Cardsfield({Key? key}) : super(key: key);

  @override
  State<Cardsfield> createState() => _CardsfieldState();
}

class _CardsfieldState extends State<Cardsfield> {
  bool _showAddCardButton = true;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child:const PetroMainCard(),
          // child:
          // Container(
          //   height: 190.h,
          //   width: 400.w,
          //   decoration: BoxDecoration(
          //     color: Colors.transparent,
          //     borderRadius: BorderRadius.circular(20.0),
          //     border: Border.all(width: 1.0,color: AppColors.darkPurple)
          //   ),
          //   child: Center(
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         Container(
          //           decoration: const BoxDecoration(
          //             shape: BoxShape.circle,
          //             color: Colors.blue,
          //           ),
          //           child: IconButton(
          //             onPressed: (){Navigator.of(context).push(
          //               CupertinoPageRoute(
          //                 builder: (context) => Request_Screen(),
          //               ),
          //             );},
          //             icon: const Icon(Icons.add,color: Colors.white,),
          //           ),
          //         ),
          //         const SizedBox(height: 8.0,),
          //          Text('Apply Card',style: TextStyle(color: Colors.black45, fontWeight: FontWeight.w400, fontSize: 20.0),)
          //       ],
          //     ),
          //   ),
          // ),
          ),
        ],
      ),
    );
  }
}