import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:petrocardapppp/utilities/colors.dart';
class MainDashBoardScreen extends StatefulWidget {
  const MainDashBoardScreen({
    super.key});

  @override
  State<MainDashBoardScreen> createState() => _MainDashBoardScreenState();
}

class _MainDashBoardScreenState extends State<MainDashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          children: [
            SizedBox(height: 60,),
            Text('Card User Ratio',style: TextStyle(
              fontWeight: FontWeight.w500,fontSize: 18
            ),),
            SizedBox(height: 20.0),
            SizedBox(height: 200,
                child: PieChart(
                  PieChartData(sections: [
                   PieChartSectionData(
                     color: AppColors.accentColor,
                     value: 25  ,
                     showTitle: false,
                     radius: 25
                   ),
                    PieChartSectionData(
                        color: AppColors.accent1Gold,
                        value: 20,
                        showTitle: false,
                        radius: 25
                    ),
                    PieChartSectionData(
                        color: AppColors.darkPurple.withOpacity(0.9),
                        value: 20,
                        showTitle: false,
                        radius: 25
                    ),
                    PieChartSectionData(
                        color: AppColors.darkPurple.withOpacity(0.9),
                        value: 20,
                        showTitle: false,
                        radius: 25
                    ),
              ])
                ),
                ),
            SizedBox(height: 30.0,),
            SizedBox(height: 30.0,),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      height: 50.0,
                    width: 50.0,
                    color: AppColors.accent1Gold,
                  ),
                  Text('Users',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w600,letterSpacing: 0.7),),
                  Text('23',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w600))
                ],
              ),
            ),
            SizedBox(height: 30.0,),
            Divider(color: Colors.grey,height: 2.0,),
            SizedBox(height: 30.0,),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 50.0,
                    width: 50.0,
                    color: AppColors.darkPurple,
                  ),
                  Text('Cards',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w600,letterSpacing: 0.7),),
                  Text('5',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w600))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
