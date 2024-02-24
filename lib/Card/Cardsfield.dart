import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petrocardapppp/Card/MainCard.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

import '../utilities/colors.dart';

class Cardsfield extends StatefulWidget {

   Cardsfield({Key? key}) : super(key: key);

  @override
  State<Cardsfield> createState() => _CardsfieldState();
}

class _CardsfieldState extends State<Cardsfield> {
  final List<Widget> cardList = [
    const PetroCard(cardColor: AppColors.lightPurple2,cardHolder: 'Mustufa Memon',cardMoney: '3200.50 ₹',startcvv: '2300',endcvv: '1242',),
    const PetroCard(cardColor: Colors.red,cardHolder: 'Ranjit Vaghela',cardMoney: '1700.23 ₹',startcvv: '8210',endcvv: '3230',),
    const PetroCard(cardColor: AppColors.accent2Turquoise,cardHolder: 'Hitesh Vanzara',cardMoney: '2310.10 ₹',startcvv: '4022',endcvv: '1011',),
    const PetroCard(cardColor: AppColors.black,cardHolder: 'Aayush Rana',cardMoney: '900.10 ₹',startcvv: '2300',endcvv: '1234'
    ),
    Container(
      height: 190.h,
      width: 380.w,
      decoration: BoxDecoration(
        color: Colors.grey.shade400,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
              child: IconButton(
                onPressed: (){},
                icon: const Icon(Icons.add,color: Colors.white,),
              ),
            ),
            const SizedBox(height: 4.0,),
            const Text('Add Card',style: TextStyle(color: Colors.black45, fontWeight: FontWeight.w400, fontSize: 20.0),)
          ],
        ),
      ),
    ),
  ];
  bool _showAddCardButton = true;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0,),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Hero(tag: 'cards',child: Text('Cards',style: TextStyle(fontSize: 20.0.sp,fontWeight: FontWeight.w700,color: AppColors.primaryText),)),
                  TextButton(onPressed: (){}, child:  Text(
                      'Manage >',style: TextStyle(fontSize: 14.0.sp,fontWeight: FontWeight.w700,color: AppColors.accentColor),
                  ))
                ],
              ),
            ),
            SizedBox(
              height: 230.h,
              width: 1.sw,
              child: CardSwiper(
                cardsCount: _showAddCardButton ? cardList.length : cardList.length - 1,
                onSwipe: _onSwipe,
                onUndo: _onUndo,
                numberOfCardsDisplayed: 2,
                backCardOffset: const Offset(0, -30),
                padding: const EdgeInsets.only(top: 50.0),
                cardBuilder: (
                    context,
                    index,
                    horizontalThresholdPercentage,
                    verticalThresholdPercentage,
                    ) =>
                cardList[index],
              ),
            ),
            SizedBox(height: 20.0.h,),
          ],
        ),
    );
  }
  bool _onSwipe(
      int previousIndex,
      int? currentIndex,
      CardSwiperDirection direction,
      ) {
    debugPrint(
      'The card $previousIndex was swiped to the ${direction.name}. Now the card $currentIndex is on top',
    );
    return true;
  }

  bool _onUndo(
      int? previousIndex,
      int currentIndex,
      CardSwiperDirection direction,
      ) {
    debugPrint(
      'The card $currentIndex was undod from the ${direction.name}',
    );
    return true;
  }
}

class Custombtns extends StatelessWidget {
  const Custombtns({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35.h,
      width: 35.w,
      decoration:  BoxDecoration(
        border: Border.all(width: 0.5.w,color: AppColors.black.withAlpha(150)),
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20.0),
        bottomRight: Radius.circular(20.0),
      ),
      color: AppColors.lightPurple2,
      boxShadow: [
        BoxShadow(
          color: AppColors.translightPurple2.withOpacity(0.5),
          blurRadius: 5.0,
          offset: const Offset(1,5)
        )
      ]
    ),
    child: const Icon(Icons.mobile_screen_share,color: AppColors.translightPurple,),
    );
  }
}
