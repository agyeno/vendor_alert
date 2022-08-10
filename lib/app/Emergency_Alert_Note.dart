import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vendor_alert/utils/Helper.dart';
import 'Vendor_View_Emergency_Number.dart';


class Emergency_Alert_Note extends StatefulWidget {
  const Emergency_Alert_Note({Key? key}) : super(key: key);

  @override
  State<Emergency_Alert_Note> createState() => _Emergency_Alert_NoteState();
}

class _Emergency_Alert_NoteState extends State<Emergency_Alert_Note> {

  String actor ="",vendorMsg = "";
  final Helper helper = new Helper();



  @override
  void initState() {
    loadSharedPref();
    _loadNote();
    super.initState();
  }

  loadSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      actor = (prefs.getString('actor') ?? '');
      if(actor == "vendor"){
        vendorMsg = Helper.addContactMsg_mtn;
      } else if(actor == "non-vendor"){
        vendorMsg = Helper.addContactMsg_non;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*body: SingleChildScrollView(
        child: _userInterface(),
      ),*/
      backgroundColor: Colors.grey.shade200,
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


          SizedBox(height: 30),

          new Card(
            child: new Column(
              children: <Widget>[
                //new Image.network('https://i.ytimg.com/vi/fq4N0hgOWzU/maxresdefault.jpg'),
                new Padding(
                  padding: new EdgeInsets.all(5.0),
                  child: new Text(Helper.addContactMsg1,
                      style: TextStyle(fontSize: 18)),
                ),

              ],
            ),
          ),

          SizedBox(height: 10),
          Container(
            height: 50,
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: ElevatedButton(
              child: Text('Add Text Alert', style: TextStyle(
                  color: Colors.white),),
              onPressed: ()  {
                // _getActor("vendor");
                 Navigator.push(context, MaterialPageRoute(builder: (context) =>Vendor_View_Emergency_Number()),);

              },
              style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                  textStyle: TextStyle(
                      fontSize: 18,fontWeight: FontWeight.bold)),
            ),
          ),

          SizedBox(height: 30),

          new Card(
            child: new Column(
              children: <Widget>[
                //new Image.network('https://i.ytimg.com/vi/fq4N0hgOWzU/maxresdefault.jpg'),
                new Padding(
                  padding: new EdgeInsets.all(5.0),
                  child: new Text(vendorMsg, style: TextStyle(fontSize: 18)),
                ),

              ],
            ),
          ),

          SizedBox(height: 10),
          Container(
            height: 50,
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: ElevatedButton(
              child: Text('Add Call Alert', style: TextStyle(
                  color: Colors.white),),
              onPressed: ()  {
                // _getActor("vendor");
                 Navigator.push(context, MaterialPageRoute(builder: (context) =>Vendor_View_Emergency_Number()),);

              },
              style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                  textStyle: TextStyle(
                      fontSize: 18,fontWeight: FontWeight.bold)),
            ),
          ),


          SizedBox(height: 300),

        ],

      ),
    );
  }



  void _loadNote() {

    Timer(Duration(seconds: 1), () async {
      helper.redButtonDialog(Helper.emergencyAlertNote, context);
    });
  }


}
