  import 'dart:convert';
  import 'package:http/http.dart' as http;
  import 'package:flutter/material.dart';
  import 'package:flutter_screenutil/flutter_screenutil.dart';
  import 'package:petrocardapppp/Card/Cardsfield.dart';
  import 'package:petrocardapppp/Widgets/Transaction_card.dart';
  import 'package:petrocardapppp/utilities/colors.dart';
  import 'package:shared_preferences/shared_preferences.dart';

  import '../../Widgets/Transaction Text.dart';
  import '../API/ApiHelper.dart';

  class HomeScreen extends StatefulWidget {
    const HomeScreen({Key? key});

    @override
    State<HomeScreen> createState() => _HomeScreenState();
  }

  class _HomeScreenState extends State<HomeScreen> {
    bool isDark = false;
    bool isLoading = false;
    List<dynamic> transactions = [];
    String? userId;
    bool hasCard = false;
    void _startAnimations() async {
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        isLoading = true;
      });
      await Future.delayed(
          const Duration(seconds: 2));
      setState(() {
        isLoading = false;
      });
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        isLoading = true;
      });
    }


    @override
    void initState() {
      super.initState();
      _startAnimations();
      getId();
    }

    Future<void> fetchTransactionDetails(String id) async {
      final apiUrl = 'https://petrocard.000webhostapp.com/API/fetchalltranscations.php';

      try {
        final response = await http.post(
          Uri.parse(apiUrl),
          body: {'id': id},
        );

        if (response.statusCode == 200) {
          final responseData = jsonDecode(response.body);
          if (!responseData['error']) {
            setState(() {
              transactions = responseData['transactions'];
              isLoading = false;
            });
          }  else {
            print('Error fetching user data: ${responseData['message']}');
          }
        } else {
          print('Failed to fetch user data: ${response.statusCode}');
        }
      } catch (error) {
        print('Error fetching user data: $error');
      }
    }
    Future<void> getId() async {
      SharedPreferences setpreference = await SharedPreferences.getInstance();
      setState(() {
        userId = setpreference.getString('id') ?? '';
      });
      await fetchTransactionDetails(userId!);
    }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: isDark ? AppColors.darkBackground : AppColors.white,

        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: isDark ? AppColors.darkBackground : AppColors.white, // Set app bar color based on isDark
              elevation: 5,
              pinned: true,
              centerTitle: false,
              stretch: true,
              expandedHeight: 0.510.sh,
              flexibleSpace: FlexibleSpaceBar(
                background: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0.w),
                  child: Cardsfield(),
                ),
              ),
            ),
            SliverAppBar(
              backgroundColor: isDark ? AppColors.darkTransactionBackground : AppColors.white, // Set app bar color based on isDark
              elevation: 0,
              pinned: true,
              centerTitle: true,
              bottom: const PreferredSize(
                child: SizedBox(),
                preferredSize: Size.fromHeight(-10.0),
              ),
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkTransactionBackground : AppColors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)), // Rounded top corners
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryPurple.withOpacity(0.2),
                      offset: Offset(10, 5), // Adjust elevation offset
                      blurRadius: 5, // Adjust blur radius
                    ),
                  ],
                ),
                child: TransactionText(isDark: isDark),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  final transaction = transactions[index]; // Assuming you have a list of transactions
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 10.w),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
                      decoration: BoxDecoration(
                          color: isDark ? AppColors.darkCardBackground : AppColors.white,
                          border: Border.all(width: 0.5, color: AppColors.secondaryText),
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primaryPurple.withOpacity(0.2),
                              offset: Offset(1, 2),
                            )
                          ]
                      ),
                      child: TransactionCard(
                        title: transaction['title'] ?? '',
                        subTitle: transaction['timestamp'] ?? '',
                        amount: transaction['amount'] ?? '',
                      ),
                    ),
                  );
                },
                childCount: transactions.length,
              ),
            ),
          ],
        ),
      );
    }
  }


