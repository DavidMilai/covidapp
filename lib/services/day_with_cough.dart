import 'package:flutter/material.dart';

class DayWithCough extends StatelessWidget {
  final String day, cough, temp, taste;
  DayWithCough({this.cough, this.day, this.temp, this.taste});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: TextStyle(color: Colors.black),
          children: <TextSpan>[
            TextSpan(
                text: '$day\n', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: '$cough\n'),
            TextSpan(text: 'Taste/smell $taste\n'),
            TextSpan(text: 'Temp $temp'),
          ],
        ),
      ),
    );
  }
}
