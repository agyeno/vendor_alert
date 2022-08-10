import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/ApiUrl.dart';
import '../utils/Helper.dart';
import 'Emergency_History.dart';
import 'SplashScreen.dart';
import 'package:http/http.dart' as http;



class Vendor_Alert_Call_Centers extends StatefulWidget {
  const Vendor_Alert_Call_Centers({Key? key}) : super(key: key);

  @override
  State<Vendor_Alert_Call_Centers> createState() => _Vendor_Alert_Call_CentersState();
}

class _Vendor_Alert_Call_CentersState extends State<Vendor_Alert_Call_Centers> {



  int apiStatusCode = 0;
  String apiMessage = "";
  final Helper helper = new Helper();




  @override
  void initState() {
    _loadNote();

    Timer(Duration(seconds: 3), () async {
      redButtonDialog("Click the panic button below when there is a robbery attack for reinforcement ",context);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( iconTheme: IconThemeData(
        color: Colors.white, // <-- SEE HERE
      ),title: Text('EMERGENCY LINES', style: TextStyle(
          color: Colors.white),), elevation: 4.0, centerTitle: true,
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>Emergency_History()),);
                },
                child: Icon(
                  Icons.history,
                  size: 26.0,
                ),
              )
          ),
        ],),

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


          SizedBox(height: 30),




    new Card(
    child: new Column(
    children: <Widget>[

      SizedBox(height: 10),


      Center(
        child: Text('CALL EMERGENCY LINE',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500,),),
      ),


      Divider(color: Colors.black,),
      SizedBox(height: 30),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(width: 160,
                child: Text('POLICE - 191 ',
                  style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w500,),),),
              SizedBox(width: 20),
              OutlinedButton(
                onPressed: () {
                  _makingPhoneCall('191');
                },
                child: Text('Call'),
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),



    ],
          ),

          SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(width: 160,
                child: Text('FIRE SERVICE - 192',
                  style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w500,),),),
              SizedBox(width: 20),
              OutlinedButton(
                onPressed: () {
                  _makingPhoneCall('192');
                },
                child: Text('Call'),
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(width: 160,
                child: Text('AMBULANCE - 193',
                  style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w500,),),),
              SizedBox(width: 20),
              OutlinedButton(
                onPressed: () {
                  _makingPhoneCall('193');
                },
                child: Text('Call'),
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(width: 160,
                child: Text('POLICE HEADQUARTERS - (0302773900)',
                  style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w500,),),),
              SizedBox(width: 20),
              OutlinedButton(
                onPressed: () {
                  _makingPhoneCall('0302773900');

                  },
                child: Text('Call'),
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),

      SizedBox(height: 10),

        ],
      ),
    ),




          SizedBox(height: 30),

          new Card(
            child: new Column(
              children: <Widget>[
                //new Image.network('https://i.ytimg.com/vi/fq4N0hgOWzU/maxresdefault.jpg'),
                new Padding(
                  padding: new EdgeInsets.all(5.0),
                  child: new Text('\nClick the panic button below when there is a robbery attack for reinforcement\n',style: new TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal,color: Colors.black)),
                ),

              ],
            ),
          ),

          SizedBox(height: 10),

          Container(
            height: 50,
            padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
            child: ElevatedButton(
              onPressed: () {
                _doEmergencyRequest();
              },
              style: ElevatedButton.styleFrom(shape:
              new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(20.0),
              ),
                  primary: Colors.yellow),
              child: Text('PANIC BUTTON',
                style: TextStyle(
                    color: Colors.grey),),
            ),

          ),





          SizedBox(height: 30),

          new Card(
            child: new Column(
              children: <Widget>[
                //new Image.network('https://i.ytimg.com/vi/fq4N0hgOWzU/maxresdefault.jpg'),
                new Padding(
                  padding: new EdgeInsets.all(7.0),
                  child: new Text('\nEDIT VENDOR PROFILE\n',style: new TextStyle(fontSize: 16.0)),
                ),

              ],
            ),
          ),

          SizedBox(height: 10),

          Container(
            height: 50,
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: ElevatedButton(
              child: Text('Edit', style: TextStyle(
                  color: Colors.white),),
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                  textStyle: TextStyle(
                      fontSize: 20,fontWeight: FontWeight.bold)),
            ),
          ),


          SizedBox(height: 30),

          // new Card(
          //   child: new Column(
          //     children: <Widget>[
                //new Image.network('https://i.ytimg.com/vi/fq4N0hgOWzU/maxresdefault.jpg'),
                GestureDetector(
                  onTap: ()=>{
                    _promptLogOut(context),
                  },
                  child:   Center(
                    child: Text('\nSIGN OUT\n',style: new TextStyle(color: Colors.grey,fontSize: 16.0, fontWeight: FontWeight.bold)),
                  ),
                ),


          //     ],
          //   ),
          // ),


        ],

      ),
    );
  }





  void _loadNote() {

    Timer(Duration(seconds: 1), () async {
      helper.alertDialogTitle("E-mail Us","Ansahanansi@gmail.com", context);
    });
  }



  void redButtonDialog(String msg, BuildContext cxt) {
    showDialog(
        context: cxt,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(msg),
            actions: [
              ElevatedButton(
                child: Text('GOT IT', style: TextStyle(
                    color: Colors.white),),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    textStyle: TextStyle(
                        fontSize: 20,fontWeight: FontWeight.bold)),
              ),
            ],
          );
        });
  }




  _makingPhoneCall(String number) async {
    var url = Uri.parse("tel: $number");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }







  Future<void> _doEmergencyRequest() async{


    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = (prefs.getString('userId') ?? '');


    SimpleFontelicoProgressDialog progressDialog = SimpleFontelicoProgressDialog(context: context, barrierDimisable:  true);
    progressDialog.show(message: "Loading ...", );

    String basicAuth  = 'Basic '+base64Encode(utf8.encode('${ApiUrl.APIusername}:${ApiUrl.APIpassword}'));
    final response = await http.post(Uri.parse(ApiUrl.manageAlerts),
        headers: {
          'Content': 'application/x-www-form-urlencoded',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': '$basicAuth',
          "Access-Control-Allow-Origin": "*", // Required for CORS support to work
        },
        body: jsonEncode(<String, String>{
          'userId': userId,
          'action': 'create',
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
      final responseJson  =  jsonDecode(response.body);
      apiStatusCode   =  responseJson["statusCode"].toInt();
      apiMessage    =  responseJson["message"].toString();
      helper.flushBar("Success", apiMessage, context);


    }
    else if(apiStatusCode != 200 )  {

      progressDialog.hide();
      helper.alertDialogNoTitle(apiMessage, context);
    }




  }







  _promptLogOut(BuildContext context) async {

    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content:  Text("Do you want to logout  ?"),
        actions: <Widget>[
          TextButton(
            onPressed: () =>{
              Navigator.pop(context),
            },
            child: const Text('Cancel'),
          ),

          TextButton(
            onPressed: () =>{
              Navigator.pop(context),
              _logOut(context)
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );


  }

  _logOut(BuildContext context) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('userId');
    prefs.remove('registrationStatus');
    prefs.remove('merchantNumber');
    prefs.remove('merchantName');
    prefs.remove('isUserLoggedIn');



    Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => SplashScreen()),
          (Route<dynamic> route) => false,);
  }



}
