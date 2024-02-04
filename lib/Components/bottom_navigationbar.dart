import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petrocardapppp/Components/colors.dart';


class MyNavBar extends StatefulWidget {
  final Function(int) onIndexChanged;

  const MyNavBar({Key? key, required this.onIndexChanged}) : super(key: key);

  @override
  State<MyNavBar> createState() => _MyNavBarState();
}

class _MyNavBarState extends State<MyNavBar> {
  var _currentindex = 1;


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    final height = MediaQuery
        .of(context)
        .size
        .height;
    return Container(
        margin: const EdgeInsets.only(bottom: 5.0,right: 10.0,left: 10.0),
        height:.075.sh,
        width: 1.sw,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.3),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
          borderRadius:  BorderRadius.circular(50.0
            // topLeft: Radius.circular(30.0),
            // topRight: Radius.circular(30.0),
          ),
        ),
        child: ListView.builder(
          itemCount: 4,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: width * .02),
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              setState(() {
                _currentindex = index;
                HapticFeedback.lightImpact();
                widget.onIndexChanged(_currentindex);
              });
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Stack(
              children: [
                AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  curve: Curves.fastLinearToSlowEaseIn,
                  width: index == _currentindex
                      ? width * .32
                      : width * .18,
                  alignment: Alignment.center,
                  child: AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    curve: Curves.fastLinearToSlowEaseIn,
                    height: index == _currentindex ? width * .12 : 0,
                    width: index == _currentindex ? width * .32 : 0,
                    decoration: BoxDecoration(
                      color: index == _currentindex
                          ? AppColors.lightPurple.withOpacity(.2)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  curve: Curves.fastLinearToSlowEaseIn,
                  width: index == _currentindex
                      ? width * .31
                      : width * .18,
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(seconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn,
                            width:
                            index == _currentindex ? width * .13 : 0,
                          ),
                          AnimatedOpacity(
                            opacity: index == _currentindex ? 1 : 0,
                            duration: const Duration(seconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn,
                            child: Text(
                              index == _currentindex
                                  ? '${listOfStrings[index]}'
                                  : '',
                              style: const TextStyle(
                                color: AppColors.darkPurple,
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(seconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn,
                            width:
                            index == _currentindex ? width * .03 : 20,
                          ),
                          Icon(
                            listOfIcons[index],
                            size: width * .076,
                            color: index == _currentindex
                                ? AppColors.darkPurple
                                : Colors.black26,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }

  List<IconData> listOfIcons = [
    Icons.location_on_sharp,
    Icons.home_rounded,
    Icons.settings_rounded,
    Icons.person_rounded,
  ];

  List<String> listOfStrings = [
    'Locations',
    'Home',
    'Settings',
    'Account',
  ];
}
