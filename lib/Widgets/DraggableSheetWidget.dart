import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petrocardapppp/Components/colors.dart';



class MyDraggableScrollableSheet extends StatelessWidget {
  const MyDraggableScrollableSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.2,
      minChildSize: 0.2,
      maxChildSize: 0.9,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
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

              ListView.builder(
                controller: scrollController,
                itemCount: 50,
                itemBuilder: (BuildContext context, int index) {
                  return const ListTile(
                    title: Text('Recieved Person'),
                    subtitle: Text('money'),
                    leading: Icon(Icons.money_off_outlined),
                    trailing: Text('49.00₹'),
                  );
                },
              ),
            ],
          ),

        );
      },
    );
  }
}
