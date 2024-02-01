import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petrocardapppp/Components/colors.dart';
import 'package:petrocardapppp/Widgets/GreetingWidget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.translightPurple2,
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 1.sh,
                width: 1.sw,
                padding: const EdgeInsets.symmetric(vertical: 35.0,horizontal: 10.0),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.white,
                      AppColors.translightPurple2,
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              SizedBox(
                                height: 55.h,
                                width: width,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.white,
                                      shape: BoxShape.circle,
                                      border: Border.all(color: AppColors.white.withOpacity(.5),width: 1.0),
                                      boxShadow:  [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 5,
                                          blurRadius: 15,
                                          offset: const Offset(0, 10),
                                        ),
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 5,
                                          blurRadius: 10,
                                          offset: const Offset(0, 5),
                                        ),
                                      ],
                                    ),
                                    child: IconButton(onPressed: (){}, icon: const Icon(Icons.menu),color: AppColors.primaryText,),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.white,
                                      boxShadow:  [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 5,
                                          blurRadius: 15,
                                          offset: const Offset(0, 10),
                                        ),
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 5,
                                          blurRadius: 10,
                                          offset: const Offset(0, 5),
                                        ),
                                      ],
                                    ),
                                    child: IconButton(onPressed: (){}, icon: const Icon(Icons.notifications_active_outlined),color: AppColors.primaryText,),
                                  ),
                                ]),
                              ),
                              Positioned(
                                  top: 5.h,
                                  right: 120.0.w,
                                  left: 5.w,
                                  child:
                                  Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      GreetingWidget(),
                                       Text(' Mustufa Memon!',style: TextStyle(
                                        fontSize: 14.0.sp,fontWeight: FontWeight.w500,
                                      ),)
                                    ],
                                  )
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  height: .5.sh,
                  width: 1.sw,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0.r),
                      topRight: Radius.circular(30.0.r),
                    ),
                    color: AppColors.white,
                    boxShadow:  [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 5,
                        blurRadius: 15,
                        offset: const Offset(0, 10),
                      ),
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 5,
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child:Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            height: 4.h,
                            width: 50.w,
                            decoration: BoxDecoration(
                              color: AppColors.secondaryText,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        )
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}