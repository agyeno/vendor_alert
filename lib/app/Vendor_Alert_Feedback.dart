import 'package:flutter/material.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';

import '../utils/Helper.dart';


class Vendor_Alert_Feedback extends StatefulWidget {
  Vendor_Alert_Feedback({required this.strInfoId });

    String strInfoId;


  @override
  State<Vendor_Alert_Feedback> createState() => _Vendor_Alert_FeedbackState();
}

class _Vendor_Alert_FeedbackState extends State<Vendor_Alert_Feedback> {


  String weapon = "";
  int apiStatusCode = 0;
  String apiMessage = "";
  final Helper helper = new Helper();





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(iconTheme: IconThemeData(
        color: Colors.white, // <-- SEE HERE
      ),title: Text('SEND US FEEDBACK', style: TextStyle(
          color: Colors.white),), elevation: 4.0, centerTitle: true,),

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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[




          SizedBox(height: 10),
          Text('WAS ROBBERY SUCCESSFUL ?',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500,),),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              OutlinedButton(
                onPressed: () {},
                child: Text('YES'),
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(width: 20),
              OutlinedButton(
                onPressed: () {},
                child: Text('NO'),
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),



          SizedBox(height: 20),
          Text('DID ANYONE DIE ?',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500,),),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              OutlinedButton(
                onPressed: () {},
                child: Text('YES'),
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(width: 20),
              OutlinedButton(
                onPressed: () {},
                child: Text('NO'),
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),



          SizedBox(height: 20),
          Text('DID ANYONE GET INJURED ?',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500,),),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              OutlinedButton(
                onPressed: () {},
                child: Text('YES'),
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(width: 20),
              OutlinedButton(
                onPressed: () {},
                child: Text('NO'),
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),



          SizedBox(height: 20),
          Text('DID ANYONE GET CAPTURED ?',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500,),),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              OutlinedButton(
                onPressed: () {},
                child: Text('YES'),
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(width: 20),
              OutlinedButton(
                onPressed: () {},
                child: Text('NO'),
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),



          SizedBox(height: 20),
          Text('WHAT WEAPON DID THE ROBBERS USE ?',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500,),),

          SizedBox(height: 10),
          DropDown(
            items: ["GUN", "KNIFE","STRONG ARMS","WOODEN WEAPON", "METALIC WEAPON","OTHERS"],
            hint: Text("Select Weapon"),
            icon: Icon(
              Icons.expand_more,
              color: Colors.blue,
            ),
            //onChanged: print,
            onChanged: (String? newValue) {
              setState(() {
                weapon = newValue!;
              });
            },
          ),










          SizedBox(height: 10),
          Text('AMOUNT STOLEN ?',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500,),),

          TextField(
            maxLength: 10,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                hintStyle: TextStyle(color: Colors.grey[800]),
                label: Text(""),
                fillColor: Colors.white70),
          ),








          SizedBox(height: 10),
          Text('NUMBER OF ROBBERS ?',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500,),),

          TextField(
            maxLength: 10,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                hintStyle: TextStyle(color: Colors.grey[800]),
                label: Text(""),
                fillColor: Colors.white70),
          ),








          SizedBox(height: 10),
          Text('ADDITIONAL INFORMATION',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500,),),

          TextField(
            keyboardType: TextInputType.multiline,
            minLines: 4,//Normal textInputField will be displayed
            maxLines: 8,//
           // controller: alertMsgController,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                hintStyle: TextStyle(color: Colors.grey),
                fillColor: Colors.white70),
          ),







          SizedBox(height: 30),
          Container(
            height: 50,
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: ElevatedButton(
              child: Text('Send Us Feedback', style: TextStyle(
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

          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 50,
                width: 200,
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child:
                OutlinedButton(
                onPressed: () {},
                child: Text('   False Alarm   '),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(width: 2, color: Colors.orange),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
              SizedBox(width: 20),
              /*Container(
                height: 50,
                width: 200,
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child:
              OutlinedButton(
                onPressed: () {},
                child: Text('   Cancel    '),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(width: 2, color: Colors.orange),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),*/
            ],
          ),
        ],

      ),
    );
  }









}