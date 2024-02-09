import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petrocardapppp/Components/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
          SizedBox(height: 120,),
           GridView.builder(
              scrollDirection: Axis.horizontal,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, 
                mainAxisSpacing: 10.0, 
                crossAxisSpacing: 10.0, 
              ),
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.all(10.0),
                  padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                  height: 0.28.sh,
                  width: 0.4.sw, // Adjust width as needed based on the number of columns
                  color: listOfStrings[index],
                );
              },
            ),

          ],
        ),
      ),
    );
  }
  
  List<Color> listOfStrings = [
    AppColors.darkPurple,
    AppColors.grey,
    AppColors.black,
    AppColors.red.withRed(200),
    
  ];
}
