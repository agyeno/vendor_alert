import 'package:flutter/material.dart';
import 'package:vendor_alert/app/Verify_Vendor_Number.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vendor_alert/app/ussd/USSD_Welcome_Screen.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {


  TextEditingController strPin = TextEditingController();
  TextEditingController strPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('MTN VENDOR ALERT', style: TextStyle(
          color: Colors.white),), elevation: 4.0, centerTitle: true,),
      body: SingleChildScrollView(
        child: _userInterface(),
      ),
      backgroundColor: Colors.grey.shade200,
     /* body: Container(
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


          SizedBox(height: 30),

          new Card(
            child: new Column(
              children: <Widget>[
                //new Image.network('https://i.ytimg.com/vi/fq4N0hgOWzU/maxresdefault.jpg'),
                new Padding(
                  padding: new EdgeInsets.all(7.0),
                  child: new Text('\nARE YOU AN MTN VENDOR ? \nSETUP YOUR MTN VENDOR ALERT\n',style: new TextStyle(fontSize: 18.0)),
                ),

              ],
            ),
          ),

          Container(
            height: 50,
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: ElevatedButton(
              child: Text('Start', style: TextStyle(
                  color: Colors.white),),
              onPressed: ()  {
                _getActor("vendor");
                Navigator.push(context, MaterialPageRoute(builder: (context) =>Verify_Vendor_Number()),);

              },
              style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                  textStyle: TextStyle(
                      fontSize: 20,fontWeight: FontWeight.bold)),
            ),
          ),



          SizedBox(height: 30),

          new Card(
            child: new Column(
              children: <Widget>[
                //new Image.network('https://i.ytimg.com/vi/fq4N0hgOWzU/maxresdefault.jpg'),
                new Padding(
                  padding: new EdgeInsets.all(7.0),
                  child: new Text('\nNOT AN MTN VENDOR ? \nSETUP YOUR VENDOR ALERT\n',style: new TextStyle(fontSize: 18.0)),
                ),

              ],
            ),
          ),

          Container(
            height: 50,
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: ElevatedButton(
              child: Text('Start', style: TextStyle(
                  color: Colors.white),),
              onPressed: () {
                _getActor("non-vendor");
                Navigator.push(context, MaterialPageRoute(builder: (context) =>Verify_Vendor_Number()),);
              },
              style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                  textStyle: TextStyle(
                      fontSize: 20,fontWeight: FontWeight.bold)),
            ),
          ),

          SizedBox(height: 30),

          new Card(
            child: new Column(
              children: <Widget>[
                //new Image.network('https://i.ytimg.com/vi/fq4N0hgOWzU/maxresdefault.jpg'),
                new Padding(
                  padding: new EdgeInsets.all(7.0),
                  child: new Text('\nNON SMART PHONE USER\nUSE USSD TO SETUP YOUR VENDOR ALERT\n',style: new TextStyle(fontSize: 18.0)),
                ),

              ],
            ),
          ),

          Container(
            height: 50,
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: ElevatedButton(
              child: Text('Start', style: TextStyle(
                  color: Colors.white),),
              onPressed: () {
                _getActor("ussd");
                Navigator.push(context, MaterialPageRoute(builder: (context) =>USSD_Welcome_Screen()),);
              },
              style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                  textStyle: TextStyle(
                      fontSize: 20,fontWeight: FontWeight.bold)),
            ),
          ),

          SizedBox(height: 10),


          SizedBox(height: 300),

        ],

      ),
    );
  }





  _getActor(String actor) async {
    
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('actor');
    prefs.setString('actor', actor);
    
  }



}
