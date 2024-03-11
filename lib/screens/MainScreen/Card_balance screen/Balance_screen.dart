import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BalanceScreen extends StatefulWidget {
  @override
  _BalanceScreenState createState() => _BalanceScreenState();
}

class _BalanceScreenState extends State<BalanceScreen> {
  String id = '';
  String userName = '';
  String passcode = '1234';
  String enteredPasscode = '';
  String? balance;
  bool showError = false;

  Future<void> getCardDetails() async {
    SharedPreferences setpreference = await SharedPreferences.getInstance();
    setState(() {
      id = setpreference.getString('id') ?? '';
      userName = setpreference.getString('name') ?? '';
      balance = setpreference.getString('balance') ?? '';
    });
  }

  @override
  void initState() {
    super.initState();
    getCardDetails();
  }

  void verifyPasscode() {
    if (enteredPasscode == passcode) {
      setState(() {
        showError = false;
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BalanceDetails(balance: balance),
        ),
      );
    } else {
      setState(() {
        showError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Passcode'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                onChanged: (value) {
                  enteredPasscode = value;
                },
                keyboardType: TextInputType.number,
                obscureText: true,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'Enter passcode',
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: verifyPasscode,
                child: Text('Submit'),
              ),
              if (showError)
                Text(
                  'Incorrect passcode. Please try again.',
                  style: TextStyle(color: Colors.red),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class BalanceDetails extends StatelessWidget {
  final String? balance;

  const BalanceDetails({Key? key, required this.balance}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Balance Details'),
      ),
      body: Center(
        child: Text(
          'Balance: ${balance ?? "N/A"}',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}
