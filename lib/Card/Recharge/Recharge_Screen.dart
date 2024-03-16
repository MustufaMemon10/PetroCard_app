import 'package:flutter/material.dart';
import 'package:petrocardapppp/utilities/colors.dart';

class RechargeCardScreen extends StatefulWidget {
  const RechargeCardScreen({super.key});

  @override
  State<RechargeCardScreen> createState() => _RechargeCardScreenState();
}

class _RechargeCardScreenState extends State<RechargeCardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recharge Card',style:TextStyle(
          fontWeight: FontWeight.w700,fontSize: 18.0,color: AppColors.black,
        ),),
        centerTitle: true,
      ),
      body:  Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter Payment Details',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(labelText: 'Card Number'),
            ),
            SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(labelText: 'Expiration Date'),
            ),
            SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(labelText: 'CVV'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement payment logic here
                _handlePayment(context);
              },
              child: Text('Pay Now'),
            ),
          ],
        ),
      ),
    );
  }
}
void _handlePayment(BuildContext context) {
  // Implement your payment logic here
  // You can use payment APIs or mock the payment process for testing
  // After successful payment, you can navigate to a success screen or perform other actions
  // For example:
  // Navigator.push(
  //   context,
  //   MaterialPageRoute(builder: (context) => PaymentSuccessScreen()),
  // );
}
