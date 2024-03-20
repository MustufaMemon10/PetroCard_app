import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:petrocardapppp/utilities/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:petrocardapppp/screens/API/ApiHelper.dart';
class MainDashBoardScreen extends StatefulWidget {
  const MainDashBoardScreen({
    super.key});

  @override
  State<MainDashBoardScreen> createState() => _MainDashBoardScreenState();
}

class _MainDashBoardScreenState extends State<MainDashBoardScreen> {
  String usersdata = '';
  String requestdata = '';
  String feeddata = '';
  String complaintdata = '';
  bool isLoading = false;
  @override
  void initState(){
    super.initState();
    fetchAllDataLength();
  }
  Future<void> fetchAllDataLength() async {
    setState(() {
      isLoading = true;
    });
    await ApiHelper.fetchRequestsLength();
    await ApiHelper.fetchUsersLength();
    await ApiHelper.fetchComplainLength();
    await ApiHelper.fetchFeedbackLength();
    await getlength();
    setState(() {
      isLoading = false;
    });
    print('All data lengths fetched successfully.');
  }


  Future<void> getlength() async {
    SharedPreferences setpreference = await SharedPreferences.getInstance();
    setState(() {
      isLoading = true;
      usersdata = setpreference.getInt('usersLength').toString();
      requestdata = setpreference.getInt('requestLength').toString();
      feeddata = setpreference.getInt('feedLength').toString();
      complaintdata = setpreference.getInt('complaintLength').toString();
      isLoading = false;
    });
  }
    Future<void> _refreshData() async {
      await fetchAllDataLength();
    }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: RefreshIndicator(
          onRefresh: _refreshData,
          child: isLoading?
          Center(
            child: LoadingAnimationWidget.halfTriangleDot(
                color: AppColors.darkPurple, size: 50),
          )
              : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              children: [
                SizedBox(height: 60,),
                Center(
                  child: Text('Application Ratio',style: TextStyle(
                    fontWeight: FontWeight.w500,fontSize: 18
                  ),),
                ),
                SizedBox(height: 20.0),
                SizedBox(height: 200,
                    child: PieChart(
                      PieChartData(sections: [
                       PieChartSectionData(
                         color: AppColors.accent1Gold,
                         value: 39,
                         showTitle: false,
                         radius: 25
                       ),
                        PieChartSectionData(
                            color: AppColors.accent2Turquoise,
                            value: 6,
                            showTitle: false,
                            radius: 25
                        ),
                        PieChartSectionData(
                            color: AppColors.green,
                            value: 6,
                            showTitle: false,
                            radius: 25
                        ),
                        PieChartSectionData(
                            color: AppColors.red,
                            value: 6,
                            showTitle: false,
                            radius: 25
                        ),
                  ])
                    ),
                    ),
                SizedBox(height: 30.0,),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 30.0,
                      width: 30.0,
                      color: AppColors.accent1Gold,
                    ),
                    Text('Users',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w600,letterSpacing: 0.7),),
                    Text(usersdata,style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w600))
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
                      height: 30.0,
                      width: 30.0,
                      color: AppColors.accent2Turquoise,
                    ),
                    Text('Requests',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w600,letterSpacing: 0.7),),
                    Text(requestdata,style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w600))
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
                      height: 30.0,
                      width: 30.0,
                      color: AppColors.green,
                    ),
                    Text('Feedbacks',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w600,letterSpacing: 0.7),),
                    Text(feeddata,style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w600)),
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
                      height: 30.0,
                      width: 30.0,
                      color: AppColors.red,
                    ),
                    Text('Complaints',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w600,letterSpacing: 0.7),),
                    Text(complaintdata,style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w600))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
