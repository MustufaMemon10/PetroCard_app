  import 'package:flutter/material.dart';
  import 'package:url_launcher/url_launcher.dart';
  import 'package:flutter_screenutil/flutter_screenutil.dart';
  import 'package:petrocardapppp/utilities/colors.dart';
  import 'package:petrocardapppp/utilities/styles.dart';

  class LocationScreen extends StatefulWidget {
    const LocationScreen({super.key});

    @override
    State<LocationScreen> createState() => _LocationScreenState();
  }

  class _LocationScreenState extends State<LocationScreen> {
    TextEditingController areaController = TextEditingController();
    TextEditingController cityController = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    Future<void> _launchInBrowser(Uri url) async {
      if (!await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      )) {
        throw Exception('Could not launch $url');
      }
    }

    void launchMap() async {
      if (_formKey.currentState!.validate()) {
        String area = areaController.text;
        String city = cityController.text;
        String url =  'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(area)}+${Uri.encodeComponent(city)}+petrol+stations';
        try {
          await _launchInBrowser(Uri.parse(url));
        } catch (e) {
          throw 'Error launching Maps: $e';
        }
      }
    }



    @override
    Widget build(BuildContext context) {
      return  Scaffold(
        resizeToAvoidBottomInset: false,
        body: GestureDetector(
          onTap: (){
            FocusScope.of(context).unfocus();
          },
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 0.21.sh,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0,),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Search Petrol Station",style: AppStyles.locationText,),
                      SizedBox(height: 20.0.h,),
                      TextFormField(
                        controller: areaController,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Area is required';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: 'Area',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide:
                                BorderSide(color: AppColors.lightPurple, width: 2)),
                            filled: true,
                            // Enable filled mode
                            fillColor: Colors.grey[200],
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.darkPurple),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.red),
                              // Customize error border color
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            floatingLabelStyle: const TextStyle(
                                color: AppColors.darkPurple, letterSpacing: 0.7),
                            labelStyle: const TextStyle(
                                color: AppColors.secondaryText, letterSpacing: 0.7),
                            contentPadding:
                            EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        controller: cityController,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'City is required';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'City',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide:
                              BorderSide(color: AppColors.lightPurple, width: 0.5)),
                          filled: true,
                          // Enable filled mode
                          fillColor: Colors.grey[200],
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.darkPurple),
                            // Customize focused border color
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.red),
                            // Customize error border color
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          floatingLabelStyle: const TextStyle(
                              color: AppColors.darkPurple, letterSpacing: 0.7),
                          labelStyle: const TextStyle(
                              color: AppColors.secondaryText, letterSpacing: 0.7),
                          contentPadding:
                          EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Center(
                        child:  Container(
                            height: 55,
                            width: double.infinity,
                            padding: EdgeInsets.only(left: 16,right: 16),
                            margin: EdgeInsets.all(10),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor: AppColors.darkPurple,
                                  side: BorderSide.none,
                                  shape: StadiumBorder(),
                                ),
                                child: const Text('Search',
                                  style: TextStyle(color: Colors.white),),
                                onPressed:(){ FocusScope.of(context).unfocus();
                                launchMap();}
                            )),
                      )
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
