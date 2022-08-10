import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vendor_alert/app/Splash.dart';
import 'package:vendor_alert/app/Vendor_Profile.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String isUserLoggedIn = "";

  @override
  void initState() {
    _nextPage();
  }

  void _nextPage() {
    Timer(Duration(seconds: 3), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        isUserLoggedIn = (prefs.getString('isUserLoggedIn') ?? '');
      });


      if (isUserLoggedIn == "true") {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Vendor_Profile()),
              (Route<dynamic> route) => false,
        );
      } else {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Splash()),
              (Route<dynamic> route) => false,
        );
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: _userInterface(),
      ),
      //backgroundColor: Colors.green.shade200,
      // body: Container(
      //   decoration: BoxDecoration(
      //     image: DecorationImage(
      //       image: AssetImage("assets/images/clipart_background.png"),
      //       fit: BoxFit.cover,
      //     ),
      //   ),
      //   child:  _userInterface(),
      // ),
    );
  }



  Widget _userInterface (){
    return Container(
      //color: Colors.black.withOpacity(0.6),
      padding: EdgeInsets.all(30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[


          SizedBox(height: 30),


          Image.asset(
            'assets/images/vendor_alert_image.png',
            width: 120,
            height: 120,
          ),

          SizedBox(height: 10),

          Center(
            child:    Text(
              'MTN Vendor Alert ',

              style: TextStyle(
                  color: Colors.orange,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic),
            ),),



          SizedBox(height: 250),


          Center(
            child:    Text(
            'Sponsored By ',
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic),
          ),),

          SizedBox(height: 10),

          Image.asset(
            'assets/images/logo_mtn.png',
            width: 100,
            height: 100,
          ),

          SizedBox(height: 300),

        ],

      ),
    );
  }

}
