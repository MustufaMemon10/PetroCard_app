import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petrocardapppp/utilities/colors.dart';
import 'package:petrocardapppp/utilities/styles.dart';

class RatingPopup extends StatefulWidget {
  @override
  _RatingPopupState createState() => _RatingPopupState();
}

class _RatingPopupState extends State<RatingPopup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 278.h,
          width: 0.83.sw,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.grey[400]!,width: 0.2),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5), // Adjust shadow color
                spreadRadius: 2, // Increase spread radius for a softer shadow
                blurRadius: 5,
                offset: Offset(0, 4),
              )
            ]
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 0.05.sh,
                decoration: BoxDecoration(
                  color: AppColors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10.0),
                      topLeft: Radius.circular(10.0),
                    ),
                ),
                child: Center(child: Text("Your opinion matters to us!",style: AppStyles.feedmainText,)),
              ),
              Container(
                height: 175.h,
                width: double.infinity,
                color: Color.fromRGBO(196, 201, 213, 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text("Enjoying PetroApp?",style: AppStyles.feedprimaryText,),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:5.0,bottom: 8.0),
                      child: Text("Tap on emoji to rate it.",style: AppStyles.feedsecondaryText,),
                    ),
                    SizedBox(height: 5.0.h,),
                    RatingBar.builder(
                      initialRating: 3,
                      itemCount: 5,
                      itemSize: 50.0,
                      itemBuilder: (BuildContext context, int index) {
                        switch (index) {
                          case 0:
                            return Icon(
                              Icons.sentiment_very_dissatisfied,
                              color: Colors.red,
                            );
                          case 1:
                            return Icon(
                              Icons.sentiment_dissatisfied,
                              color: Colors.redAccent,
                            );
                          case 2:
                            return Icon(
                              Icons.sentiment_neutral,
                              color: Colors.amber,
                            );
                          case 3:
                            return Icon(
                              Icons.sentiment_satisfied,
                              color: Colors.lightGreen,
                            );
                          case 4:
                            return Icon(
                              Icons.sentiment_very_satisfied,
                              color: Colors.green,
                            );
                          default:
                            return Container(); // This default case is necessary
                        }
                      },
                      onRatingUpdate: (double rating) {
                        print(rating);
                      },
                    ),
                    SizedBox(height: 8.0.h,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Container(
                        width: 250.w,
                        height: 60.h,
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                              width: 0.5,
                              color: AppColors.primaryText.withOpacity(0.5)
                            ),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                              hintStyle: AppStyles.Textfield_hintstyle,
                              hintText: "Comment"),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h,),

                  ],
                ),
              ),
              Container(
                  width: double.infinity,
                  height:32.h,
                  padding: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                  ),
                  child: TextButton(
                    onPressed: (){},
                    child: Text("Rate Us",style: TextStyle(
                      color: AppColors.accentColor.withOpacity(0.8),
                      fontSize: 14.0,
                      letterSpacing: 0.7,
                      fontWeight: FontWeight.w500,
                    ),),
                  )
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Divider(height: 1.0, color: Colors.grey[400],),
              ),
              Container(
                width: double.infinity,
                height:32.h,
                padding: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0),
                  ),
                ),
                child: TextButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  child: Text("Not Now",style: TextStyle(
                    color: AppColors.accentColor.withOpacity(0.8),
                    fontSize: 13.0,
                    letterSpacing: 0.7,
                    fontWeight: FontWeight.w500,
                  ),),
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
