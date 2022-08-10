import 'dart:async';
import 'package:flutter/material.dart';
import '../../utils/Helper.dart';
import '../Splash.dart';
import 'USSD_Add_Emergency_Number.dart';
import 'USSD_Add_Name.dart';



class USSD_Add_NonVendor_Info extends StatefulWidget {
  const USSD_Add_NonVendor_Info({Key? key}) : super(key: key);

  @override
  State<USSD_Add_NonVendor_Info> createState() => _USSD_Add_NonVendor_InfoState();
}

class _USSD_Add_NonVendor_InfoState extends State<USSD_Add_NonVendor_Info> {

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
            title: Text('Add Info \n1) Add Vendor Details \n2) Add Emergency Contact Number (Text Alert) \n3) Add Emergency Contact Number (Call Alert)'),
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>USSD_Add_Name()),);
                  } else if(ussdController.text == "2"){
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>USSD_Add_Emergency_Number()),);
                  }else if(ussdController.text == "3"){
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>USSD_Add_Emergency_Number()),);
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
