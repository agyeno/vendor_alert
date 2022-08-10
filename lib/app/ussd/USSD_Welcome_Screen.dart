import 'package:flutter/material.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:vendor_alert/app/Splash.dart';
import 'package:vendor_alert/app/ussd/USSD_Add_NonVendor_Info.dart';
import 'package:vendor_alert/utils/Helper.dart';

import 'USSD_Add_Vendor_Info.dart';

class USSD_Welcome_Screen extends StatefulWidget {
  const USSD_Welcome_Screen({Key? key}) : super(key: key);

  @override
  State<USSD_Welcome_Screen> createState() => _USSD_Welcome_ScreenState();
}

class _USSD_Welcome_ScreenState extends State<USSD_Welcome_Screen> {


  TextEditingController strPin = TextEditingController();
  var ussdController = TextEditingController();
  final Helper helper = new Helper();



  @override
  void initState() {
    _loadUSSD();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*body: SingleChildScrollView(
        child: _userInterface(),
      ),*/
      //backgroundColor: Colors.green.shade200,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/oxy_pro_blue_bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: _userInterface(),
        ),
      ),
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




        ],

      ),
    );
  }


  void _loadUSSD() {

    Timer(Duration(seconds: 1), () async {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Setup MTN Vendor Alert \n1) MTN Vendor \n2) NON - MTN Vendor'),
            content: TextField(
              keyboardType: TextInputType.number,
              maxLength: 1,
              controller: ussdController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: '',
              ),
            ),
            actions: [

              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (context) => Splash()),
                          (Route<dynamic> route) => false,);
                  },
                  child: Text('CANCEL', style: TextStyle(
                      color: Colors.tealAccent),),),


              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    if(ussdController.text == "1"){
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>USSD_Add_Vendor_Info()),);
                    } else if(ussdController.text == "2"){
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>USSD_Add_NonVendor_Info()),);
                    }else {
                      helper.flushBar("Error", "Invalid selection", context);
                      ussdController.text = "";
                      _loadUSSD();
                    }
                  },
                  child: Text('SEND', style: TextStyle(
                      color: Colors.tealAccent),),),
            ],
          ));

    });
  }
}
