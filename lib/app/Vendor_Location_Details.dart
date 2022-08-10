import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vendor_alert/app/Vendor_Location_Setup.dart';
import '../utils/Helper.dart';

class Vendor_Location_Details extends StatefulWidget {
  const Vendor_Location_Details({Key? key}) : super(key: key);

  @override
  State<Vendor_Location_Details> createState() => _Vendor_Location_DetailsState();
}

class _Vendor_Location_DetailsState extends State<Vendor_Location_Details> {


  String actor ="",vendorMsg = "";

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

      } else if(actor == "non-vendor"){

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*body: SingleChildScrollView(
        child: _userInterface(),
      ),*/
      //backgroundColor: Colors.green.shade180,
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
                  child: new Text(Helper.melerUsers,
                      style: TextStyle(fontSize: 18)),
                ),

              ],
            ),
          ),


          SizedBox(height: 100),

          Center(
            child: Text('Your Location', style: TextStyle(color: Colors.orange),),
          ),
          SizedBox(height: 10),


          new Card(
            child: new Column(
              children: <Widget>[

                ListTile(
                  leading: const Icon(Icons.location_on),
                  title: const Text("DANSOMAN"),
                  subtitle: const Text('GHANA', style: TextStyle(
                      color: Colors.grey),),
                  onTap: () {
                    // _doLogin();
                   //Navigator.push(context, MaterialPageRoute(builder: (context) =>Vendor_Location_Details()),);
                  },
                ),

              ],
            ),
          ),

          SizedBox(height: 100),

          Container(
            height: 50,
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: ElevatedButton(
              child: Text('Add / Change Location', style: TextStyle(
                  color: Colors.white),),
              onPressed: ()  {
                // _getActor("vendor");
                 Navigator.push(context, MaterialPageRoute(builder: (context) =>Vendor_Location_Setup()),);

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




}
