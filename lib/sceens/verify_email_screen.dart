import 'package:covidapp/sceens/home_screen.dart';
import 'package:covidapp/sceens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class VerifyEmailScreen extends StatefulWidget {
  @override
  _VerifyEmailScreenState createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  bool isLoading = false;
  User user = FirebaseAuth.instance.currentUser;
  FirebaseAuth auth = FirebaseAuth.instance;

  String codeValidator(String value) {
    if (value.length < 2) {
      return 'Enter a valid';
    } else {
      return null;
    }
  }

  checkEmail() async {
    if (!user.emailVerified) {
      await user.sendEmailVerification();
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkEmail();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                SizedBox(height: size.height * 0.3),
                Center(
                  child: Text(
                    'Check your email for Verification',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 25),
                MaterialButton(
                    color: Colors.amber,
                    minWidth: 250,
                    elevation: 10,
                    height: size.width / 10,
                    child: Text(
                      'Resend Link',
                      style: TextStyle(
                          color: Colors.white, letterSpacing: 1, fontSize: 18),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      checkEmail();
                      setState(() {
                        isLoading = false;
                      });
                      Fluttertoast.showToast(
                          msg: "Verification link sent to your email address",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.TOP,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }),
                Spacer(),
                Row(
                  children: [
                    Spacer(),
                    GestureDetector(
                      onTap: () async {
                        setState(() {});
                        Navigator.pop(context);
                      },
                      child: Text('Continue', style: TextStyle(fontSize: 20)),
                    ),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
                SizedBox(height: 10)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
