import 'package:covidapp/sceens/history_screen.dart';
import 'package:covidapp/sceens/symptoms_screen.dart';
import 'package:covidapp/sceens/treatment_centers_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:covidapp/widgets/detail_card.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'emails.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var data;
  String url =
      'https://disease.sh/v3/covid-19/countries/kenya?yesterday=true&strict=true';
  getData() async {
    setState(() {
      data = null;
    });
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          data = jsonDecode(response.body);
        });
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFF1F1F1),
      appBar: AppBar(
        title: Text('Covid Kenya Cases'),
        centerTitle: true,
        actions: [
          IconButton(icon: Icon(Icons.refresh), onPressed: () => getData())
        ],
      ),
      drawer: Drawer(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(children: [
            DrawerHeader(
                child: Image.asset(
              'assets/user.png',
              color: Colors.amber,
            )),
            ListTile(
              leading: Icon(Icons.healing_rounded),
              title: Text('Personal Wellness'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SymptomScreen()));
              },
            ),
            SizedBox(height: 5),
            ListTile(
              leading: Icon(Icons.history),
              title: Text('History'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HistoryScreen()));
              },
            ),
            SizedBox(height: 5),
            ListTile(
              leading: Icon(Icons.local_hospital_outlined),
              title: Text('Treatment Centers'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TreatmentCentersScreen()));
              },
            ),
            SizedBox(height: 5),
            ListTile(
              leading: Icon(Icons.email_outlined),
              title: Text('Hotline '),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EmailScreen()));
              },
            ),
            Spacer(),
            MaterialButton(
              color: Colors.amber,
              onPressed: () {
                Navigator.popAndPushNamed(context, 'login');
              },
              child: Text(
                'Log out',
                style: TextStyle(letterSpacing: 1, color: Colors.white),
              ),
            )
          ]),
        ),
      ),
      body: Padding(
          padding: EdgeInsets.only(top: 8, left: 8, right: 8),
          child: data != null
              ? SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          DetailCard(
                            size: size,
                            subject: 'infections',
                            imageLocation: 'assets/infection.png',
                            totalCases: data['cases'],
                            newCases: data['todayCases'],
                          ),
                          DetailCard(
                            subject: 'recoveries',
                            size: size,
                            imageLocation: 'assets/recovered.png',
                            totalCases: data['recovered'],
                            newCases: data['todayRecovered'],
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          DetailCard(
                            size: size,
                            subject: 'deaths',
                            imageLocation: 'assets/death.png',
                            totalCases: data['deaths'],
                            newCases: data['todayDeaths'],
                          ),
                          DetailCard(
                            size: size,
                            subject: 'active',
                            imageLocation: 'assets/patient.png',
                            totalCases: data['active'],
                          )
                        ],
                      ),
                    ],
                  ),
                )
              : Center(
                  child: SpinKitWave(
                    color: Colors.amber,
                    size: 80.0,
                  ),
                )),
    );
  }
}
