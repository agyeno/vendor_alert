import 'package:flutter/material.dart';
import 'package:vendor_alert/app/Vendor_Profile.dart';

import '../utils/Helper.dart';


class Vendor_Alert_Intro extends StatefulWidget {
  const Vendor_Alert_Intro({Key? key}) : super(key: key);

  @override
  State<Vendor_Alert_Intro> createState() => _Vendor_Alert_IntroState();
}

class _Vendor_Alert_IntroState extends State<Vendor_Alert_Intro> {




  int apiStatusCode = 0;
  String apiMessage = "";
  final Helper helper = new Helper();




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: _userInterface(),
      ),
      backgroundColor: Colors.grey.shade200,

    );
  }


  Widget _userInterface() {
    return Container(
      padding: EdgeInsets.all(30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[


          SizedBox(height: 10),


          new Card(
            child: new Column(
              children: <Widget>[

                SizedBox(height: 10),

                new Padding(
                  padding: new EdgeInsets.all(10.0),
                  child: new Text(Helper.introText,style: new TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500)),
                ),
                SizedBox(height: 10),



              ],
            ),
          ),



          SizedBox(height: 30),
          Container(
            height: 50,
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: ElevatedButton(
              child: Text('START', style: TextStyle(
                  color: Colors.white),),
              onPressed: () {

                Navigator.push(context, MaterialPageRoute(builder: (context) =>Vendor_Profile()),);
              },
              style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                  textStyle: TextStyle(
                      fontSize: 20,fontWeight: FontWeight.normal)),
            ),
          ),


          SizedBox(height: 10),
          Center(
           child: Text('\nSetup your MTN Vendor Alert\n',style: new TextStyle(color: Colors.grey,fontSize: 16.0, fontWeight: FontWeight.bold)),
          ),
          SizedBox(height: 100),


        ],

      ),
    );
  }




}

