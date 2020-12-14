import 'package:covidapp/sceens/treatment_centers_screen.dart';
import 'package:covidapp/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import 'history_screen.dart';

class SymptomScreen extends StatefulWidget {
  @override
  _SymptomScreenState createState() => _SymptomScreenState();
}

class _SymptomScreenState extends State<SymptomScreen> {
  bool smell = false;
  bool noSmell = false;
  String temp, day, cough;
  DateTime date = DateTime.now();
  User user = FirebaseAuth.instance.currentUser;
  DatabaseService myDataBase;

  @override
  void initState() {
    super.initState();
    day = DateFormat('EEEE').format(date);
    myDataBase = DatabaseService(userEmail: user.email);
  }

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
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: DropdownButton<String>(
                items: <String>[
                  '35.0°C',
                  '35.5°C',
                  '36.0°C',
                  '36.5°C',
                  '37.0°C',
                  '37.5°C',
                  '38.0°C',
                  '38.5°C',
                  '39.0°C',
                  '39.5°C >',
                ].map((String value) {
                  return DropdownMenuItem<String>(
                    child: Text(value),
                    value: value,
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    temp = value;
                  });
                },
                isExpanded: true,
                value: temp,
                hint: Text('Select Temperature'),
              ),
            ),
            SizedBox(height: 50),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: DropdownButton<String>(
                items: <String>[
                  'No cough',
                  'Dry cough',
                  'Wet cough',
                  'Mild cough'
                ].map((String value) {
                  return DropdownMenuItem<String>(
                    child: Text(value),
                    value: value,
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    cough = value;
                  });
                },
                isExpanded: true,
                value: cough,
                hint: Text('Cough type'),
              ),
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
                        value: smell,
                        onChanged: (value) {
                          setState(() {
                            smell = value;
                            noSmell = !smell;
                          });
                        }),
                  ],
                ),
                Column(
                  children: [
                    Text('No'),
                    Checkbox(
                        value: noSmell,
                        onChanged: (value) {
                          setState(() {
                            noSmell = value;
                            smell = !noSmell;
                          });
                        }),
                  ],
                ),
                SizedBox(width: 10),
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
                onPressed: () {
                  if (temp == null || cough == null) {
                    Fluttertoast.showToast(
                        msg: "Please enter your temperature and cough type",
                        gravity: ToastGravity.TOP,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  } else if (smell == false && noSmell == false) {
                    Fluttertoast.showToast(
                        msg: "you haven't ticked anything under smell",
                        gravity: ToastGravity.TOP,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  } else {
                    myDataBase
                        .setUserSymptoms(temp, day, cough, smell)
                        .then((value) {
                      if (temp == '38.0°C' || temp == '38.5°C') {
                        Fluttertoast.showToast(
                            msg: "You need to go to a health facility",
                            gravity: ToastGravity.TOP,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    TreatmentCentersScreen()));
                      } else if (temp == '39.0°C' || temp == '39.5°C >') {
                        Fluttertoast.showToast(
                            msg:
                                "Your temperature is too high need to go to a health facility",
                            gravity: ToastGravity.TOP,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    TreatmentCentersScreen()));
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HistoryScreen()));
                      }
                    });
                  }
                }),
          ],
        ),
      ),
    );
  }
}
