import 'dart:convert';
import 'package:animate_do/animate_do.dart';
import 'package:card_loading/card_loading.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
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
  String? userName;
  String? card_num;
  bool hasCard = false;
  var data;
  var logindata;

  @override
  void initState() {
    super.initState();
    fetchTransactionDetails();
    _fetchCardDetails();
    getCardDetails();
  }

  Future<void> _fetchCardDetails() async {
    try {
      SharedPreferences setpreference = await SharedPreferences.getInstance();
      setState(() {
        userId = setpreference.getString('id')!;
      });
      setState(() {
        isLoading = true;
      });
      final loginUrl = Uri.parse(
          "https://petrocard.000webhostapp.com/API/card_data_fetchapi.php?id=$userId");
      final response = await http.get(loginUrl);
      if (response.statusCode == 200) {
        logindata = jsonDecode(response.body);
        data = logindata['data'];
        if (!logindata['error']) {
          SharedPreferences setpreference =
          await SharedPreferences.getInstance();
          setpreference.setString('card_id', data[0]['card_id'].toString());
          setpreference.setString('card_num', data[0]['card_num'].toString());
          setpreference.setString('addedtime', data[0]['addedtime'].toString());
          setpreference.setString('cardlimit', data[0]['cardlimit'].toString());
          setpreference.setString('balance', data[0]['balance'].toString());
          setpreference.setString('status', data[0]['status'].toString());
          setState(() {
            isLoading = false;
          });
        }
      } else {
        print(
            'Failed to get response from server. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }
  Future<void> getCardDetails() async {
    SharedPreferences setpreference = await SharedPreferences.getInstance();
    setState(() {
      userName = setpreference.getString('name') ?? '';
      card_num = setpreference.getString('card_num') ?? '';
    });
  }

  Future<void> fetchTransactionDetails() async {
    SharedPreferences setpreference = await SharedPreferences.getInstance();
    final apiUrl =
        'https://petrocard.000webhostapp.com/API/fetchalltranscations.php';
    try {
      if (mounted) { // Check if the widget is mounted before calling setState
        setState(() {
          isLoading = true;
        });
      }
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
  }

  Future<void> _refreshData() async {
    await fetchTransactionDetails();
    await _fetchCardDetails();
  }


  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.white,
      body: RefreshIndicator(
        onRefresh: _refreshData,
        displacement: kToolbarHeight + 60.0,
        color: AppColors.black,
        backgroundColor: AppColors.white,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor:
              isDark ? AppColors.darkBackground : AppColors.white,
              elevation: 0,
              pinned: true,
              centerTitle: false,
              stretch: true,
              expandedHeight: screenHeight * 0.490, // Adjusted for responsiveness
              flexibleSpace: FlexibleSpaceBar(
                background: Padding(
                  padding: EdgeInsets.only(top: screenHeight * 0.04,left: screenWidth * 0.05,right: screenWidth * 0.05,bottom: 0),
                  child: Cardsfield(userName: userName ?? '',card_num: card_num ?? '',),
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
                preferredSize: Size.fromHeight( -0.20),
              ),
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.darkTransactionBackground
                      : AppColors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(screenWidth * 0.045), // Adjusted for responsiveness
                  ),
                ),
                child: TransactionText(isDark: isDark),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.only(
                  bottom: screenHeight * 0.17, // Adjusted for responsiveness
                  top: isLoading
                      ? 0
                      : transactions.isEmpty
                      ? screenHeight * 0.09 // Adjusted for responsiveness
                      : 0),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    if (isLoading) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CardLoading(
                          height: screenHeight * 0.065, // Adjusted for responsiveness
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                      );
                    } else if (transactions.isEmpty) {
                      return FadeIn(
                        duration: Duration(milliseconds: 550),
                        child: Center(
                          child: Text(
                            'No Transaction',
                            style: TextStyle(
                              fontSize: screenWidth * 0.045, // Adjusted for responsiveness
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
                      padding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.005,
                          horizontal: screenWidth * 0.02),
                      child: FadeInUp(
                        duration: Duration(milliseconds: 400),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.018, // Adjusted for responsiveness
                              horizontal: screenWidth * 0.08), // Adjusted for responsiveness
                          decoration: BoxDecoration(
                              color: isDark
                                  ? AppColors.darkCardBackground
                                  : AppColors.white,
                              border: Border.all(
                                  width: screenWidth * 0.002,
                                  color: AppColors.secondaryText),
                              borderRadius: BorderRadius.circular(20), // Adjusted for responsiveness
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
