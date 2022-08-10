import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vendor_alert/app/ussd/USSD_Add_Vendor_Number.dart';

import '../../utils/Helper.dart';
import '../Splash.dart';


class USSD_Add_GPS_Address extends StatefulWidget {
  const USSD_Add_GPS_Address({Key? key}) : super(key: key);

  @override
  State<USSD_Add_GPS_Address> createState() => _USSD_Add_GPS_AddressState();
}

class _USSD_Add_GPS_AddressState extends State<USSD_Add_GPS_Address> {

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
            title: Text('Ghana Post GPS Address'),
            content: TextField(
              keyboardType: TextInputType.multiline,
              minLines: 4,//Normal textInputField will be displayed
              maxLines: 8,//
              controller: ussdController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'GPS Address of your vendor shop',
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
                  if(ussdController.text != ""){
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>USSD_Add_Vendor_Number()),);
                  } else if(ussdController.text == " "){
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>USSD_Add_Vendor_Number()),);
                  }else {
                    helper.flushBar("Error", "Ghana Post GPS Address is required", context);
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

