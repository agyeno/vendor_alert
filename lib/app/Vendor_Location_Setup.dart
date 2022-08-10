import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



class Vendor_Location_Setup extends StatefulWidget {
  const Vendor_Location_Setup({Key? key}) : super(key: key);

  @override
  State<Vendor_Location_Setup> createState() => _Vendor_Location_SetupState();
}

class _Vendor_Location_SetupState extends State<Vendor_Location_Setup> {



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
      padding: EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[

          SizedBox(height: 50,),

          TextField(
           // controller: strPin,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                filled: true,
                hintStyle: TextStyle(color: Colors.white),
                hintText: "Search area",
                fillColor: Colors.grey),
          ),

          ListTile(
            //leading: const Icon(Icons.location_on),
            title: const Text("DANSOMAN"),
            subtitle: const Text('GHANA', style: TextStyle(
                color: Colors.grey),),
            onTap: () {

              Navigator.of(context).pop();
              // _doLogin();
              //Navigator.push(context, MaterialPageRoute(builder: (context) =>Vendor_Location_Details()),);
            },
          ),

          SizedBox(height: 300),

        ],

      ),
    );
  }





}

