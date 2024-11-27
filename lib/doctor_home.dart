import 'package:flutter/material.dart';

class DoctorHomePage extends StatelessWidget {


  const DoctorHomePage({super.key}) ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor Home'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Text(
          'Welcome Dr.Uday',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
