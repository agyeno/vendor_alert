import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vendor_alert/app/ussd/USSD_Result_Msg.dart';

import '../../utils/Helper.dart';
import '../Splash.dart';


class USSD_Add_Email extends StatefulWidget {
  const USSD_Add_Email({Key? key}) : super(key: key);

  @override
  State<USSD_Add_Email> createState() => _USSD_Add_EmailState();
}

class _USSD_Add_EmailState extends State<USSD_Add_Email> {

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
            title: Text('E-Mail Address'),
            content: TextField(
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
                  if(ussdController.text != ""){
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>USSD_Result_Msg(message: 'Your vendor details was saved \nsuccessfully',)),);
                  } else if(ussdController.text != " "){
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>USSD_Result_Msg(message: 'Your vendor details was saved \nsuccessfully',)),);
                  }else {
                    helper.flushBar("Error", "Email Address is required", context);
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
