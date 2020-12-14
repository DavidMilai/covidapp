import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class EmailScreen extends StatefulWidget {
  @override
  _EmailScreenState createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hotline'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(height: 30),
            ListTile(
              leading: Icon(Icons.email_outlined),
              title: Text('ps@health.go.ke'),
              onTap: () {
                UrlLauncher.launch("mailto://ps@health.go.ke");
              },
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            SizedBox(height: 30),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text('+254-20-2717077'),
              onTap: () {
                UrlLauncher.launch("tel://07202717077");
              },
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ],
        ),
      ),
    );
  }
}
