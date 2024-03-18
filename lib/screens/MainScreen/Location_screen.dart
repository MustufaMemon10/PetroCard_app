  import 'package:flutter/material.dart';
  import 'package:url_launcher/url_launcher.dart';
  import 'package:url_launcher/link.dart';
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
    // Future<void> redirectToGoogleMaps(String area, String city) async {
    //   final url = 'https://www.google.com/maps/search/?api=1&query=$area+$city+petrol+stations';
    //   if (await canLaunchUrl(url)) {
    //     await launch(url);
    //   } else {
    //     throw 'Could not launch $url';
    //   }
    // }

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

        body: Form(
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
                      height: 20.0,
                    ),
                    TextFormField(
                      controller: cityController,
                      textInputAction: TextInputAction.go,
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
                    InkWell(
                      onTap: (){
                        FocusScope.of(context).unfocus();
                        launchMap();
                      },
                      child: Center(
                        child: Container(
                          width: 0.6.sw,
                          padding:const EdgeInsets.all(15.0),
                          decoration: BoxDecoration(
                            color: AppColors.darkPurple,
                            borderRadius: BorderRadius.circular(30.0.r),
                            border: Border.all(color: AppColors.white.withOpacity(0.5),width: 0.8)
                          ),
                          child: Center(
                            child: Text(
                              'Search',
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }
  }
