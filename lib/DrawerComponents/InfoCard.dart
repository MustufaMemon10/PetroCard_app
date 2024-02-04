import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petrocardapppp/Components/colors.dart';


class InfoCard extends StatelessWidget {
  const InfoCard({
    Key? key,
    required this.name,
    required this.email,
  }) : super(key: key);
   
   final String name,email;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        backgroundColor: Colors.white70,
        child: Icon(
          CupertinoIcons.person,
          color: AppColors.black,
        ),
      ),
      title: Text(name,style: const TextStyle(color: AppColors.white,),),
      subtitle: Text(email,style:const TextStyle(color: AppColors.white,),),
    );
  }
}
