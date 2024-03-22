import 'dart:convert';
import 'package:animate_do/animate_do.dart';
import 'package:card_loading/card_loading.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petrocardapppp/Card/Cardsfield.dart';
import 'package:petrocardapppp/Widgets/Transaction_card.dart';
import 'package:petrocardapppp/utilities/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Widgets/Transaction Text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isDark = false;
  bool isLoading = true;
  List<dynamic> transactions = [];
  String? userId;
  bool hasCard = false;
  var data;
  var logindata;
  bool _isInit = true;

  @override
  void initState() {
    super.initState();
    if (_isInit) {
      fetchTransactionDetails();
      _isInit = false;
    }
  }

  Future<void> fetchTransactionDetails() async {
    SharedPreferences setpreference = await SharedPreferences.getInstance();
    final apiUrl =
        'https://petrocard.000webhostapp.com/API/fetchalltranscations.php';
    try {
      setState(() {
        isLoading = true;
      });
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {'id': setpreference.getString('id')},
      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (!responseData['error']) {
          setState(() {
            transactions = responseData['transactions'];
            isLoading = false;
          });
        } else {
          print('Error fetching user data: ${responseData['message']}');
        }
      } else {
        print('Failed to fetch user data: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching user data: $error');
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _refreshData() async {
    await fetchTransactionDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.white,
      body: RefreshIndicator(
        onRefresh: _refreshData,
        displacement: kToolbarHeight + 60.0,
        color: AppColors.white,
        backgroundColor: AppColors.darkPurple,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor:
                  isDark ? AppColors.darkBackground : AppColors.white,
              elevation: 0,
              pinned: true,
              centerTitle: false,
              stretch: true,
              expandedHeight: 440,
              flexibleSpace: FlexibleSpaceBar(
                background: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                  child: isLoading
                      ? Column(
                          children: [
                            SizedBox(height: 105),
                            CardLoading(
                              height: 0.250.sh,
                              borderRadius: BorderRadius.circular(20.0),
                              animationDuration: Duration(seconds: 2),
                              animationDurationTwo: Duration(seconds: 2),
                              cardLoadingTheme: CardLoadingTheme.defaultTheme,
                              curve: Curves.bounceOut,
                              width: 380.w,
                            ),
                            SizedBox(
                              height: 30.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CardLoading(
                                  height: 50,
                                  width: 50,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                CardLoading(
                                  height: 50,
                                  width: 50,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ],
                            )
                          ],
                        )
                      : Cardsfield(),
                ),
              ),
            ),
            SliverAppBar(
              backgroundColor: isDark
                  ? AppColors.darkTransactionBackground
                  : AppColors.white,
              elevation: 5,
              floating: false,
              pinned: true,
              centerTitle: true,
              bottom: const PreferredSize(
                child: SizedBox(),
                preferredSize: Size.fromHeight(-20.0),
              ),
              flexibleSpace: isLoading
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: CardLoading(
                        height: 50,
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                        color: isDark
                            ? AppColors.darkTransactionBackground
                            : AppColors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20.0),
                        ),
                      ),
                      child: TransactionText(isDark: isDark),
                    ),
            ),
            SliverPadding(
              padding: EdgeInsets.only(
                  bottom: 0.22.sw,
                  top: isLoading
                      ? 0
                      : transactions.isEmpty
                          ? 50
                          : 0),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    if (isLoading) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CardLoading(
                          height: 50,
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                      );
                    } else if (transactions.isEmpty) {
                      return FadeIn(
                        duration: Duration(milliseconds: 250),
                        child: Center(
                          child: Text(
                            'No Transaction',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w700,
                              color: AppColors.red.withRed(170),
                            ),
                          ),
                        ),
                      );
                    }
                    final transaction = transactions[index];
                    final timeStampString = transaction['timestamp'];
                    final timeStamp = DateTime.parse(timeStampString);
                    final formattedTime =
                        DateFormat('MMMM d, yyyy \'at\' hh:mm a')
                            .format(timeStamp);
                    return Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                      child: FadeInUp(
                        duration: Duration(milliseconds: 400),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 14.0, horizontal: 30.0),
                          decoration: BoxDecoration(
                              color: isDark
                                  ? AppColors.darkCardBackground
                                  : AppColors.white,
                              border: Border.all(
                                  width: 0.5, color: AppColors.secondaryText),
                              borderRadius: BorderRadius.circular(20.0),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.black.withOpacity(0.2),
                                  offset: Offset(1, 2),
                                )
                              ]),
                          child: TransactionCard(
                            subTitle: formattedTime,
                            amount: transaction['amount'] ?? '',
                          ),
                        ),
                      ),
                    );
                  },
                  childCount: isLoading
                      ? 5
                      : transactions.isEmpty
                          ? 1
                          : transactions.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
