import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:vendor_alert/app/Vendor_Alert_Intro.dart';
import 'package:http/http.dart' as http;
import '../utils/ApiUrl.dart';
import '../utils/Helper.dart';



class Verify_OTC extends StatefulWidget {
  const Verify_OTC({Key? key}) : super(key: key);

  @override
  State<Verify_OTC> createState() => _Verify_OTCState();
}

class _Verify_OTCState extends State<Verify_OTC> {
  var otcController = TextEditingController();
  int apiStatusCode = 0;
  String apiMessage = "";
  final Helper helper = new Helper();
  String actor ="",vendorMsg = "", userId= "",number = "" , name= "";


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: _userInterface(),
      ),
      backgroundColor: Colors.grey.shade200,
      /*   body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/oxy_pro_blue_bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: _userInterface(),
        ),
      ),*/
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


          SizedBox(height: 150),


          Center(
            child: new Text('\nWE SENT YOU A VERIFICATION CODE\n',style: new TextStyle(fontSize: 18.0)),
          ),



          Container(
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white70,
              borderRadius: BorderRadius.circular(14.0),
            ),
            child: PinFieldAutoFill(
              focusNode: FocusNode(),
              enableInteractiveSelection: false,
              codeLength: 4,
              controller: otcController,
              onCodeChanged: (val) {
                print(val);
                FocusScope.of(context).requestFocus(FocusNode());
              },
            ),
          ),

          SizedBox(height: 10),


          Container(
            height: 50,
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: ElevatedButton(
              child: Text('Verify', style: TextStyle(
                  color: Colors.white),),
              onPressed: () {
                _doRegistration();
                //Navigator.push(context, MaterialPageRoute(builder: (context) =>Vendor_Alert_Intro()),);
              },
              style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                  textStyle: TextStyle(
                      fontSize: 20,fontWeight: FontWeight.bold)),
            ),
          ),


          SizedBox(height: 300),

        ],

      ),
    );
  }











  Future<void> _doRegistration() async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String merchantNumber = (prefs.getString('merchantNumber') ?? '');
    String merchantName = (prefs.getString('merchantName') ?? '');





    if (otcController.text.toString().isEmpty){
      helper.flushBar("Warning", "Please provide OTC", context);
      return;
    }


    SimpleFontelicoProgressDialog progressDialog = SimpleFontelicoProgressDialog(context: context, barrierDimisable:  true);
    progressDialog.show(message: "Loading ...", );

    String basicAuth  = 'Basic '+base64Encode(utf8.encode('${ApiUrl.APIusername}:${ApiUrl.APIpassword}'));
    final response = await http.post(Uri.parse(ApiUrl.register),
        headers: {
          'Content': 'application/x-www-form-urlencoded',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': '$basicAuth',
          "Access-Control-Allow-Origin": "*", // Required for CORS support to work
        },
        body: jsonEncode(<String, String>{
          'merchantNumber': merchantNumber,
          'merchantName': merchantName,
        })

    ).catchError((err) {

      progressDialog.hide();
      helper.alertDialogTitle(Helper.errorMessageOops,Helper.errorMessageSomethingWentWrong, context);
    });


    if(response.statusCode != 200 ){
      progressDialog.hide();
      helper.alertDialogTitle(Helper.errorMessageOops,Helper.errorMessageSomethingWentWrong, context);
    }


    final responseJson  =  jsonDecode(response.body);
    apiStatusCode   =  responseJson["statusCode"].toInt();
    apiMessage      =  responseJson["message"].toString();



    if(apiStatusCode == 200 ){


      final responseJson  =  jsonDecode(response.body);
      String apiResponse  =  responseJson["response"].toString();
      String UserId       =  responseJson["response"][0]["UserId"].toString();
      String MerchantNumber  =  responseJson["response"][0]["MerchantNumber"].toString();
      String MerchantName    =  responseJson["response"][0]["MerchantNumber"].toString();



      progressDialog.hide();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('userId', UserId);
      prefs.setString('isUserLoggedIn', "true");

      helper.flushBar("Success", apiMessage, context);

      Timer(Duration(seconds: 2), () async {

        Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => Vendor_Alert_Intro()),
              (Route<dynamic> route) => false,);


      });


    }
    else if(apiStatusCode != 200 )  {

      progressDialog.hide();
      helper.alertDialogNoTitle(apiMessage, context);
    }




  }





}