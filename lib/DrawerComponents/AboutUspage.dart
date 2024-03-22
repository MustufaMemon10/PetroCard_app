import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utilities/colors.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    void _launchPhoneDialer(String phoneNumber) async {
      if (await canLaunch('tel:$phoneNumber')) {
        await launch('tel:$phoneNumber');
      } else {
        throw 'Could not launch $phoneNumber';
      }
    }
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white ,
        title: Text('About Us',style: TextStyle(color: AppColors.darkPurple,fontSize: 20,fontWeight: FontWeight.w600),),
        titleTextStyle: TextStyle(color: Colors.black,fontSize: 20),
        centerTitle: true,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              color: Colors.black.withAlpha(20),
            ),
            child: Icon(Icons.arrow_back_ios_new, color:Colors.black, size: 20),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        actions: <Widget>[
          SizedBox(width: 20,),
        ],
      ),
      body:SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome to Petro Card',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              'At Petro Card, we are dedicated to revolutionizing the way you manage your fuel expenses and travel experiences. Our innovative petro card system empowers users with convenience, security, and savings every time they fuel up.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 24.0),
            Text(
              'Our Mission',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              'Our mission is to simplify and enhance the fueling experience for individuals and businesses alike. We strive to provide a seamless and efficient petro card solution that meets the diverse needs of our users while promoting sustainability and environmental responsibility.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 24.0),
            Text(
              'Key Features',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            _buildFeature('Convenient Fueling',
                'With our petro card, users can easily pay for fuel at thousands of participating gas stations nationwide, eliminating the hassle of carrying cash or multiple credit cards.'),
            _buildFeature('Enhanced Security',
                'We prioritize the security of our users\' accounts and transactions. Our petro card features advanced security measures such as biometric authentication and real-time fraud monitoring to ensure peace of mind.'),
            _buildFeature('Savings and Rewards',
                'Enjoy exclusive discounts, loyalty rewards, and personalized offers with our petro card loyalty program. Earn points for every fuel purchase and redeem them for discounts, free fuel, or partner rewards.'),
            _buildFeature('User-Friendly Mobile App',
                'Our dedicated mobile app provides users with seamless account management, transaction tracking, and fuel station locator features on the go. Stay informed and in control of your fueling activities anytime, anywhere.'),
            _buildFeature('Environmental Initiatives',
                'We are committed to environmental sustainability. Through our petro card system, users can track their carbon footprint, offset emissions, and participate in eco-friendly fueling initiatives.'),
            SizedBox(height: 24.0),
            Text(
              'Get Started Today',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              'Join the Petro Card community and experience the future of fueling. Whether you\'re an individual driver or a business with a fleet of vehicles, our petro card system is designed to meet your needs and exceed your expectations.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 24.0),
            Text(
              'Contact Us',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              'Have questions or feedback? We\'re here to help! Reach out to our customer support team for assistance with your petro card account or any inquiries about our application.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            TextButton(
              onPressed: (){_launchPhoneDialer('+1234567890'); },
              child: Row(
                children: [
                  Text(
                    'Contact Number: ',
                    style: TextStyle(fontSize: 16.0,color: AppColors.darkPurple),
                  ),
                  Text(
                    '+123-45-6789',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeature(String title, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        Text(
          description,
          style: TextStyle(fontSize: 16.0),
        ),
        SizedBox(height: 16.0),
      ],
    );
  }
}
