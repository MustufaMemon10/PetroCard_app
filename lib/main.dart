import 'package:flutter/material.dart';
import 'package:petrocardapppp/splashscreen.dart';

void main() =>
  runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PetroCard(),
    )
  );

class PetroCard extends StatefulWidget {
  const PetroCard({super.key});

  @override
  State<PetroCard> createState() => _PetroCardState();
}

class _PetroCardState extends State<PetroCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplashScreen(),
    );
  }
}
