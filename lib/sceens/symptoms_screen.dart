import 'package:flutter/material.dart';

class SymptomScreen extends StatefulWidget {
  @override
  _SymptomScreenState createState() => _SymptomScreenState();
}

class _SymptomScreenState extends State<SymptomScreen> {
  bool cough = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('What symptoms do you have'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            SizedBox(height: 50),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 150),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Temp',
                ),
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text('No cough'),
                    Checkbox(
                        value: cough,
                        onChanged: (value) {
                          setState(() {
                            cough = value;
                          });
                        }),
                  ],
                ),
                Column(
                  children: [
                    Text('Dry cough'),
                    Checkbox(
                        value: cough,
                        onChanged: (value) {
                          setState(() {
                            cough = value;
                          });
                        }),
                  ],
                ),
                Column(
                  children: [
                    Text('Wet cough'),
                    Checkbox(
                        value: cough,
                        onChanged: (value) {
                          setState(() {
                            cough = value;
                          });
                        }),
                  ],
                ),
                Column(
                  children: [
                    Text('Mild cough'),
                    Checkbox(
                        value: cough,
                        onChanged: (value) {
                          setState(() {
                            cough = value;
                          });
                        }),
                  ],
                ),
              ],
            ),
            SizedBox(height: 50),
            Row(
              children: [
                Text('Can you smell or taste anything'),
                Spacer(),
                Column(
                  children: [
                    Text('Yes'),
                    Checkbox(
                        value: cough,
                        onChanged: (value) {
                          setState(() {
                            cough = value;
                          });
                        }),
                  ],
                ),
                Column(
                  children: [
                    Text('No'),
                    Checkbox(
                        value: cough,
                        onChanged: (value) {
                          setState(() {
                            cough = value;
                          });
                        }),
                  ],
                ),
              ],
            ),
            SizedBox(height: 50),
            MaterialButton(
                color: Colors.amber,
                elevation: 2,
                child: Text(
                  'Submit',
                  style: TextStyle(
                      color: Colors.white, letterSpacing: 1, fontSize: 18),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
