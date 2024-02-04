import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petrocardapppp/Components/colors.dart';


class SidemenuTile extends StatelessWidget {
   SidemenuTile({
    Key? key,
    required this.title,
    required this.page,
    required this.icon,
  }): super(key: key);

  final String title;
  final Widget page;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
           Divider(color: AppColors.white.withOpacity(0.7), height: 1.0,),
         ListTile(
          onTap: (){
            Navigator.pushReplacement(
        context,
        CupertinoPageRoute(builder: (context) =>  page),
      );
          },
          leading: SizedBox(
            height: 34,
            width: 34,
            child: Icon(icon,color: AppColors.white.withOpacity(0.7),),
        ),
         title: Text(title,style: const TextStyle(color: AppColors.white,)),
        ),
      ],
    );
  }
}