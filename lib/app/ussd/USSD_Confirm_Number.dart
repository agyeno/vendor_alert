import 'dart:async';
import 'package:flutter/material.dart';
import 'package:vendor_alert/app/ussd/USSD_Result_Msg.dart';
import '../../utils/Helper.dart';
import '../Splash.dart';


class USSD_Confirm_Number extends StatefulWidget {
  const USSD_Confirm_Number({Key? key}) : super(key: key);

  @override
  State<USSD_Confirm_Number> createState() => _USSD_Confirm_NumberState();
}

class _USSD_Confirm_NumberState extends State<USSD_Confirm_Number> {

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
            title: Text('Confirm Number'),
            content: TextField(
              keyboardType: TextInputType.number,
              maxLength: 10,
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>USSD_Result_Msg(message: "Number saved successfully")),);
                  } else if(ussdController.text != " "){
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>USSD_Result_Msg(message: "Number saved successfully")),);
                  }else {
                    helper.flushBar("Error", "Emergency contact is required", context);
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
