import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petrocardapppp/Components/colors.dart';


class Myappbar extends StatefulWidget {
  const Myappbar({super.key});

  @override
  State<Myappbar> createState() => _MyappbarState();
}

class _MyappbarState extends State<Myappbar> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    return Container(
      height: .20.sh,
      padding: const EdgeInsets.symmetric(
          vertical: 25.0, horizontal: 10.0),
      decoration:  const BoxDecoration(
                color: AppColors.white,
      ),
      child: Column(
        children: [
          SizedBox(
            height: .11.sh,
            width: width,
            child: Row(
                mainAxisAlignment: MainAxisAlignment
                    .end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(onPressed: () {},
                    icon: const Icon(
                      Icons.notifications_active_outlined,
                      size: 26.0,),
                    color: AppColors.darkPurple,),
                ]),
          ),
        ],
      ),
    );
  }
}
