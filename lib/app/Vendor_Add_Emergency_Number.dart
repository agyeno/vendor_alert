import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:http/http.dart' as http;
import '../utils/ApiUrl.dart';
import '../utils/Helper.dart';


class Vendor_Add_Emergency_Number extends StatefulWidget {
  const Vendor_Add_Emergency_Number({Key? key}) : super(key: key);

  @override
  State<Vendor_Add_Emergency_Number> createState() => _Vendor_Add_Emergency_NumberState();
}

class _Vendor_Add_Emergency_NumberState extends State<Vendor_Add_Emergency_Number> {


  TextEditingController phoneNumberController = TextEditingController();
  String actor ="",vendorMsg = "";
  int apiStatusCode = 0 ;
  String apiMessage = "";
  final Helper helper = new Helper();



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
            child: new Text('ADD EMERGENCY NUMBER',style: new TextStyle(fontSize: 18.0)),
          ),

          SizedBox(height: 30),

          TextField(
            controller: phoneNumberController,
            maxLength: 10,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.phone),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                hintStyle: TextStyle(color: Colors.grey[800]),
                label: Text("Enter Number"),
                fillColor: Colors.white70),
          ),

          SizedBox(height: 30),

          Container(
            height: 50,
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: ElevatedButton(
              child: Text('Save', style: TextStyle(
                  color: Colors.white),),
              onPressed: () {
                  _doAddContact();
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







  Future<void> _doAddContact() async{


    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = (prefs.getString('userId') ?? '');


    if (phoneNumberController.text.toString().isEmpty){
      helper.flushBar("Warning", "Please provide the emergency contact", context);
      return;
    }


    SimpleFontelicoProgressDialog progressDialog = SimpleFontelicoProgressDialog(context: context, barrierDimisable:  true);
    progressDialog.show(message: "Loading ...", );

    String basicAuth  = 'Basic '+base64Encode(utf8.encode('${ApiUrl.APIusername}:${ApiUrl.APIpassword}'));
    final response = await http.post(Uri.parse(ApiUrl.manageContacts),
        headers: {
          'Content': 'application/x-www-form-urlencoded',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': '$basicAuth',
          "Access-Control-Allow-Origin": "*", // Required for CORS support to work
        },
        body: jsonEncode(<String, String>{
          'userId': userId,
          'action':'create',
          'phoneNumber': phoneNumberController.text.toString(),
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
      phoneNumberController.text = "";

    }
    else if(apiStatusCode != 200 )  {

      progressDialog.hide();
      helper.alertDialogNoTitle(apiMessage, context);
    }




  }








}
