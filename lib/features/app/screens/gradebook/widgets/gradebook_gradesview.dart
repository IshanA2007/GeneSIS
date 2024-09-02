import 'package:flutter/material.dart';

class GradesView extends StatelessWidget {
  const GradesView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your New View'),
      ),
      body: Center(
        child: Text('This is the new view'),
      ),
    );
  }
}