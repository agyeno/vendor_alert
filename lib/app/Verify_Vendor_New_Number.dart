import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:vendor_alert/app/Verify_OTC.dart';

import 'package:http/http.dart' as http;
import '../utils/ApiUrl.dart';
import '../utils/Helper.dart';
import 'Vendor_Profile.dart';


class Verify_Vendor_New_Number extends StatefulWidget {
  const Verify_Vendor_New_Number({Key? key}) : super(key: key);

  @override
  State<Verify_Vendor_New_Number> createState() => _Verify_Vendor_New_NumberState();
}

class _Verify_Vendor_New_NumberState extends State<Verify_Vendor_New_Number> {

  String actor ="",vendorMsg = "", userId= "",number = "" , name= "";

  int apiStatusCode = 0 ;
  String apiMessage = "";
  final Helper helper = new Helper();
  TextEditingController phoneController = TextEditingController();


  @override
  void initState() {
    loadSharedPref();
    super.initState();
  }

  loadSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      actor = (prefs.getString('actor') ?? '');
      if(actor == "vendor"){
        vendorMsg = "VERIFY YOUR NEW MOMO MERCHANT NUMBER";
      } else if(actor == "non-vendor"){
        vendorMsg = "VERIFY YOUR NEW NUMBER";
      }
    });
  }

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
            child: new Text('\n$vendorMsg\n',style: new TextStyle(fontSize: 18.0)),
          ),


          TextField(
            controller: phoneController,
            maxLength: 10,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.phone),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                hintStyle: TextStyle(color: Colors.grey[800]),
                label: Text("Enter New Number"),
                fillColor: Colors.white70),
          ),

          SizedBox(height: 10),


          Container(
            height: 50,
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: ElevatedButton(
              child: Text('Start', style: TextStyle(
                  color: Colors.white),),
              onPressed: () {
                _doNumberChange();

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








  Future<void> _doNumberChange() async{


    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = (prefs.getString('userId') ?? '');


    if (phoneController.text.toString().isEmpty){
      helper.flushBar("Warning", "Please provide phone number", context);
      return;
    }


    SimpleFontelicoProgressDialog progressDialog = SimpleFontelicoProgressDialog(context: context, barrierDimisable:  true);
    progressDialog.show(message: "Loading ...", );

    String basicAuth  = 'Basic '+base64Encode(utf8.encode('${ApiUrl.APIusername}:${ApiUrl.APIpassword}'));
    final response = await http.post(Uri.parse(ApiUrl.changeNumber),
        headers: {
          'Content': 'application/x-www-form-urlencoded',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': '$basicAuth',
          "Access-Control-Allow-Origin": "*", // Required for CORS support to work
        },
        body: jsonEncode(<String, String>{
          'merchantNumber': phoneController.text.toString(),
          'userId': userId,
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

      progressDialog.hide();
      helper.flushBar("Success", apiMessage, context);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('merchantNumber', phoneController.text.toString());

      Timer(Duration(seconds: 3), () async {

        Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => Vendor_Profile()),
              (Route<dynamic> route) => false,);


      });

    }
    else if(apiStatusCode != 200 )  {

      progressDialog.hide();
      helper.alertDialogNoTitle(apiMessage, context);
    }




  }


}
