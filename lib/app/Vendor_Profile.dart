import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vendor_alert/app/Vendor_Alert_Details.dart';
import 'package:vendor_alert/utils/Helper.dart';

import 'Emergency_Alert_Note.dart';
import 'Vendor_Alert_Call_Centers.dart';
import 'Vendor_Location_Details.dart';
import 'Verify_Vendor_New_Number.dart';



class Vendor_Profile extends StatefulWidget {
  const Vendor_Profile({Key? key}) : super(key: key);




  @override
  State<Vendor_Profile> createState() => _Vendor_ProfileState();
}

class _Vendor_ProfileState extends State<Vendor_Profile> {

  String merchantName = "",merchantNumber = "";
  TextEditingController strPin = TextEditingController();
  TextEditingController strPassword = TextEditingController();
  final Helper helper = new Helper();



  void initState() {
    super.initState();
    _loadNote();
    _loadSharedPref();
  }


  _loadSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      merchantName = (prefs.getString('merchantName') ?? '');
      merchantNumber = (prefs.getString('merchantNumber') ?? '');
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(iconTheme: IconThemeData(
        color: Colors.white, // <-- SEE HERE
      ),title: Text('MTN VENDOR PROFILE', style: TextStyle(
          color: Colors.white),), elevation: 4.0, centerTitle: true,),

      body: SingleChildScrollView(
        child: _userInterface(),
      ),
      backgroundColor: Colors.grey.shade200,
    );
  }


  Widget _userInterface() {
    return Container(
      //color: Colors.black.withOpacity(0.6),
      padding: EdgeInsets.all(30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[


          SizedBox(height: 40),

          new Card(
            child: new Column(
              children: <Widget>[

                ListTile(
                    leading: const Icon(Icons.phone),
                    title:  Text(merchantNumber),
                    subtitle: const Text('Edit Number', style: TextStyle(
                        color: Colors.orange),),
                    onTap: () {
                      // _doLogin();
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>Verify_Vendor_New_Number()),);
                    },
                ),

              ],
            ),
          ),


          SizedBox(height: 10),

          new Card(
            child: new Column(
              children: <Widget>[

                ListTile(
                    leading: const Icon(Icons.location_on),
                    title: const Text("Vendor Location"),
                    subtitle: const Text('Add / Edit Location', style: TextStyle(
                        color: Colors.orange),),
                    onTap: () {
                // _doLogin();
                Navigator.push(context, MaterialPageRoute(builder: (context) =>Vendor_Location_Details()),);
                },
                ),

              ],
            ),
          ),

          SizedBox(height: 10),

          new Card(
            child: new Column(
              children: <Widget>[

                ListTile(
                    leading: const Icon(Icons.alarm),
                    title: const Text("Vendor Alert Details"),
                    subtitle: const Text('Add / Edit Details', style: TextStyle(
                        color: Colors.orange),),
                    onTap: () {
                      // _doLogin();
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>Vendor_Alert_Details()),);
                    },
                ),

              ],
            ),
          ),

          SizedBox(height: 10),

          new Card(
            child: new Column(
              children: <Widget>[

                ListTile(
                    leading: const Icon(Icons.people),
                    title: const Text("Emergency Numbers"),
                    subtitle: const Text('Add / Edit  Numbers', style: TextStyle(
                        color: Colors.orange),),
                    onTap: () {
                      // _doLogin();
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>Emergency_Alert_Note()),);
                    },


                ),

              ],
            ),
          ),

          SizedBox(height: 10),

          Container(
            height: 50,
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: ElevatedButton(
              child: Text('SAVE', style: TextStyle(
                  color: Colors.white),),
              onPressed: () {
                // _doLogin();
                Navigator.push(context, MaterialPageRoute(builder: (context) =>Vendor_Alert_Call_Centers()),);
              },
              style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                  textStyle: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
            ),
          ),

          SizedBox(height: 300),

        ],

      ),
    );
  }






  void _loadNote() {

    Timer(Duration(seconds: 1), () async {
     helper.redButtonDialog("Fill in all the questions on the MTN vendor profile page and click SAVE", context);
    });
  }



}




